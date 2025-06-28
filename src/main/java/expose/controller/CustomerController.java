package expose.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import expose.dao.CartDAO;
import expose.dao.CartItemDAO;
import expose.dao.CustomerDAO;
import expose.dao.OrderDAO;
import expose.model.Cart;
import expose.model.Customer;



/**
 * Servlet implementation class CustomerController
 */
@MultipartConfig
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private HttpSession session;
	String action = "";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomerController() {
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

		if (action.equalsIgnoreCase("logout")) {

			try {
				// get the current session
				session = request.getSession(true);
				// set current session to null.

				session.setAttribute("cartCount", null);
				session.setAttribute("customer", null);
				// destroy session
				session.invalidate();
				
				HttpSession session = request.getSession(true);
				session.setAttribute("successMessage", "Successfully Logged out.");
				response.sendRedirect("login.jsp");
			} catch (Throwable ex) {
				ex.printStackTrace();
			}
		}

		if (action.equalsIgnoreCase("profile")) {

			HttpSession session = request.getSession(true);

			Customer cust = (Customer) session.getAttribute("customer");
			int custId = cust.getId();

			
			try {
				cust = CustomerDAO.getCustomer(custId);
				Double totalSpentAmount = OrderDAO.getTotalPriceOrder(custId);
				int totalOrder = OrderDAO.getTotalOrders(custId);
				String lastOrderDate = OrderDAO.getLastOrder(custId);

				request.setAttribute("customer", cust);
				request.setAttribute("totalSpentAmount", totalSpentAmount);
				request.setAttribute("totalOrder", totalOrder);
				request.setAttribute("lastOrderDate", lastOrderDate);
				RequestDispatcher view = request.getRequestDispatcher("profile.jsp"); // staff page
				view.forward(request, response);
				
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		switch (action.toLowerCase()) {
		case "create":
			register(request, response);
			break;

		case "login":
			login(request, response);
			break;

		case "updateprofile":
			updateProfile(request, response);
			break;

		case "updatepassword":
			updatePassword(request, response);
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid action: " + action);
		}

	}

	private void register(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Customer customer = new Customer();

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmpassword = request.getParameter("confirmpassword");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");

		if (email == null || email.isEmpty() || password == null || password.isEmpty() || confirmpassword == null
				|| confirmpassword.isEmpty() || name == null || name.isEmpty() || phone == null || phone.isEmpty()
				|| address == null || address.isEmpty()) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage",
					"Name, email, password, confirm password, phone number and address are required.");
			response.sendRedirect("register.jsp");
			return;
		}

		if (!password.equals(confirmpassword)) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Passwords do not match.");
			response.sendRedirect("register.jsp");
			return;
		}

		/*
		 * if (!isPasswordStrong(password)) { HttpSession session =
		 * request.getSession(true); session.setAttribute("errorMessage",
		 * "Password must be at least 8 characters, contain upper & lower case letters, a digit, and a special character."
		 * ); response.sendRedirect("register.jsp"); return; }
		 */

		// retrieve input and set
		customer.setName(capitalize(name));
		customer.setEmail(email);
		customer.setPassword(password);
		customer.setPhone(phone);
		customer.setAddress(capitalize(address));

		customer = CustomerDAO.getCustomer(customer);

		if (!customer.isValid()) {
			try {

				CustomerDAO.addCustomer(customer);
			} catch (Exception e) {

				e.printStackTrace();
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Error registering Customer.");
				response.sendRedirect("register.jsp");
				return;
			}

			HttpSession session = request.getSession(true);
			session.setAttribute("successMessage", "Registered Successfully!");
			RequestDispatcher view = request.getRequestDispatcher("login.jsp");
			view.forward(request, response);

			System.out.print("Hitting CustomerController");
		} else {

			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Customer has been registered!");
			RequestDispatcher view = request.getRequestDispatcher("register.jsp");
			view.forward(request, response);

		}
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			Customer customer = new Customer();

			String email = request.getParameter("email");
			String password = request.getParameter("password");

			if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
				request.setAttribute("errorMessage", "Email and password are required.");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				return;
			}

			customer.setEmail(email);
			customer.setPassword(password);

			customer = CustomerDAO.login(customer);

			if (customer.isLoggedIn()) {

				HttpSession session = request.getSession(true);
				session.setAttribute("successLoginMessage", "Login Successfully!");
				Cart cart = CartDAO.getCartByCustomerId(customer.getId());
				if (cart == null) {
					// No cart yet, create a new cart or show zero
					session.setAttribute("cartCount", 0);
					session.setAttribute("cart", null); // optional
				} else {
					// Cart exists - now count items
					int cartCount = CartItemDAO.getTotalItemsInCart(cart.getId()); // you must implement this
					session.setAttribute("cartCount", cartCount);

				}
				session.setAttribute("customer", customer);
				response.sendRedirect("login.jsp");

			} else {

				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Invalid email or password. Please try again.");
				request.getRequestDispatcher("login.jsp").forward(request, response);

			}

		}

		catch (Throwable ex) {
			ex.printStackTrace();
		}

	}

	private void updateProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Customer customer = new Customer();

		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");

		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String existingImage = request.getParameter("existingImage");

		if (name == null || name.isEmpty() || phone == null || phone.isEmpty() || address == null
				|| address.isEmpty()) {
		
			
			request.getSession(true).setAttribute("errorMessage", "Name, phone number and address are required.");
			response.sendRedirect("CustomerController?action=profile");
			return;
		}

		Part filePart = request.getPart("image");
		String imagePath = existingImage;

		if (filePart != null && filePart.getSize() > 0) {
			// Check file size in bytes (300 KB = 300 * 1024 bytes)
			long maxSize = 2000 * 1024;
			if (filePart.getSize() > maxSize) {
				// File too large, set error message and redirect

				request.getSession(true).setAttribute("errorMessage", "Image size must be less than 2MB.");
				response.sendRedirect("CustomerController?action=profile");
				return;
			}

			try {
				imagePath = uploadToImgBB(filePart);
			} catch (Exception e) {
				e.printStackTrace();
				request.getSession(true).setAttribute("errorMessage", "Failed to upload image.");
				response.sendRedirect("CustomerController?action=profile");
				return;
			}
		}

		customer.setId(id);
		customer.setName(capitalize(name));
		customer.setPhone(phone);
		customer.setAddress(capitalize(address));
		customer.setImage(imagePath);

		customer = CustomerDAO.getCustomer(customer);

		try {

			CustomerDAO.updateCustomer(customer);
		} catch (Exception e) {

			e.printStackTrace();
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Error updating profile.");
			response.sendRedirect("CustomerController?action=profile");
			return;
		}

		HttpSession session = request.getSession(true);
		session.setAttribute("customer", CustomerDAO.getCustomer(id));
		session.setAttribute("successMessage", "Profile updated sucessfully!");
		response.sendRedirect("CustomerController?action=profile");

	}

	private void updatePassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		Customer customer = (Customer) request.getSession().getAttribute("customer");
		String errorPasswordMessage = null;
		HttpSession session = request.getSession(true);

		if (customer != null) {
			try {

				if (!newPassword.equals(confirmPassword)) {

					session.setAttribute("errorMessage", "New password and confirm password do not match");
					errorPasswordMessage = "New password and confirm password do not match";

				}

				else {

					CustomerDAO customerDAO = new CustomerDAO();
					boolean isUpdated = customerDAO.updatePassword(customer.getId(), oldPassword, newPassword);

					if (isUpdated) {

						session.setAttribute("successMessage", "Password Changed Successfully!");
						response.sendRedirect("CustomerController?action=profile");
					} else {
						session.setAttribute("errorMessage", "Old password is incorrect");
						errorPasswordMessage = "Old password is incorrect";
					}
				}
			} catch (Exception e) {

				e.printStackTrace();
				errorPasswordMessage = "Error while processing your password.";
			}
		} else {
			errorPasswordMessage = "Customer not found.";
		}

		if (errorPasswordMessage != null) {
			session.setAttribute("errorPasswordMessage", errorPasswordMessage);
			response.sendRedirect("CustomerController?action=profile");
		}

	}

	public String capitalize(String str) {
		if (str == null || str.isEmpty()) {
			return str;
		}
		String[] words = str.split("\\s+");
		StringBuilder capitalized = new StringBuilder();
		for (String word : words) {
			if (word.length() > 0) {
				capitalized.append(Character.toUpperCase(word.charAt(0))).append(word.substring(1).toLowerCase())
						.append(" ");
			}
		}
		return capitalized.toString().trim();
	}

	public boolean isPasswordStrong(String password) {
		String regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
		return password.matches(regex);
	}

	private String uploadToImgBB(Part filePart) throws IOException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		try (InputStream inputStream = filePart.getInputStream()) {
			byte[] buffer = new byte[4096];
			int bytesRead;
			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}
		}

		String base64Image = Base64.getEncoder().encodeToString(outputStream.toByteArray());
		String apiKey = "c98a4966f36b4e68e191da3291236b30";
		String apiUrl = "https://api.imgbb.com/1/upload";

		URL url = new URL(apiUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);
		connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

		String postData = "key=" + URLEncoder.encode(apiKey, "UTF-8") + "&image="
				+ URLEncoder.encode(base64Image, "UTF-8");

		try (OutputStream os = connection.getOutputStream()) {
			byte[] input = postData.getBytes(StandardCharsets.UTF_8);
			os.write(input, 0, input.length);
		}

		int responseCode = connection.getResponseCode();
		if (responseCode == HttpURLConnection.HTTP_OK) {
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			StringBuilder responseBuilder = new StringBuilder();
			String line;
			while ((line = in.readLine()) != null) {
				responseBuilder.append(line);
			}
			in.close();

			JsonObject json = JsonParser.parseString(responseBuilder.toString()).getAsJsonObject();
			return json.getAsJsonObject("data").get("url").getAsString();
		} else {
			throw new IOException("ImgBB upload failed with HTTP code: " + responseCode);
		}
	}

}
