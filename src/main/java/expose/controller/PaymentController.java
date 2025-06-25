package expose.controller;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import expose.dao.OrderDAO;
import expose.dao.PaymentDAO;
import expose.dao.OrderItemDAO;
import expose.dao.ProductDAO;
import expose.model.Payment;
import expose.model.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PaymentController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        switch (action.toLowerCase()) {
            case "success":
                handlePaymentSuccess(request, response);
                break;
            case "callback":
                handlePaymentCallback(request, response);
                break;
            case "failed":
                handlePaymentFailed(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }
    
    private void handlePaymentSuccess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String billCode = request.getParameter("billcode");
        String statusId = request.getParameter("status_id");
        String orderId = request.getParameter("order_id");
        
        try {
            if (billCode != null && statusId != null) {
                // Update payment status based on ToyyibPay response
                String paymentStatus = getPaymentStatus(statusId);
                PaymentDAO.updatePaymentStatusOnly(billCode, paymentStatus);
                
                // Get payment details
                Payment payment = PaymentDAO.getPaymentByBillCode(billCode);
                
                if (payment != null && "Completed".equals(paymentStatus)) {
                    // Update order status to processing
                    OrderDAO.updateOrderStatus(payment.getOrderId(), "Processing");
                    
                    // Reduce product stock based on order items
                    boolean stockUpdated = reduceProductStock(payment.getOrderId());
                    
                    if (stockUpdated) {
                        session.setAttribute("successMessage", 
                            "Payment successful! Your order #" + payment.getOrderId() + " has been confirmed.");
                        response.sendRedirect("OrderController?action=orderdetails&orderId=" + payment.getOrderId());
                    } else {
                        // If stock update failed, mark order as failed
                        OrderDAO.updateOrderStatus(payment.getOrderId(), "Failed");
                        session.setAttribute("errorMessage", "Payment successful but stock update failed. Please contact support.");
                        response.sendRedirect("OrderController?action=orderdetails&orderId=" + payment.getOrderId());
                    }
                } else {
                    if (payment != null) {
                        OrderDAO.updateOrderStatus(payment.getOrderId(), "Failed");
                    }
                    session.setAttribute("errorMessage", "Payment verification failed.");
                    response.sendRedirect("OrderController?action=orderHistory");
                }
            } else {
                session.setAttribute("errorMessage", "Invalid payment response.");
                response.sendRedirect("OrderController?action=orderHistory");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error processing payment: " + e.getMessage());
            response.sendRedirect("OrderController?action=orderHistory");
        }
    }
    
    /**
     * Reduces product stock based on order items when payment is successful
     * @param orderId The order ID to process
     * @return true if stock was successfully updated, false otherwise
     */
    private boolean reduceProductStock(int orderId) {
        try {
            // Get all order items for this order
            List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderId(orderId);
            
            if (orderItems == null || orderItems.isEmpty()) {
                System.out.println("No order items found for order ID: " + orderId);
                return false;
            }
            
            // Update stock for each product in the order
            for (OrderItem orderItem : orderItems) {
                boolean updated = ProductDAO.updateProductQuantity(
                    orderItem.getProductId(), 
                    -orderItem.getQuantity()  // Negative value to reduce stock
                );
                
                if (!updated) {
                    System.out.println("Failed to update stock for product ID: " + orderItem.getProductId());
                    return false;
                }
                
                System.out.println("Reduced stock for product ID " + orderItem.getProductId() + 
                                 " by " + orderItem.getQuantity() + " units");
            }
            
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error reducing product stock: " + e.getMessage());
            return false;
        }
    }
    
    private void handlePaymentCallback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // This is called by ToyyibPay server for payment notifications
        String billCode = request.getParameter("billcode");
        String statusId = request.getParameter("status_id");
        String orderId = request.getParameter("order_id");
        
        try {
            if (billCode != null && statusId != null) {
                String paymentStatus = getPaymentStatus(statusId);
                PaymentDAO.updatePaymentStatusOnly(billCode, paymentStatus);
                
                // Get payment details
                Payment payment = PaymentDAO.getPaymentByBillCode(billCode);
                
                if (payment != null && "Completed".equals(paymentStatus)) {
                    // Update order status to processing
                    OrderDAO.updateOrderStatus(payment.getOrderId(), "Processing");
                    
                    // Reduce product stock based on order items
                    reduceProductStock(payment.getOrderId());
                }
                
                // Send OK response to ToyyibPay
                response.getWriter().write("OK");
            } else {
                response.getWriter().write("FAILED");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }
    
    private void handlePaymentFailed(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String billCode = request.getParameter("billcode");
        
        try {
            if (billCode != null) {
                PaymentDAO.updatePaymentStatusOnly(billCode, "Failed");
                
                Payment payment = PaymentDAO.getPaymentByBillCode(billCode);
                if (payment != null) {
                    // Update order status to failed
                    OrderDAO.updateOrderStatus(payment.getOrderId(), "Failed");
                }
            }
            
            session.setAttribute("errorMessage", "Payment was cancelled or failed.");
            response.sendRedirect("OrderController?action=orderHistory");
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error processing payment failure: " + e.getMessage());
            response.sendRedirect("OrderController?action=orderHistory");
        }
    }
    
    private String getPaymentStatus(String statusId) {
        // ToyyibPay status mapping
        switch (statusId) {
            case "1":
                return "Completed";
            case "2":
                return "Pending";
            case "3":
                return "Failed";
            default:
                return "Unknown";
        }
    }
}