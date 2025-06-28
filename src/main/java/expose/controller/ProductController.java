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
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import expose.dao.EmployeeDAO;
import expose.dao.ProductDAO;
import expose.model.Bottomwear;
import expose.model.Employee;
import expose.model.Product;
import expose.model.Topwear;

/**
 * Servlet implementation class ProductController
 * 
 */

@MultipartConfig
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private HttpSession session;
	String action = "", forward = "";
	private static String LISTPRODUCT = "admin/products.jsp";
	private static String CUSTLISTPRODUCT = "products.jsp";
	private static String CUSTVIEW = "product.jsp";
	private static String UPDATE = "admin/updateProduct.jsp";
	private static String CREATE = "admin/createProduct.jsp";
	private static String DELETE = "admin/products.jsp";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductController() {
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

		if (action.equalsIgnoreCase("productcatalogue")) {

			forward = CUSTLISTPRODUCT;

			try {
				request.setAttribute("products", ProductDAO.displayProductCatalogue());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);

		}
		
		if (action.equalsIgnoreCase("viewproduct")) {

			forward = CUSTVIEW;
			
			Integer pid = Integer.parseInt(request.getParameter("pid"));
			
			Product p;
			
			try {
				p = ProductDAO.getProduct(pid);
				String pname = p.getName();
				if (p instanceof Topwear) {

					String productcollarType = ((Topwear) p).getCollarType();
					String productfitType = "";
					request.setAttribute("productcollarType", productcollarType + " Collar");
					request.setAttribute("productfitType", productfitType);
				} else if (p instanceof Bottomwear){
					
					String productfitType = ((Bottomwear) p).getFitType();
					String productcollarType ="";
					request.setAttribute("productfitType", productfitType);
					request.setAttribute("productcollarType", productcollarType );
				}
				
				request.setAttribute("product", ProductDAO.getProduct(pid));
				request.setAttribute("prodVars", ProductDAO.getAllProductByName(pname));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);

		}
		
		if (action.equalsIgnoreCase("listProduct")) {

			forward = LISTPRODUCT;

			request.setAttribute("products", ProductDAO.getAllProducts());

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);

		}

		if (action.equalsIgnoreCase("create")) {

			forward = CREATE;

			try {

				request.setAttribute("prodList", ProductDAO.getAllProductForCreation());

			} catch (SQLException e) {

				e.printStackTrace();

			}

			view = request.getRequestDispatcher(forward);
			view.forward(request, response);

		}

		if (action.equalsIgnoreCase("update")) {

			forward = UPDATE;
			int pid = Integer.parseInt(request.getParameter("pid"));
			Product prod;
			try {
				prod = ProductDAO.getProduct(pid);

				if (prod instanceof Topwear) {

					String productcollarType = ((Topwear) prod).getCollarType();
					String productfitType = "";
					request.setAttribute("productcollarType", productcollarType);
					request.setAttribute("productfitType", productfitType);
				} else if (prod instanceof Bottomwear){
					
					String productfitType = ((Bottomwear) prod).getFitType();
					String productcollarType ="";
					request.setAttribute("productfitType", productfitType);
					request.setAttribute("productcollarType", productcollarType);
				}
				
				
				request.setAttribute("product", prod);
				request.setAttribute("prodList", ProductDAO.getAllProductName());

				view = request.getRequestDispatcher(forward);
				view.forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		if (action.equalsIgnoreCase("delete")) {

			forward = DELETE;

			int pid = Integer.parseInt(request.getParameter("pid"));
			try {

				ProductDAO.deleteProduct(pid);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			HttpSession session = request.getSession(true);
			session.setAttribute("successMessage", "Product successfully deleted.");
			response.sendRedirect("ProductController?action=listproduct");

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
			createProduct(request, response);
			break;

		case "update":
			updateProduct(request, response);
			break;

		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid action: " + action);
		}
	}

	private void createProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve common product fields from request
		String name = request.getParameter("name");
		String otherName = request.getParameter("otherName");
		String size = request.getParameter("size");
		String priceStr = request.getParameter("price");
		String description = request.getParameter("description");
		String stockStr = request.getParameter("stock");

		String type = request.getParameter("type");
		String category = request.getParameter("category");

		if (name.equalsIgnoreCase("otherName")) {

			name = otherName;

		}

		// Validate required fields
		if (name == null || size == null || priceStr == null || description == null || stockStr == null || type == null
				|| name.isEmpty() || size.isEmpty() || priceStr.isEmpty() || description.isEmpty() || stockStr.isEmpty()
				|| type.isEmpty()) {

			request.getSession().setAttribute("errorMessage", "All fields are required.");
			response.sendRedirect("ProductController?action=create");
			return;
		}

		Part filePart = request.getPart("image");
		String imagePath = "admin/images/noimg.png";

		if (filePart != null && filePart.getSize() > 0) {
			// Check file size in bytes (300 KB = 300 * 1024 bytes)
			long maxSize = 2000 * 1024;
			if (filePart.getSize() > maxSize) {
				// File too large, set error message and redirect
				HttpSession session = request.getSession(true);
				session.setAttribute("errorMessage", "Image size must be less than 2MB.");
				response.sendRedirect("ProductController?action=create");
				return;
			}

			try {
				imagePath = uploadToImgBB(filePart);
			} catch (Exception e) {
				e.printStackTrace();
				request.getSession(true).setAttribute("errorMessage", "Failed to upload image.");
				response.sendRedirect("ProductController?action=create");
				return;
			}
		}

		try {
			double price = Double.parseDouble(priceStr);
			int stock = Integer.parseInt(stockStr);

			Product product;

			// Dynamically create child class based on type
			if ("topwear".equalsIgnoreCase(type)) {
				String collarType = request.getParameter("collarType");
				if (collarType == null || collarType.isEmpty()) {
					request.getSession().setAttribute("errorMessage", "Collar type is required for topwear.");
					response.sendRedirect("ProductController?action=create");
					return;
				}

				Topwear topwear = new Topwear();
				topwear.setCollarType(collarType);
				product = topwear;

			} else if ("bottomwear".equalsIgnoreCase(type)) {
				String fitType = request.getParameter("fitType");
				if (fitType == null || fitType.isEmpty()) {
					request.getSession().setAttribute("errorMessage", "Fit type is required for bottomwear.");
					response.sendRedirect("ProductController?action=create");
					return;
				}

				Bottomwear bottomwear = new Bottomwear();
				bottomwear.setFitType(fitType);
				product = bottomwear;

			} else {
				request.getSession().setAttribute("errorMessage", "Invalid product type.");
				response.sendRedirect("ProductController?action=create");
				return;
			}

			// Set common fields (superclass)
			product.setName(name);
			product.setSize(size);
			product.setPrice(price);
			product.setDescription(description);
			product.setStock(stock);
			product.setImage(imagePath);
			product.setType(type);
			product.setCategory(category);

			// Save to DB
			ProductDAO dao = new ProductDAO();
			dao.addProduct(product);

			request.getSession().setAttribute("successMessage", "Product created successfully.");
			response.sendRedirect("ProductController?action=listProduct");

		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.getSession().setAttribute("errorMessage", "Invalid number format.");
			response.sendRedirect("ProductController?action=create");
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("errorMessage", "Error creating product.");
			response.sendRedirect("ProductController?action=create");
		}
	}

	private void updateProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));

		String name = request.getParameter("name");
		String size = request.getParameter("size");
		String priceStr = request.getParameter("price");
		String description = request.getParameter("description");
		String stockStr = request.getParameter("stock");
		String existingImage = request.getParameter("existingImage");
		String type = request.getParameter("type");
		String category = request.getParameter("category");
		
		

		// Validate required fields
		if (name == null || size == null || priceStr == null || description == null || stockStr == null || type == null
				|| name.isEmpty() || size.isEmpty() || priceStr.isEmpty() || description.isEmpty() || stockStr.isEmpty()
				|| type.isEmpty()) {

			request.getSession().setAttribute("errorMessage", "All fields are required.");
			response.sendRedirect("ProductController?action=update&pid=" + id);
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
				response.sendRedirect("ProductController?action=update&pid=" + id);
				return;
			}

			try {
				imagePath = uploadToImgBB(filePart);
			} catch (Exception e) {
				e.printStackTrace();
				request.getSession(true).setAttribute("errorMessage", "Failed to upload image.");
				response.sendRedirect("ProductController?action=update&pid=" + id);
				return;
			}
		}

		try {
			double price = Double.parseDouble(priceStr);
			int stock = Integer.parseInt(stockStr);

			Product product;

			// Dynamically create child class based on type
			if ("topwear".equalsIgnoreCase(type)) {
				String collarType = request.getParameter("collarType");
				if (collarType == null || collarType.isEmpty()) {
					request.getSession().setAttribute("errorMessage", "Collar type is required for topwear.");
					response.sendRedirect("ProductController?action=update&pid=" + id);
					return;
				}

				Topwear topwear = new Topwear();
				topwear.setCollarType(collarType);
				product = topwear;

			} else if ("bottomwear".equalsIgnoreCase(type)) {
				String fitType = request.getParameter("fitType");
				if (fitType == null || fitType.isEmpty()) {
					request.getSession().setAttribute("errorMessage", "Fit type is required for bottomwear.");
					response.sendRedirect("ProductController?action=update&pid=" + id);
					return;
				}

				Bottomwear bottomwear = new Bottomwear();
				bottomwear.setFitType(fitType);
				product = bottomwear;

			} else {
				request.getSession().setAttribute("errorMessage", "Invalid product type.");
				response.sendRedirect("ProductController?action=update&pid=" + id);
				return;
			}

			// Set common fields (superclass)
			product.setId(id);
			product.setName(name);
			product.setSize(size);
			product.setPrice(price);
			product.setDescription(description);
			product.setStock(stock);
			product.setImage(imagePath);
			product.setType(type);
			product.setCategory(category);

			// Save to DB
			ProductDAO.updateProduct(product);

			request.getSession().setAttribute("successMessage", "Product updated successfully.");
			/* response.sendRedirect("ProductController?action=update&pid=" + id); */
			response.sendRedirect("ProductController?action=listProduct");
			

		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.getSession().setAttribute("errorMessage", "Invalid number format.");
			response.sendRedirect("ProductController?action=update&pid=" + id);
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("errorMessage", "Error updating product.");
			response.sendRedirect("ProductController?action=update&pid=" + id);
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
