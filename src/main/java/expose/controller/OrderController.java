package expose.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import expose.dao.*;
import expose.model.*;


public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("vieworders".equalsIgnoreCase(action)) {
            viewOrders(request, response);
        } 
        
        if ("orderdetails".equalsIgnoreCase(action)) {
            viewOrderDetails(request, response);
        }
        
        if ("orderhistory".equalsIgnoreCase(action)) {
            viewOrderHistory(request, response);
        }
        
        if ("generateReceipt".equalsIgnoreCase(action)) {
            generateReceipt(request, response);
        }
        
        
        
        if ("listorder".equalsIgnoreCase(action)) {
            viewOrderList(request, response);
        }
        
        if ("updateOrder".equalsIgnoreCase(action)) {
            updateOrder(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("placeorder".equalsIgnoreCase(action)) {
            placeOrder(request, response);
        }
        
        if ("updatestatus".equalsIgnoreCase(action)) {
            updateStatus(request, response);
        }
    }
    
    private void placeOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get customer's cart
            Cart cart = CartDAO.getCartByCustomerId(customer.getId());
            if (cart == null) {
                session.setAttribute("errorMessage", "Your cart is empty.");
                response.sendRedirect("CartController?action=viewcart");
                return;
            }

            // Get cart items
            List<CartItem> cartItems = CartItemDAO.getCartItems(cart.getId());
            if (cartItems.isEmpty()) {
                session.setAttribute("errorMessage", "Your cart is empty.");
                response.sendRedirect("CartController?action=viewcart");
                return;
            }

            // Check stock availability before processing order
            for (CartItem cartItem : cartItems) {
                Product product = ProductDAO.getProduct(cartItem.getProductId());
                if (product == null) {
                    session.setAttribute("errorMessage", "Product not found: ID " + cartItem.getProductId());
                    response.sendRedirect("CartController?action=checkout");
                    return;
                }
                
                if (product.getStock() < cartItem.getQuantity()) {
                    session.setAttribute("errorMessage", 
                        "Insufficient stock for product: " + product.getName() + 
                        ". Available: " + product.getStock() + 
                        ", Requested: " + cartItem.getQuantity());
                    response.sendRedirect("CartController?action=checkout");
                    return;
                }
            }

            // Calculate total amount
            double totalAmount = CartItemDAO.getTotalPriceCart(cart.getId());

            // Create order
            Order newOrder = new Order(customer.getId(), "Failed", totalAmount);
            Order createdOrder = OrderDAO.createOrder(newOrder);

            // Convert cart items to order items
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem cartItem : cartItems) {
                OrderItem orderItem = new OrderItem(
                    createdOrder.getId(),
                    cartItem.getProductId(),
                    cartItem.getQuantity(),
                    cartItem.getPrice()
                );
                orderItems.add(orderItem);
            }

            // Add order items
            boolean orderItemsAdded = OrderItemDAO.addOrderItems(orderItems);

            if (orderItemsAdded) {
                // Update product quantities (reduce stock)
				/*
				 * boolean stockUpdated = true; for (CartItem cartItem : cartItems) { boolean
				 * updated = ProductDAO.updateProductQuantity( cartItem.getProductId(),
				 * -cartItem.getQuantity() // Negative value to reduce stock ); if (!updated) {
				 * stockUpdated = false; break; } }
				 * 
				 * if (!stockUpdated) { // If stock update fails, you might want to rollback the
				 * order session.setAttribute("errorMessage", "Error updating product stock.");
				 * response.sendRedirect("CartController?action=checkout"); return; }
				 */

                // Clear the cart after successful order
                CartItemDAO.clearCartItems(cart.getId());

                // Update cart count in session
                session.setAttribute("cartCount", 0);

                // ========== TOYYIBPAY INTEGRATION ==========
                
                // Convert amount to cents (multiply by 100)
                Double testMoneyAmount=1.0;
				/* int amountInCents = (int) (totalAmount * 100); */
                int amountInCents = (int) (testMoneyAmount * 100);
                // Prepare ToyyibPay data
                Map<String, String> toyyibPayData = new HashMap<>();
                toyyibPayData.put("userSecretKey", "ENTER-YOUR-OWN-KEY");
                toyyibPayData.put("categoryCode", "ENTER-YOUR-OWN-KEY");
                toyyibPayData.put("billName", "Order #" + createdOrder.getId());
                toyyibPayData.put("billDescription", "Payment for order #" + createdOrder.getId() + " amount RM" + String.format("%.2f", totalAmount));
                toyyibPayData.put("billPriceSetting", "1");
                toyyibPayData.put("billPayorInfo", "1");
                toyyibPayData.put("billAmount", String.valueOf(amountInCents));
                toyyibPayData.put("billReturnUrl", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/PaymentController?action=success");
                toyyibPayData.put("billCallbackUrl", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/PaymentController?action=callback");
                toyyibPayData.put("billExternalReferenceNo", String.valueOf(createdOrder.getId()));
                toyyibPayData.put("billTo", customer.getName());
                toyyibPayData.put("billEmail", customer.getEmail());
                toyyibPayData.put("billPhone", customer.getPhone() != null ? customer.getPhone() : "");
                toyyibPayData.put("billSplitPayment", "0");
                toyyibPayData.put("billSplitPaymentArgs", "");
                toyyibPayData.put("billPaymentChannel", "0");

                // Create ToyyibPay bill using HTTP client
                String billCode = createToyyibPayBill(toyyibPayData);
                
                if (billCode != null && !billCode.isEmpty()) {
                    // Create payment record
                    Payment payment = new Payment(
                        null,                    // transactionNo - will be updated after payment
                        totalAmount,             // amount
                        "Failed",              // status
                        "ToyyibPay",            // method
                        billCode,               // billcode
                        createdOrder.getId()    // orderId
                    );
                    
                    // Insert payment into database
                    boolean paymentCreated = PaymentDAO.createPayment(payment);
                    
                    if (paymentCreated) {
                        // Set success message
                        session.setAttribute("successMessage",
                            "Order created successfully! Order ID: #" + createdOrder.getId());
                        
                        // Redirect to ToyyibPay payment page
                        response.sendRedirect("https://toyyibpay.com/" + billCode);
                    } else {
                        session.setAttribute("errorMessage", "Error creating payment record.");
                        response.sendRedirect("CartController?action=checkout");
                    }
                } else {
                    session.setAttribute("errorMessage", "Error creating payment gateway bill.");
                    response.sendRedirect("CartController?action=checkout");
                }

            } else {
                session.setAttribute("errorMessage", "Error creating order items.");
                response.sendRedirect("CartController?action=checkout");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error placing order: " + e.getMessage());
            response.sendRedirect("CartController?action=checkout");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error processing payment: " + e.getMessage());
            response.sendRedirect("CartController?action=checkout");
        }
    }

    private String createToyyibPayBill(Map<String, String> data) {
        try {
            // Create URL connection
            URL url = new URL("https://toyyibpay.com/index.php/api/createBill");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            // Build POST data
            StringBuilder postData = new StringBuilder();
            for (Map.Entry<String, String> entry : data.entrySet()) {
                if (postData.length() > 0) {
                    postData.append('&');
                }
                postData.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
                postData.append('=');
                postData.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
            }

            // Send POST data
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = postData.toString().getBytes("UTF-8");
                os.write(input, 0, input.length);
            }

            // Read response
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
            }

            // Parse JSON response
            String jsonResponse = response.toString();
            
            // Simple JSON parsing to extract BillCode
            // You might want to use a proper JSON library like Jackson or Gson
            if (jsonResponse.contains("BillCode")) {
                int startIndex = jsonResponse.indexOf("\"BillCode\":\"") + 12;
                int endIndex = jsonResponse.indexOf("\"", startIndex);
                if (startIndex > 11 && endIndex > startIndex) {
                    return jsonResponse.substring(startIndex, endIndex);
                }
            }
            
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // View customer's orders
    private void viewOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            List<Order> orders = OrderDAO.getOrdersByCustomerId(customer.getId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading orders.");
        }
    }
    
    // View order details
    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	 HttpSession session = request.getSession();
         Customer customer = (Customer) session.getAttribute("customer");
         
         if (customer == null) {
             response.sendRedirect("login.jsp");
             return;
         }
        
        String orderIdStr = request.getParameter("orderId");
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = OrderDAO.getOrderById(orderId);
            List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderId(orderId);
            
            Payment payment = PaymentDAO.getPaymentByOrderId(orderId);
            Double subTotalPrice = OrderItemDAO.getTotalPriceOrder(orderId);

          
            request.setAttribute("subTotalPrice", subTotalPrice);
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("order-details.jsp").forward(request, response);
            
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading order details.");
        }
    }
    
    private void viewOrderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }
     
        try {
           
            List<Order> orders = OrderDAO.getOrdersByCustomerId(customer.getId());  
            
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("order-history.jsp").forward(request, response);
            
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading order details.");
        }
    }
    
    private void generateReceipt(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
  
        
      
        try {
           
        	  int orderId = Integer.parseInt(request.getParameter("oid"));
              Order order = OrderDAO.getOrderById(orderId);
           
              
              List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderId(orderId);
              Payment payment = PaymentDAO.getPaymentByOrderId(orderId);
              request.setAttribute("order", order);
              request.setAttribute("payment", payment);
              request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("receipt.jsp").forward(request, response);
            
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading order details.");
        }
    }
    
    private void viewOrderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        Employee customer = (Employee) session.getAttribute("employee");
        
        if (customer == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }
     
        try {
           
            List<Order> orders = OrderDAO.getAllOrders();  
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("admin/listOrder.jsp").forward(request, response);
            
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading order details.");
        }
    }
    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	 try {
             
       	     int orderId = Integer.parseInt(request.getParameter("oid"));
             Order order = OrderDAO.getOrderById(orderId);
             
             List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderId(orderId);
            
             request.setAttribute("order", order);
             request.setAttribute("orderItems", orderItems);
           request.getRequestDispatcher("admin/updateOrder.jsp").forward(request, response);
           
       } catch (NumberFormatException | SQLException e) {
           e.printStackTrace();
           response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading order details.");
       }
    }
    
    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	 try {
             
       	     int orderId = Integer.parseInt(request.getParameter("orderId"));
       	     String status = request.getParameter("status");
       	     OrderDAO.updateOrderStatus(orderId, status);
       	     
       	     
             HttpSession session = request.getSession(true);
             session.setAttribute("successMessage", "Order status updated successfully!");
             response.sendRedirect("OrderController?action=listOrder");
           
       } catch (NumberFormatException | SQLException e) {
           e.printStackTrace();
           response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading order details.");
       }
    }
    

    
}
