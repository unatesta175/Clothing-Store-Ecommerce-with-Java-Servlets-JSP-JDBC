package expose.dao;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import db.connection.ConnectionManager;
import expose.model.Bottomwear;
import expose.model.Product;
import expose.model.Topwear;

public class ProductDAO {

	private static final String ADD_PRODUCTS_SQL = "INSERT INTO products (id, name ,prod_size , price, description, stock, image, type , category, created_at, updated_at ) VALUES (product_id_seq.NEXTVAL,?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
	private static final String SQL_GET_PRODUCT_ID = "SELECT product_id_seq.CURRVAL FROM dual";
	private static final String SELECT_PRODUCT_BY_ID = "SELECT * FROM employees WHERE id = ?";
	private static final String SELECT_ALL_PRODUCTS = "SELECT p.*, t.collar_type, NULL AS fit_type FROM products p LEFT JOIN topwears t ON p.id = t.id WHERE p.type = 'topwear' UNION SELECT p.*, NULL AS collar_type, b.fit_type FROM products p LEFT JOIN bottomwears b ON p.id = b.id WHERE p.type = 'bottomwear' UNION SELECT p.*, NULL AS collar_type, NULL AS fit_type FROM products p WHERE p.type NOT IN ('topwear', 'bottomwear')";
	private static final String DELETE_PRODUCTS_SQL = "DELETE FROM products WHERE id = ?";
	private static final String UPDATE_PRODUCTS_SQL = "UPDATE products SET name = ?, prod_size = ?, price = ?, description = ?, stock = ?, image = ?, type = ?, category = ? , updated_at =? WHERE id = ?";

	public void addProduct(Product product) throws SQLException {

		Connection conn = null;
		PreparedStatement psProduct = null;
		PreparedStatement psChild = null;
		ResultSet rs = null;

		try {
			conn = ConnectionManager.getConnection();

			// Insert into products table
			psProduct = conn.prepareStatement(ADD_PRODUCTS_SQL);
			psProduct.setString(1, product.getName());
			psProduct.setString(2, product.getSize());
			psProduct.setDouble(3, product.getPrice());
			psProduct.setString(4, product.getDescription());
			psProduct.setInt(5, product.getStock());
			psProduct.setString(6, product.getImage());
			psProduct.setString(7, product.getType());
			psProduct.setString(8, product.getCategory());
			psProduct.executeUpdate();

			// Get the product ID using CURRVAL from the same connection/session
			try (

					PreparedStatement psGetId = conn.prepareStatement(SQL_GET_PRODUCT_ID);
					ResultSet rsId = psGetId.executeQuery();) {
				if (rsId.next()) {
					int productId = rsId.getInt(1);

					// Insert into child table depending on type
					if ("topwear".equalsIgnoreCase(product.getType()) && product instanceof Topwear) {
						Topwear topwear = (Topwear) product;
						String ADD_SQL_TOPWEAR = "INSERT INTO topwears (id, collar_type) VALUES (?, ?)";
						psChild = conn.prepareStatement(ADD_SQL_TOPWEAR);
						psChild.setInt(1, productId);
						psChild.setString(2, topwear.getCollarType());
						psChild.executeUpdate();

					} else if ("bottomwear".equalsIgnoreCase(product.getType()) && product instanceof Bottomwear) {
						Bottomwear bottomwear = (Bottomwear) product;
						String ADD_SQL_BOTTOMWEAR = "INSERT INTO bottomwears (id, fit_type) VALUES (?, ?)";
						psChild = conn.prepareStatement(ADD_SQL_BOTTOMWEAR);
						psChild.setInt(1, productId);
						psChild.setString(2, bottomwear.getFitType());
						psChild.executeUpdate();
					}
				}
			}

		} finally {
			if (rs != null)
				rs.close();
			if (psChild != null)
				psChild.close();
			if (psProduct != null)
				psProduct.close();
			if (conn != null)
				conn.close();
		}
	}

