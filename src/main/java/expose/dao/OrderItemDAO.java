package expose.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import expose.model.OrderItem;
import expose.model.Product;
import db.connection.ConnectionManager;

public class OrderItemDAO {
    
    // Add order item
    public static boolean addOrderItem(OrderItem orderItem) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getProductId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getPrice());
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Add multiple order items (batch insert)
    public static boolean addOrderItems(List<OrderItem> orderItems) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (OrderItem item : orderItems) {
                pstmt.setInt(1, item.getOrderId());
                pstmt.setInt(2, item.getProductId());
                pstmt.setInt(3, item.getQuantity());
                pstmt.setDouble(4, item.getPrice());
                pstmt.addBatch();
            }
            
            int[] results = pstmt.executeBatch();
            conn.commit();
            
            // Check if all inserts were successful
            for (int result : results) {
                if (result == PreparedStatement.EXECUTE_FAILED) {
                    return false;
                }
            }
            return true;
        } catch (SQLException e) {
            throw e;
        }
    }
    
    // Get order items by order ID
    public static List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT oi.*, p.name, p.image , p.category , p.prod_size , p.price as priceproduct FROM order_items oi " +
                    "LEFT JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                
                Product product = new Product();
	            product.setId(rs.getInt("product_id"));
	            product.setName(rs.getString("name"));
	            product.setImage(rs.getString("image"));
	            product.setPrice(rs.getDouble("priceproduct"));
	            product.setCategory(rs.getString("category"));
	            product.setSize(rs.getString("prod_size"));
	            item.setProduct(product);
               
                orderItems.add(item);
            }
        }
        return orderItems;
    }
    
    public static Double getTotalPriceOrder(int orderId) throws SQLException {
	    String sql = "SELECT SUM(price * quantity) AS subtotal FROM order_items WHERE order_id = ?";
	    try (Connection con = ConnectionManager.getConnection();
	         PreparedStatement stmt = con.prepareStatement(sql)) {
	         
	        stmt.setInt(1, orderId);
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            return rs.getDouble("subtotal");
	        }
	    }
	    return 0.0;
	}
}