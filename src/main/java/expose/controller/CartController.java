package expose.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import expose.dao.CartDAO;
import expose.dao.CartItemDAO;
import expose.dao.EmployeeDAO;
import expose.dao.ProductDAO;
import expose.model.Cart;
import expose.model.CartItem;
import expose.model.Customer;
import expose.model.Employee;
import expose.model.Product;

/**
 * Servlet implementation class CartController
 */

public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("viewcart".equalsIgnoreCase(action)) {
			HttpSession session = request.getSession(true);

			if (session.getAttribute("customer") == null) {
				response.sendRedirect("login.jsp");
				return;
			}

			Customer customer = (Customer) session.getAttribute("customer");
			int custId = customer.getId();

			try {
				Cart cart = CartDAO.getCartByCustomerId(custId);
				int cartId = cart.getId();

				List<CartItem> cartItems = CartItemDAO.getCartItems(cartId);
				Double subTotalPrice = CartItemDAO.getTotalPriceCart(cartId);

				request.setAttribute("cartItems", cartItems);
				request.setAttribute("subTotalPrice", subTotalPrice);
				request.getRequestDispatcher("cart.jsp").forward(request, response);

			} catch (SQLException e) {
				e.printStackTrace();
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cart.");
			}
		}

		if ("checkout".equalsIgnoreCase(action)) {
		    HttpSession session = request.getSession(true);

		    if (session.getAttribute("customer") == null) {
		        response.sendRedirect("login.jsp");
		        return;
		    }

		    Customer customer = (Customer) session.getAttribute("customer");
		    int custId = customer.getId();

		    try {
		        Cart cart = CartDAO.getCartByCustomerId(custId);
		        int cartId = cart.getId();
		        List<CartItem> cartItems = CartItemDAO.getCartItems(cartId);

		        if (cartItems == null || cartItems.isEmpty()) {
		            session.setAttribute("errorMessage", "Your cart is empty.");
		            response.sendRedirect("CartController?action=viewcart");
		            return;
		        }

		        // Check stock availability for each cart item
		        StringBuilder stockErrorMessage = new StringBuilder();
		        boolean hasStockError = false;
		        
		        for (CartItem cartItem : cartItems) {
		            try {
		                Product product = ProductDAO.getProduct(cartItem.getProductId()); // Assuming you have this method
		                if (product != null && cartItem.getQuantity() > product.getStock()) {
		                    hasStockError = true;
		                    stockErrorMessage.append("Product '")
		                                   .append(product.getName()) // Assuming product has getName() method
		                                   .append("' has insufficient stock. Available: ")
		                                   .append(product.getStock())
		                                   .append(", Requested: ")
		                                   .append(cartItem.getQuantity())
		                                   .append(", Please reduce the quantity of this item")
		                                   .append(". ");
		                }
		            } catch (SQLException e) {
		                e.printStackTrace();
		                // Handle individual product lookup error
		                hasStockError = true;
		                stockErrorMessage.append("Error checking stock for product ID: ")
		                                .append(cartItem.getProductId())
		                                .append(". ");
		            }
		        }

		        // If there are stock errors, redirect back to cart with error message
		        if (hasStockError) {
		            session.setAttribute("errorMessage", stockErrorMessage.toString().trim());
		            response.sendRedirect("CartController?action=viewcart");
		            return;
		        }

		        Double subTotalPrice = CartItemDAO.getTotalPriceCart(cartId);

		        request.setAttribute("cartItems", cartItems);
		        request.setAttribute("subTotalPrice", subTotalPrice);
		        request.getRequestDispatcher("checkout.jsp").forward(request, response);

		    } catch (SQLException e) {
		        e.printStackTrace();
		        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cart.");
		    }
		}

		if ("delete".equals(action)) {
			String itemIdStr = request.getParameter("cid");
			String prodIdStr = request.getParameter("pid");

			try {
				int itemId = Integer.parseInt(itemIdStr);
				int prodId = Integer.parseInt(prodIdStr);
				// Delete item using DAO
				CartItemDAO.deleteCartItem(itemId, prodId);

				// Redirect back to cart page
				HttpSession session = request.getSession(true);
				int updatedCount = CartItemDAO.getTotalItemsInCart(itemId);
				session.setAttribute("cartCount", updatedCount);
				session.setAttribute("successMessage", "Item successfully deleted.");
				response.sendRedirect("CartController?action=viewCart");

			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
				// Optionally redirect with an error message
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Error deleting item.");
				response.sendRedirect("CartController?action=viewCart");
			}

		}

		if ("clearcart".equals(action)) {
			
			HttpSession session = request.getSession(true);
			Customer customer = (Customer) session.getAttribute("customer");
			int custId = customer.getId();
		

			try {
				Cart cart = CartDAO.getCartByCustomerId(custId);
				int cartId = cart.getId();
				CartItemDAO.clearCartItems(cartId);

				// Redirect back to cart page

				int updatedCount = CartItemDAO.getTotalItemsInCart(cartId);
				session.setAttribute("cartCount", updatedCount);
				session.setAttribute("successMessage", "Cart successfully cleared!");
				response.sendRedirect("CartController?action=viewCart");

			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
				// Optionally redirect with an error message
				
				session.setAttribute("errorMessage", "Error clearing cart.");
				response.sendRedirect("CartController?action=viewCart");
			}

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		HttpSession session = request.getSession(true);

		if (session.getAttribute("customer") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		switch (action) {
		case "create":
			store(request, response);
			break;
		case "update":
			edit(request, response);
			break;

		default:
			response.sendRedirect("CartController?action=viewCart");
		}
	}

	private void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Customer cust = (Customer) session.getAttribute("customer");
			int custId = cust.getId();

			Cart cart = CartDAO.getCartByCustomerId(custId);
			int cartId = (cart == null) ? CartDAO.createCart(custId).getId() : cart.getId();

			int prodId = Integer.parseInt(request.getParameter("productId"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			double price = Double.parseDouble(request.getParameter("price"));

			// Get product to check stock availability
			Product product = ProductDAO.getProduct(prodId);
			if (product == null) {
				session.setAttribute("errorMessage", "Product not found.");
				response.sendRedirect("ProductController?action=viewProducts&pid=" + prodId);
				return;
			}

			int availableStock = product.getStock();

			// Check if product is out of stock
			if (availableStock <= 0) {
				session.setAttribute("errorMessage", "Sorry, '" + product.getName() + "' is currently out of stock.");
				response.sendRedirect("ProductController?action=viewProduct&pid=" + prodId);
				return;
			}

			// Check if item already exists in cart
			if (CartItemDAO.itemExists(cartId, prodId)) {
				CartItem existingItem = CartItemDAO.getCartItem(cartId, prodId);
				int currentCartQuantity = existingItem.getQuantity();
				int totalRequestedQuantity = currentCartQuantity + quantity;

				// Validate total quantity against stock
				if (totalRequestedQuantity > availableStock) {
					int maxCanAdd = availableStock - currentCartQuantity;
					if (maxCanAdd <= 0) {
						session.setAttribute("errorMessage", "You already have the maximum available quantity ("
								+ currentCartQuantity + ") for '" + product.getName() + "' in your cart.");
					} else {
						session.setAttribute("errorMessage",
								"Cannot add " + quantity + " more items of '" + product.getName() + "'. "
										+ "You currently have " + currentCartQuantity + " in cart. " + "You can add "
										+ maxCanAdd + " more (Total stock: " + availableStock + ").");
					}
					response.sendRedirect("ProductController?action=viewProduct&pid=" + prodId);
					return;
				}

				// Update existing item
				existingItem.setQuantity(totalRequestedQuantity);
				existingItem.setPrice(price);
				CartItemDAO.updateCartItem(existingItem);

			} else {
				// Validate new quantity against stock
				if (quantity > availableStock) {
					session.setAttribute("errorMessage", "Cannot add " + quantity + " items of '" + product.getName()
							+ "'. " + "Only " + availableStock + " items available in stock.");
					response.sendRedirect("ProductController?action=viewProduct&pid=" + prodId);
					return;
				}

				// Add new item to cart
				CartItem item = new CartItem();
				item.setCartId(cartId);
				item.setProductId(prodId);
				item.setQuantity(quantity);
				item.setPrice(price);
				CartItemDAO.addCartItem(item);
			}

			int updatedCount = CartItemDAO.getTotalItemsInCart(cartId);
			session.setAttribute("cartCount", updatedCount);
			session.setAttribute("successMessage",
					quantity + " item(s) of '" + product.getName() + "' successfully added to cart.");
			response.sendRedirect("CartController?action=viewCart");

		} catch (NumberFormatException e) {
			HttpSession session = request.getSession();
			session.setAttribute("errorMessage", "Invalid input format.");
			response.sendRedirect("ProductController?action=viewProducts&pid=" + request.getParameter("productId"));
		} catch (Exception e) {
			throw new ServletException("Error in store: " + e.getMessage(), e);
		}
	}

	private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        HttpSession session = request.getSession();
	        Customer cust = (Customer) session.getAttribute("customer");
	        int custId = cust.getId();

	        Cart cart = CartDAO.getCartByCustomerId(custId);
	        if (cart == null) {
	            response.sendRedirect("cart.jsp");
	            return;
	        }

	        int prodId = Integer.parseInt(request.getParameter("pid"));
	        int quantity = Integer.parseInt(request.getParameter("quantity"));

	        // Validate stock availability before updating
	        Product product = ProductDAO.getProduct(prodId); // Assuming you have this method
	        if (product == null) {
	            session.setAttribute("errorMessage", "Product not found.");
	            response.sendRedirect("CartController?action=viewCart");
	            return;
	        }

	        if (quantity > product.getStock()) {
	            session.setAttribute("errorMessage", 
	                "Cannot update quantity. Only " + product.getStock() + 
	                " items available in stock for " + product.getName() + ".");
	            response.sendRedirect("CartController?action=viewCart");
	            return;
	        }

	        // Additional validation for negative or zero quantities
	        if (quantity <= 0) {
	            session.setAttribute("errorMessage", "Quantity must be greater than 0.");
	            response.sendRedirect("CartController?action=viewCart");
	            return;
	        }

	        CartItem item = new CartItem();
	        item.setCartId(cart.getId());
	        item.setProductId(prodId);
	        item.setQuantity(quantity);

	        CartItemDAO.updateCartItem(item);

	        int updatedCount = CartItemDAO.getTotalItemsInCart(cart.getId());
	        session.setAttribute("cartCount", updatedCount);

	        session.setAttribute("successMessage", "Item successfully updated.");
	        response.sendRedirect("CartController?action=viewCart");

	    } catch (NumberFormatException e) {
	        HttpSession session = request.getSession();
	        session.setAttribute("errorMessage", "Invalid quantity or product ID.");
	        response.sendRedirect("CartController?action=viewCart");
	    } catch (SQLException e) {
	        e.printStackTrace();
	        HttpSession session = request.getSession();
	        session.setAttribute("errorMessage", "Database error occurred while updating cart.");
	        response.sendRedirect("CartController?action=viewCart");
	    } catch (Exception e) {
	        throw new ServletException("Error in edit: " + e.getMessage(), e);
	    }
	}

}
