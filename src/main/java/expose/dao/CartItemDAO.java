package expose.dao;

import expose.model.CartItem;
import expose.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import db.connection.ConnectionManager;

public class CartItemDAO {

	public static List<CartItem> getCartItems(int cartId) throws SQLException {
	    List<CartItem> items = new ArrayList<>();

	    String sql = "SELECT ci.cart_id, ci.product_id, ci.quantity, ci.price, " +
	                 "p.name, p.image, p.category, p.prod_size " +
	                 "FROM cart_items ci " +
	                 "JOIN products p ON ci.product_id = p.id " +
	                 "WHERE ci.cart_id = ?";
	    try (Connection con = ConnectionManager.getConnection(); 
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	         
	        stmt.setInt(1, cartId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            CartItem item = new CartItem();
	            item.setCartId(rs.getInt("cart_id"));
	            item.setProductId(rs.getInt("product_id"));
	            item.setQuantity(rs.getInt("quantity"));
	            item.setPrice(rs.getDouble("price"));

	            Product product = new Product();
	            product.setId(rs.getInt("product_id"));
	            product.setName(rs.getString("name"));
	            product.setImage(rs.getString("image"));
	            product.setPrice(rs.getDouble("price"));
	            product.setCategory(rs.getString("category"));
	            product.setSize(rs.getString("prod_size"));
	            item.setProduct(product);

	           
	            items.add(item);
	        }
	    }

	    return items;
	}

	
	public static Double getTotalPriceCart(int cartId) throws SQLException {
	    String sql = "SELECT SUM(price * quantity) AS subtotal FROM cart_items WHERE cart_id = ?";
	    try (Connection con = ConnectionManager.getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	         
	        stmt.setInt(1, cartId);
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            return rs.getDouble("subtotal");
	        }
	    }
	    return 0.0;
	}

	public static CartItem getCartItem(int cartId, int productId) {
	    CartItem item = null;

	    String sql = "SELECT * FROM cart_items WHERE cart_id = ? AND product_id = ?";

	    try (Connection con = ConnectionManager.getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {

	        stmt.setInt(1, cartId);
	        stmt.setInt(2, productId);

	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                item = new CartItem();
	                item.setCartId(rs.getInt("cart_id"));
	                item.setProductId(rs.getInt("product_id"));
	                item.setQuantity(rs.getInt("quantity"));
	                item.setPrice(rs.getDouble("price"));
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace(); // You can replace this with proper logging
	    }

	    return item;
	}


	public static void addCartItem(CartItem item) throws SQLException {
		String sql = "INSERT INTO cart_items (cart_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
		try (Connection con = ConnectionManager.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setInt(1, item.getCartId());
			stmt.setInt(2, item.getProductId());
			stmt.setInt(3, item.getQuantity());
			stmt.setDouble(4, item.getPrice());
			stmt.executeUpdate();
		}
	}

	public static void updateCartItem(CartItem item) throws SQLException {
		String sql = "UPDATE cart_items SET quantity = ?WHERE cart_id = ? AND product_id = ?";
		try (Connection con = ConnectionManager.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setInt(1, item.getQuantity());
			
			stmt.setInt(2, item.getCartId());
			stmt.setInt(3, item.getProductId());
			stmt.executeUpdate();
		}
	}
	
	public static void deleteCartItem(int itemId , int prodId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE cart_id = ? AND product_id = ?";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ps.setInt(2, prodId);
            ps.executeUpdate();
        }
    }

	public static void clearCartItems(int cartId) throws SQLException {
		String sql = "DELETE FROM cart_items WHERE cart_id = ?";
		try (Connection con = ConnectionManager.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setInt(1, cartId);
			stmt.executeUpdate();
		}
	}
	
	public static int getTotalItemsInCart(int cartId) {
        int total = 0;
        String sql = "SELECT count(*) AS total FROM cart_items WHERE cart_id = ?";

        try (
        		Connection con = ConnectionManager.getConnection();
        		PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

	public static boolean itemExists(int cartId, int prodId) throws SQLException {
		String sql = "SELECT COUNT(*) FROM cart_items WHERE cart_id = ? AND product_id = ?";
		try (Connection con = ConnectionManager.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setInt(1, cartId);
			stmt.setInt(2, prodId);
			ResultSet rs = stmt.executeQuery();
			return rs.next() && rs.getInt(1) > 0;
		}
	}
}