	public static List<Product> getAllProducts() {

		List<Product> products = new ArrayList<>();

		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SELECT_ALL_PRODUCTS);
				ResultSet rs = ps.executeQuery();)

		{
			while (rs.next()) {
				String type = rs.getString("type");

				Product product;

				if ("topwear".equalsIgnoreCase(type)) {
					product = new Topwear();
					((Topwear) product).setCollarType(rs.getString("collar_type"));
				} else if ("bottomwear".equalsIgnoreCase(type)) {
					product = new Bottomwear();
					((Bottomwear) product).setFitType(rs.getString("fit_type"));
				} else {
					product = new Product();
				}

				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setSize(rs.getString("prod_size"));
				product.setPrice(rs.getDouble("price"));
				product.setDescription(rs.getString("description"));
				product.setStock(rs.getInt("stock"));
				product.setImage(rs.getString("image"));
				product.setType(rs.getString("type"));
				product.setCategory(rs.getString("category"));
				product.setCreatedAt(rs.getTimestamp("created_at"));
				product.setUpdatedAt(rs.getTimestamp("updated_at"));
				products.add(product);
			}
			System.out.print(SELECT_ALL_PRODUCTS);

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return products;
	}

	public static List<Product> getAllProductForCreation() throws SQLException {
		List<Product> products = new ArrayList<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = ConnectionManager.getConnection();

			String SQL = "SELECT MIN(id) as id, name FROM products GROUP BY name ORDER BY name ASC";

			ps = conn.prepareStatement(SQL);
			rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");

				Product product = new Product();
				product.setId(id);
				product.setName(name);

				products.add(product);
			}

		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}

		return products;
	}

	public static List<Product> getAllProductName() throws SQLException {
		List<Product> products = new ArrayList<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = ConnectionManager.getConnection();

			String SQL = "SELECT MIN(id) as id, name FROM products GROUP BY name ORDER BY name ASC";

			ps = conn.prepareStatement(SQL);
			rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");

				Product product = new Product();
				product.setId(id);
				product.setName(name);

				products.add(product);
			}

		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}

		return products;
	}

	public static Product getProduct(int id) throws SQLException {
		Product product = null;
		Connection conn = null;
		PreparedStatement psProduct = null;
		PreparedStatement psChild = null;
		ResultSet rsProduct = null;
		ResultSet rsChild = null;

		try {
			conn = ConnectionManager.getConnection();

			// Get main product info
			String SQL_GET_PRODUCT = "SELECT * FROM products WHERE id = ?";
			psProduct = conn.prepareStatement(SQL_GET_PRODUCT);
			psProduct.setInt(1, id);
			rsProduct = psProduct.executeQuery();

			if (rsProduct.next()) {
				String type = rsProduct.getString("type");
				String name = rsProduct.getString("name");
				String size = rsProduct.getString("prod_size");
				double price = rsProduct.getDouble("price");
				String description = rsProduct.getString("description");
				int stock = rsProduct.getInt("stock");
				String image = rsProduct.getString("image");
				String category = rsProduct.getString("category");
				Timestamp createdAt = rsProduct.getTimestamp("created_at");
				Timestamp updatedAt = rsProduct.getTimestamp("updated_at");

				// Check type and fetch child info
				if ("topwear".equalsIgnoreCase(type)) {
					String SQL_GET_TOPWEAR = "SELECT collar_type FROM topwears WHERE id = ?";
					psChild = conn.prepareStatement(SQL_GET_TOPWEAR);
					psChild.setInt(1, id);
					rsChild = psChild.executeQuery();

					if (rsChild.next()) {
						String collarType = rsChild.getString("collar_type");
						Topwear topwear = new Topwear(id, name, size, price, description, stock, image, type, category,
								createdAt, updatedAt, collarType);
						product = topwear;
					}
				} else if ("bottomwear".equalsIgnoreCase(type)) {
					String SQL_GET_BOTTOMWEAR = "SELECT fit_type FROM bottomwears WHERE id = ?";
					psChild = conn.prepareStatement(SQL_GET_BOTTOMWEAR);
					psChild.setInt(1, id);
					rsChild = psChild.executeQuery();

					if (rsChild.next()) {
						String fitType = rsChild.getString("fit_type");
						Bottomwear bottomwear = new Bottomwear(id, name, size, price, description, stock, image, type,
								category, createdAt, updatedAt, fitType);
						product = bottomwear;
					}
				}
			}

		} finally {
			if (rsChild != null)
				rsChild.close();
			if (rsProduct != null)
				rsProduct.close();
			if (psChild != null)
				psChild.close();
			if (psProduct != null)
				psProduct.close();
			if (conn != null)
				conn.close();
		}

		return product;
	}
	
	public static List<Product> getAllProductByName(String productName) {
	    List<Product> products = new ArrayList<>();
	    String sql = "SELECT * FROM products WHERE name = ?";

	    try (Connection conn = ConnectionManager.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, productName);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Product product = new Product();
	            product.setId(rs.getInt("id"));
	            product.setName(rs.getString("name"));
	            product.setSize(rs.getString("prod_size"));
	            product.setStock(rs.getInt("stock"));
	            product.setPrice(rs.getDouble("price"));
	            // Set other fields as needed
	            products.add(product);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return products;
	}

	public static void updateProduct(Product product) throws SQLException {

		Connection conn = null;
		PreparedStatement psProduct = null;
		PreparedStatement psChild = null;
		PreparedStatement psOldTypeStmt = null;
		PreparedStatement psDeleteOldChild = null;
		PreparedStatement psInsertNewChild = null;
		ResultSet rs = null;

		try {
			conn = ConnectionManager.getConnection();
			conn.setAutoCommit(false); // Start transaction

			// Step 1: Get old product type from DB
			String SELECT_OLD_TYPE_SQL = "SELECT type FROM products WHERE id = ?";
			psOldTypeStmt = conn.prepareStatement(SELECT_OLD_TYPE_SQL);
			psOldTypeStmt.setInt(1, product.getId());
			rs = psOldTypeStmt.executeQuery();
			String oldType = null;
			if (rs.next()) {
				oldType = rs.getString("type");
			}

			// Step 2: Update products table
			String UPDATE_PRODUCTS_SQL = "UPDATE products SET name=?, prod_size=?, price=?, description=?, stock=?, image=?, type=?, category=?, updated_at=? WHERE id=?";
			psProduct = conn.prepareStatement(UPDATE_PRODUCTS_SQL);
			psProduct.setString(1, product.getName());
			psProduct.setString(2, product.getSize());
			psProduct.setDouble(3, product.getPrice());
			psProduct.setString(4, product.getDescription());
			psProduct.setInt(5, product.getStock());
			psProduct.setString(6, product.getImage());
			psProduct.setString(7, product.getType());
			psProduct.setString(8, product.getCategory());
			psProduct.setTimestamp(9, Timestamp.valueOf(LocalDateTime.now()));
			psProduct.setInt(10, product.getId());
			psProduct.executeUpdate();

			// Step 3: Handle child table depending on type change

			if (oldType != null && !oldType.equalsIgnoreCase(product.getType())) {
				// Type changed, delete old child record

				if ("topwear".equalsIgnoreCase(oldType)) {
					psDeleteOldChild = conn.prepareStatement("DELETE FROM topwears WHERE id = ?");
				} else if ("bottomwear".equalsIgnoreCase(oldType)) {
					psDeleteOldChild = conn.prepareStatement("DELETE FROM bottomwears WHERE id = ?");
				}
				if (psDeleteOldChild != null) {
					psDeleteOldChild.setInt(1, product.getId());
					psDeleteOldChild.executeUpdate();
					psDeleteOldChild.close();
				}

				// Insert new child record into the new type table
				if ("topwear".equalsIgnoreCase(product.getType()) && product instanceof Topwear) {
					Topwear topwear = (Topwear) product;
					String INSERT_TOPWEAR_SQL = "INSERT INTO topwears (id, collar_type) VALUES (?, ?)";
					psInsertNewChild = conn.prepareStatement(INSERT_TOPWEAR_SQL);
					psInsertNewChild.setInt(1, product.getId());
					psInsertNewChild.setString(2, topwear.getCollarType());
					psInsertNewChild.executeUpdate();
					psInsertNewChild.close();

				} else if ("bottomwear".equalsIgnoreCase(product.getType()) && product instanceof Bottomwear) {
					Bottomwear bottomwear = (Bottomwear) product;
					String INSERT_BOTTOMWEAR_SQL = "INSERT INTO bottomwears (id, fit_type) VALUES (?, ?)";
					psInsertNewChild = conn.prepareStatement(INSERT_BOTTOMWEAR_SQL);
					psInsertNewChild.setInt(1, product.getId());
					psInsertNewChild.setString(2, bottomwear.getFitType());
					psInsertNewChild.executeUpdate();
					psInsertNewChild.close();
				}

			} else {
				// Type not changed, just update the child record as before
				if ("topwear".equalsIgnoreCase(product.getType()) && product instanceof Topwear) {
					Topwear topwear = (Topwear) product;
					String UPDATE_SQL_TOPWEAR = "UPDATE topwears SET collar_type = ? WHERE id = ?";
					psChild = conn.prepareStatement(UPDATE_SQL_TOPWEAR);
					psChild.setString(1, topwear.getCollarType());
					psChild.setInt(2, product.getId());
					psChild.executeUpdate();

				} else if ("bottomwear".equalsIgnoreCase(product.getType()) && product instanceof Bottomwear) {
					Bottomwear bottomwear = (Bottomwear) product;
					String UPDATE_SQL_BOTTOMWEAR = "UPDATE bottomwears SET fit_type = ? WHERE id = ?";
					psChild = conn.prepareStatement(UPDATE_SQL_BOTTOMWEAR);
					psChild.setString(1, bottomwear.getFitType());
					psChild.setInt(2, product.getId());
					psChild.executeUpdate();
				}
			}

			conn.commit();

		} catch (SQLException e) {
			if (conn != null)
				conn.rollback();
			throw e;
		} finally {
			if (rs != null)
				rs.close();
			if (psOldTypeStmt != null)
				psOldTypeStmt.close();
			if (psDeleteOldChild != null)
				psDeleteOldChild.close();
			if (psInsertNewChild != null)
				psInsertNewChild.close();
			if (psChild != null)
				psChild.close();
			if (psProduct != null)
				psProduct.close();
			if (conn != null)
				conn.close();
		}
	}

	public static List<Product> displayProductCatalogue() throws SQLException {
	    List<Product> products = new ArrayList<>();

	    String sql = """
	    	    SELECT p.*, 
	    	           COALESCE(variant_count.total_variants, 0) as total_variants
	    	    FROM products p
	    	    LEFT JOIN (
	    	        SELECT name, COUNT(*) AS total_variants, MIN(id) AS min_id
	    	        FROM products
	    	        WHERE stock > 0
	    	        GROUP BY name
	    	    ) variant_count ON p.id = variant_count.min_id
	    	    WHERE p.id IN (
	    	        SELECT MIN(id)
	    	        FROM products
	    	        WHERE stock > 0
	    	        GROUP BY name
	    	    )
	    	    AND p.stock > 0
	    	    """;

	    System.out.print(sql);

	    try (Connection conn = ConnectionManager.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            Product p = new Product();
	            p.setId(rs.getInt("id"));
	            p.setName(rs.getString("name"));
	            p.setPrice(rs.getDouble("price"));
	            p.setImage(rs.getString("image"));
	            p.setCategory(rs.getString("category"));
	            p.setVariantCount(rs.getInt("total_variants")); // Will be 0 if no variants have stock
	            products.add(p);
	        }
	    }

	    return products;
	}

	public static boolean deleteProduct(int id) throws SQLException {
		boolean rowDeleted = false;
		Connection con = null;
		PreparedStatement childStmt = null;
		PreparedStatement parentStmt = null;
		PreparedStatement typeStmt = null;
		ResultSet rs = null;

		try {
			con = ConnectionManager.getConnection();
			con.setAutoCommit(false); // begin transaction

			// Step 1: Find out if the product is topwear or bottomwear
			String SELECT_TYPE_SQL = "SELECT type FROM products WHERE id = ?";
			typeStmt = con.prepareStatement(SELECT_TYPE_SQL);
			typeStmt.setInt(1, id);
			rs = typeStmt.executeQuery();

			String type = null;
			if (rs.next()) {
				type = rs.getString("type"); // 'topwear' or 'bottomwear'
			}

			// Step 2: Delete from child table first
			if (type != null) {
				String DELETE_CHILD_SQL;
				if (type.equalsIgnoreCase("topwear")) {
					DELETE_CHILD_SQL = "DELETE FROM topwears WHERE id = ?";
				} else if (type.equalsIgnoreCase("bottomwear")) {
					DELETE_CHILD_SQL = "DELETE FROM bottomwears WHERE id = ?";
				} else {
					throw new SQLException("Unknown product type: " + type);
				}

				childStmt = con.prepareStatement(DELETE_CHILD_SQL);
				childStmt.setInt(1, id);
				childStmt.executeUpdate();
			}

			// Step 3: Delete from products table
			String DELETE_PRODUCTS_SQL = "DELETE FROM products WHERE id = ?";
			parentStmt = con.prepareStatement(DELETE_PRODUCTS_SQL);
			parentStmt.setInt(1, id);
			rowDeleted = parentStmt.executeUpdate() > 0;

			con.commit(); // commit transaction

		} catch (SQLException e) {
			if (con != null)
				con.rollback(); // rollback on failure
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (typeStmt != null)
				typeStmt.close();
			if (childStmt != null)
				childStmt.close();
			if (parentStmt != null)
				parentStmt.close();
			if (con != null)
				con.close();
		}

		return rowDeleted;
	}
	
	public static boolean updateProductQuantity(int productId, int quantityChange) throws SQLException {
	    String sql = "UPDATE products SET stock = stock + ? WHERE id = ? AND (stock + ?) >= 0";
	    
	    try (Connection conn = ConnectionManager.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setInt(1, quantityChange);
	        stmt.setInt(2, productId);
	        stmt.setInt(3, quantityChange); // This ensures quantity doesn't go below 0
	        
	        int rowsAffected = stmt.executeUpdate();
	        return rowsAffected > 0;
	    }
	}
	
	public static int getCountProducts() {
        int count = 0;
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT COUNT(*) FROM products";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
	
	/*
	 * public static boolean deleteProduct(int id) throws SQLException { boolean
	 * rowDeleted = false; Connection con = null; PreparedStatement stmt = null;
	 * 
	 * try { con = ConnectionManager.getConnection(); stmt =
	 * con.prepareStatement("DELETE FROM products WHERE prod_id = ?");
	 * stmt.setInt(1, id); rowDeleted = stmt.executeUpdate() > 0;
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); } finally { if (stmt != null)
	 * stmt.close(); if (con != null) con.close(); }
	 * 
	 * return rowDeleted; }
	 */

}
