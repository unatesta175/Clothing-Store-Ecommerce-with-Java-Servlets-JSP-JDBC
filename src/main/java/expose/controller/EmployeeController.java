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


import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.List;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


import expose.dao.EmployeeDAO;
import expose.model.Employee;

/**
 * Servlet implementation class EmployeeServlet
 */
@MultipartConfig
public class EmployeeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private HttpSession session;
	String action = "", forward = "";
	private static String LISTEMPLOYEE = "admin/listStaff.jsp";
	private static String PROFILE = "admin/profile.jsp";
	private static String LOGOUT = "admin/login.jsp";
	private static String REGISTER = "admin/register.jsp";
	private static String UPDATE = "admin/updateEmployee.jsp";
	private static String CREATE = "admin/createEmployee.jsp";
	private static String DELETE = "admin/listStaff.jsp";

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	public EmployeeController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String action = request.getParameter("action");

		if (action.equalsIgnoreCase("register")) {
			forward = REGISTER;

			request.setAttribute("employees", EmployeeDAO.getAllEmployees());

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);
		}

		if (action.equalsIgnoreCase("logout")) {
			forward = LOGOUT;

			try {
				// get the current session
				session = request.getSession(true);
				// set current session to null.
				session.setAttribute("employee", null);
				// destroy session
				session.invalidate();
				response.sendRedirect("admin/login.jsp");
			} catch (Throwable ex) {
				ex.printStackTrace();
			}
		}

		if (action.equalsIgnoreCase("profile")) {

			forward = PROFILE;

			HttpSession session = request.getSession();
			Employee loggedInEmployee = (Employee) session.getAttribute("employee");

			if (loggedInEmployee != null) {
				int empid = loggedInEmployee.getId();

				Employee employee = EmployeeDAO.getEmployee(empid);
				Employee manager = EmployeeDAO.getEmployee(employee.getAdminId());

				request.setAttribute("employee", employee);
				request.setAttribute("manager", manager);

				view = request.getRequestDispatcher(forward);
				view.forward(request, response);
			}

		}

		if (action.equalsIgnoreCase("listEmployee")) {

			forward = LISTEMPLOYEE;

			request.setAttribute("employees", EmployeeDAO.getAllEmployees());

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);
		}

		if (action.equalsIgnoreCase("createEmployee")) {

			forward = CREATE;
			List<Employee> empList = EmployeeDAO.getAllEmployees();

			request.setAttribute("employeeList", empList);

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);
		}

		if (action.equalsIgnoreCase("updateEmployee")) {

			forward = UPDATE;

			int empId = Integer.parseInt(request.getParameter("empid"));

			Employee emp = EmployeeDAO.getEmployee(empId);
			Employee manager = EmployeeDAO.getEmployee(emp.getAdminId());

			emp.setManager(manager);

			List<Employee> empList = EmployeeDAO.getAllEmployees();

			request.setAttribute("selectedEmployee", emp);
			request.setAttribute("employeeList", empList);

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);
		}

		if (action.equalsIgnoreCase("deleteEmployee")) {
			forward = DELETE;
			Integer empid = Integer.parseInt(request.getParameter("empid"));
			try {

				EmployeeDAO.deleteEmployee(empid);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			HttpSession session = request.getSession(true);
			session.setAttribute("successMessage", "Employee successfully deleted.");
			response.sendRedirect("EmployeeController?action=listEmployee");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		switch (action.toLowerCase()) {
		case "create":
			registerEmployee(request, response);
			break;

		case "login":
			loginEmployee(request, response);
			break;

		case "update":
			updateEmployee(request, response);
			break;

		case "updatepassword":
			updatePassword(request, response);
			break;

		case "updateotheremployee":
			updateOtherEmployee(request, response);
			break;

		case "createotheremployee":
			createOtherEmployee(request, response);
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid action: " + action);
		}
	}

	private void registerEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Employee employee = new Employee();

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmpassword = request.getParameter("confirmpassword");
		String role = request.getParameter("role");
		String phone = request.getParameter("phone");
		
		String adminIdParam = request.getParameter("admin_id");
		Integer adminId;

		if (adminIdParam == null || adminIdParam.trim().equals("")) {
			adminId = null;
		} else {
			adminId = Integer.parseInt(adminIdParam);
		}

		if (email == null || email.isEmpty() || password == null || password.isEmpty() || confirmpassword == null
				|| confirmpassword.isEmpty() || role == null || role.isEmpty() || name == null || name.isEmpty()
				|| phone == null || phone.isEmpty()) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "All fields are required.");
			response.sendRedirect("EmployeeController?action=register");
			return;
		}

		if (!password.equals(confirmpassword)) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Passwords do not match.");
			response.sendRedirect("EmployeeController?action=register");
			return;
		}

		/*
		 * if (!isPasswordStrong(password)) { HttpSession session =
		 * request.getSession(true); session.setAttribute("errorMessage",
		 * "Password must be at least 8 characters, contain upper & lower case letters, a digit, and a special character."
		 * ); response.sendRedirect("EmployeeController?action=register"); return; }
		 */

		employee.setName(capitalize(name));
		employee.setEmail(email);
		employee.setPassword(password);
		employee.setPhone(phone);
		employee.setRole(role);
		employee.setAdminId(adminId);

		employee = EmployeeDAO.getEmployee(employee);

		if (!employee.isValid()) {
			try {
				EmployeeDAO.addEmployee(employee);
			} catch (Exception e) {
				e.printStackTrace();
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Error registering employee.");
				response.sendRedirect("EmployeeController?action=register");
				return;
			}

			HttpSession session = request.getSession(true);
			session.setAttribute("successMessage", "Registered Successfully!");
			response.sendRedirect("admin/login.jsp");
		} else {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Employee already exists.");
			response.sendRedirect("EmployeeController?action=register");

		}
	}

	private void loginEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			Employee employee = new Employee();

			String email = request.getParameter("email");
			String password = request.getParameter("password");

			if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Email and password are required.");
				response.sendRedirect("admin/login.jsp");
				return; // Stop further processing
			}

			// retrieve and set email and password
			employee.setEmail(email);
			employee.setPassword(password);

			// call login() in EmployeeDAO
			employee = EmployeeDAO.login(employee);

			System.out.print("2");
			// set employee session if employee is valid
			if (employee.isLoggedIn()) {

				HttpSession session = request.getSession(true);
				System.out.print("3");
				session.setAttribute("successLoginMessage", "Login Successfully!");
				System.out.print("4");
				session.setAttribute("employee", employee);
				System.out.print("5");
				// Redirect to avoid resubmission
				response.sendRedirect("admin/login.jsp");
				System.out.print("6");
			} else {
				// response.sendRedirect("invalidLogin.jsp");
				// Set error attribute and forward back to login.jsp
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Invalid email or password. Please try again.");

				response.sendRedirect("admin/login.jsp");
			}

		}

		catch (Throwable ex) {
			ex.printStackTrace();
		}

	}

	private void updateEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Employee employee = new Employee();

		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		String phone = request.getParameter("phone");
		String adminIdParam = request.getParameter("admin_id");
		String existingImage = request.getParameter("existingImage");
		Integer adminId;

		
		if (adminIdParam == null || adminIdParam.trim().equals("") || adminIdParam.equals("0")) {
		    adminId = null;
		} else {
		    adminId = Integer.parseInt(adminIdParam);
		}

		if (email == null || email.isEmpty() || password == null || password.isEmpty() || role == null || role.isEmpty()
				|| name == null || name.isEmpty() || phone == null || phone.isEmpty()) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "All fields are required.");
			response.sendRedirect("EmployeeController?action=profile");
			return;
		}

		Part filePart = request.getPart("image");
		String imagePath = existingImage;

		if (filePart != null && filePart.getSize() > 0) {
		    // Check file size in bytes (300 KB = 300 * 1024 bytes)
		    long maxSize = 2000 * 1024; 
		    if (filePart.getSize() > maxSize) {
		        // File too large, set error message and redirect
		        HttpSession session = request.getSession(true);
		        session.setAttribute("errorMessage", "Image size must be less than 2MB.");
		        response.sendRedirect("EmployeeController?action=updateEmployee&empid=" + id);
		        return;
		    }
		    
		    try {
		        imagePath = uploadToImgBB(filePart);
		    } catch (Exception e) {
		        e.printStackTrace();
		        request.getSession(true).setAttribute("errorMessage", "Failed to upload image.");
		        response.sendRedirect("EmployeeController?action=profile");
		        return;
		    }
		}
	    
		employee.setId(id);
		employee.setName(capitalize(name));
		employee.setEmail(email);
		employee.setPassword(password);
		employee.setPhone(phone);
		employee.setRole(role);
		employee.setAdminId(adminId);
	    employee.setImage(imagePath);
		
		try {
			EmployeeDAO.updateEmployee(employee);
		} catch (Exception e) {
			e.printStackTrace();
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Error updating employee.");
			response.sendRedirect("EmployeeController?action=profile");
			return;
		}

		HttpSession session = request.getSession(true);
		session.setAttribute("employee", EmployeeDAO.getEmployee(id));
		session.setAttribute("successMessage", "Profile updated sucessfully!");
		response.sendRedirect("EmployeeController?action=profile");

	}

	private void updatePassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get form values from the request
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");

		// Get the current logged-in employee (from session or database)
		Employee employee = (Employee) request.getSession().getAttribute("employee");

		String errorPasswordMessage = null;

		HttpSession session = request.getSession(true);

		// Check if the employee is logged in
		if (employee != null) {
			try {
				// Validate the passwords
				if (!newPassword.equals(confirmPassword)) {
					session.setAttribute("errorMessage", "New password and confirm password do not match");
					errorPasswordMessage = "New password and confirm password do not match";

				}
//                else if (newPassword.length() < 6) {
//                    errorPasswordMessage = "New password must be at least 6 characters long.";
//                }
				else {
					// Call the EmployeeDao to update the password
					EmployeeDAO employeeDAO = new EmployeeDAO();
					boolean isUpdated = employeeDAO.updatePassword(employee.getId(), oldPassword, newPassword);

					if (isUpdated) {
						// Redirect or inform the employee that the password has been updated
						// successfully
						session.setAttribute("successMessage", "Password Changed Successfully!");
						response.sendRedirect("admin/password.jsp");
					} else {
						session.setAttribute("errorMessage", "Old password is incorrect");
						errorPasswordMessage = "Old password is incorrect";
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				errorPasswordMessage = "Error while processing your password.";
			}
		} else {
			errorPasswordMessage = "Employee not found.";
		}

		// If there was an error, set the error message and forward back to the form
		if (errorPasswordMessage != null) {
			request.setAttribute("errorPasswordMessage", errorPasswordMessage);
			/* request.getRequestDispatcher("profile.jsp").forward(request, response); */
			response.sendRedirect("admin/password.jsp");
		}
	}

	private void createOtherEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Employee employee = new Employee();

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		String phone = request.getParameter("phone");

		String adminIdParam = request.getParameter("admin_id");
		Integer adminId;

		if (adminIdParam == null || adminIdParam.trim().equals("")) {
			adminId = null;
		} else {
			adminId = Integer.parseInt(adminIdParam);
		}

		if (email == null || email.isEmpty() || password == null || password.isEmpty() || role == null || role.isEmpty()
				|| name == null || name.isEmpty() || phone == null || phone.isEmpty()) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "All fields are required.");
			response.sendRedirect("EmployeeController?action=createEmployee");
			return;
		}

		employee.setName(capitalize(name));
		employee.setEmail(email);
		employee.setPassword(password);
		employee.setPhone(phone);
		employee.setRole(role);
		employee.setAdminId(adminId);

		employee = EmployeeDAO.getEmployee(employee);

		if (!employee.isValid()) {
			try {
				EmployeeDAO.addEmployee(employee);
			} catch (Exception e) {
				e.printStackTrace();
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Error registering employee.");
				response.sendRedirect("EmployeeController?action=createEmployee");
				return;
			}

			HttpSession session = request.getSession(true);
			session.setAttribute("successMessage", "Registered Successfully!");
			response.sendRedirect("EmployeeController?action=createEmployee");
		} else {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "Employee already exists.");
			response.sendRedirect("EmployeeController?action=createEmployee");

		}

	}

	private void updateOtherEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Employee employee = new Employee();

		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		String phone = request.getParameter("phone");
		String existingImage = request.getParameter("existingImage");
		String adminIdParam = request.getParameter("admin_id");
		Integer adminId;

		if (adminIdParam == null || adminIdParam.trim().equals("")) {
			adminId = null;
		} else {
			adminId = Integer.parseInt(adminIdParam);
		}

		if (email == null || email.isEmpty() || password == null || password.isEmpty() || role == null || role.isEmpty()
				|| name == null || name.isEmpty() || phone == null || phone.isEmpty()) {
			HttpSession session = request.getSession(true);
			session.setAttribute("errorMessage", "All fields are required.");
			response.sendRedirect("EmployeeController?action=updateEmployee&empid=" + id);
			return;
		}
		
		Part filePart = request.getPart("image");
		String imagePath = existingImage;

		if (filePart != null && filePart.getSize() > 0) {
		    // Check file size in bytes (300 KB = 300 * 1024 bytes)
		    long maxSize = 2000 * 1024; 
		    if (filePart.getSize() > maxSize) {
		        // File too large, set error message and redirect
		        HttpSession session = request.getSession(true);
		        session.setAttribute("errorMessage", "Image size must be less than 2MB.");
		        response.sendRedirect("EmployeeController?action=updateEmployee&empid=" + id);
		        return;
		    }
		    
		    try {
		        imagePath = uploadToImgBB(filePart);
		    } catch (Exception e) {
		        e.printStackTrace();
		        request.getSession(true).setAttribute("errorMessage", "Failed to upload image.");
		        response.sendRedirect("EmployeeController?action=profile");
		        return;
		    }
		}
	    

		employee.setId(id);
		employee.setName(capitalize(name));
		employee.setEmail(email);
		employee.setPassword(password);
		employee.setPhone(phone);
		employee.setRole(role);
		employee.setAdminId(adminId);
		employee.setImage(imagePath);
		EmployeeDAO.updateEmployee(employee);

		HttpSession session = request.getSession(true);
		session.setAttribute("successMessage", "Employee updated sucessfully!");
		response.sendRedirect("EmployeeController?action=updateEmployee&empid=" + id);

	}

	public String capitalize(String str) {
	    if (str == null || str.isEmpty()) {
	        return str;
	    }
	    String[] words = str.split("\\s+");
	    StringBuilder capitalized = new StringBuilder();
	    for (String word : words) {
	        if (word.length() > 0) {
	            capitalized.append(Character.toUpperCase(word.charAt(0)))
	                       .append(word.substring(1).toLowerCase())
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

	    String postData = "key=" + URLEncoder.encode(apiKey, "UTF-8")
	                    + "&image=" + URLEncoder.encode(base64Image, "UTF-8");

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
