package expose.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import expose.model.Customer;
import expose.model.Order;
import expose.model.Payment;
import db.connection.ConnectionManager; // Assuming you have this utility class

public class OrderDAO {
	
	public static List<Order> getAllOrders() throws SQLException {
	    List<Order> orders = new ArrayList<>();

	    String sql = "SELECT o.id AS order_id, o.customer_id, o.status AS order_status, o.totalprice, " +
	                 "o.created_at AS order_created, o.updated_at AS order_updated, " +
	                 "p.id AS payment_id, p.transaction_no, p.amount, p.status AS payment_status, " +
	                 "p.method, p.billcode, p.order_Id, p.created_at AS payment_created, p.updated_at AS payment_updated " +
	                 "FROM orders o " +
	                 "LEFT JOIN payments p ON o.id = p.order_Id " +
	                 "ORDER BY o.created_at DESC";

	    try (Connection conn = ConnectionManager.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Order order = new Order();
	            order.setId(rs.getInt("order_id"));
	            order.setCustomerId(rs.getInt("customer_id"));

	            Customer customer = CustomerDAO.getCustomer(order.getCustomerId());
	            order.setCustomer(customer);
	            order.setStatus(rs.getString("order_status"));
	            order.setTotalPrice(rs.getDouble("totalprice"));
	            order.setCreatedAt(rs.getTimestamp("order_created"));
	            order.setUpdatedAt(rs.getTimestamp("order_updated"));

	            // Create and set payment if it exists
	            int paymentId = rs.getInt("payment_id");
	            if (paymentId != 0) {
	                Payment payment = new Payment();
	                payment.setId(paymentId);
	                payment.setTransactionNo(rs.getString("transaction_no"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setStatus(rs.getString("payment_status"));
	                payment.setMethod(rs.getString("method"));
	                payment.setBillcode(rs.getString("billcode"));
	                payment.setOrderId(rs.getInt("order_Id"));
	                payment.setCreatedAt(rs.getTimestamp("payment_created"));
	                payment.setUpdatedAt(rs.getTimestamp("payment_updated"));

	                order.setPayment(payment);
	            }

	            orders.add(order);
	        }
	    }

	    return orders;
	}
	
	public static List<Order> getAllNewOrders() throws SQLException {
	    List<Order> orders = new ArrayList<>();

	    String sql = "SELECT o.id AS order_id, o.customer_id, o.status AS order_status, o.totalprice, " +
	                 "o.created_at AS order_created, o.updated_at AS order_updated, " +
	                 "p.id AS payment_id, p.transaction_no, p.amount, p.status AS payment_status, " +
	                 "p.method, p.billcode, p.order_Id, p.created_at AS payment_created, p.updated_at AS payment_updated " +
	                 "FROM orders o " +
	                 "LEFT JOIN payments p ON o.id = p.order_Id " +
	                 "WHERE o.status = 'Processing' " +
	                 "ORDER BY o.created_at DESC";

	    try (Connection conn = ConnectionManager.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Order order = new Order();
	            order.setId(rs.getInt("order_id"));
	            order.setCustomerId(rs.getInt("customer_id"));

	            Customer customer = CustomerDAO.getCustomer(order.getCustomerId());
	            order.setCustomer(customer);
	            order.setStatus(rs.getString("order_status"));
	            order.setTotalPrice(rs.getDouble("totalprice"));
	            order.setCreatedAt(rs.getTimestamp("order_created"));
	            order.setUpdatedAt(rs.getTimestamp("order_updated"));

	            // Create and set payment if it exists
	            int paymentId = rs.getInt("payment_id");
	            if (paymentId != 0) {
	                Payment payment = new Payment();
	                payment.setId(paymentId);
	                payment.setTransactionNo(rs.getString("transaction_no"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setStatus(rs.getString("payment_status"));
	                payment.setMethod(rs.getString("method"));
	                payment.setBillcode(rs.getString("billcode"));
	                payment.setOrderId(rs.getInt("order_Id"));
	                payment.setCreatedAt(rs.getTimestamp("payment_created"));
	                payment.setUpdatedAt(rs.getTimestamp("payment_updated"));

	                order.setPayment(payment);
	            }

	            orders.add(order);
	        }
	    }

	    return orders;
	}

	  
		public static int getTotalOrders(int customerId) {
	        int total = 0;
	        String sql = "SELECT count(*) AS total FROM orders WHERE customer_id = ?  AND status != ?";

	        try (
	        		Connection con = ConnectionManager.getConnection();
	        		PreparedStatement stmt = con.prepareStatement(sql)) {
	            stmt.setInt(1, customerId);
		        stmt.setString(2, "Failed");
	            ResultSet rs = stmt.executeQuery();

	            if (rs.next()) {
	                total = rs.getInt("total");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return total;
	    }
		
		public static Double getTotalPriceOrder(int customerId) throws SQLException {
		    String sql = "SELECT SUM(totalprice) AS subtotal FROM orders WHERE customer_id = ? AND status != ?";
		    try (Connection con = ConnectionManager.getConnection();
		         PreparedStatement stmt = con.prepareStatement(sql)) {
		         
		        stmt.setInt(1, customerId);
		        stmt.setString(2, "Failed");
		        ResultSet rs = stmt.executeQuery();
		        
		        if (rs.next()) {
		            return rs.getDouble("subtotal");
		        }
		    }
		    return 0.0;
		}
		
		public static String getLastOrder(int customerId) {
	        String sql = "SELECT * FROM orders WHERE customer_id = ? AND status != ? ORDER BY created_at DESC FETCH FIRST 1 ROWS ONLY";
	        Order order = null;
	        String lastOrderDate = "";

	        try (Connection con = ConnectionManager.getConnection();
			         PreparedStatement stmt = con.prepareStatement(sql)) {
	            stmt.setInt(1, customerId);
	            stmt.setString(2, "Failed");
	            ResultSet rs = stmt.executeQuery();

	            if (rs.next()) {
	                Timestamp ts = rs.getTimestamp("created_at");
	                if (ts != null) {
	                    order = new Order();
	                    order.setCreatedAt(ts);
	                    lastOrderDate = order.timeAgo();
	                } else {
	                    lastOrderDate = "No orders yet";
	                }
	            } else {
	                lastOrderDate = "No orders yet";
	            }


	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return lastOrderDate;
	    }
	  
	  
    
    // Create a new order and return the generated order ID
    public static Order createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (id, customer_id, status, totalprice, created_at, updated_at) VALUES (order_id_seq.NEXTVAL, ?, ?, ?, SYSDATE, SYSDATE)";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, new String[]{"id"})) {
            
            pstmt.setInt(1, order.getCustomerId());
            pstmt.setString(2, order.getStatus());
            pstmt.setDouble(3, order.getTotalPrice());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        order.setId(generatedKeys.getInt(1));
                        return order;
                    }
                }
            }
        }
        throw new SQLException("Creating order failed, no ID obtained.");
    }
    
    // Get order by ID
    public static Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE id = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                
                Customer customer = CustomerDAO.getCustomer(order.getCustomerId());
                order.setCustomer(customer);
                order.setStatus(rs.getString("status"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                return order;
            }
        }
        return null;
    }
    
    public static List<Order> getOrdersByCustomerId(int customerId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT id, customer_id, status, totalprice, created_at, updated_at FROM orders WHERE customer_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
           
                Payment payment = PaymentDAO.getPaymentByOrderId(order.getId());
                order.setPayment(payment);
                order.setCustomerId(rs.getInt("customer_id"));
                order.setStatus(rs.getString("status"));
                order.setTotalPrice(rs.getDouble("totalprice")); // Fixed: was "total_amount"
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                orders.add(order);
            }
        }
        return orders;
    }
    
    // Update order status
    public static boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ?, updated_at = SYSDATE WHERE id = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    public List<Map<String, Object>> getMonthlySales(int month, int year) throws SQLException {
        String sql = "SELECT COUNT(order_id) as sales, DATE_FORMAT(created_at, '%d %b') as date " +
                    "FROM orders WHERE MONTH(created_at) = ? AND YEAR(created_at) = ? " +
                    " AND status != 'failed'  " +
                    "GROUP BY date ORDER BY created_at ASC";
        List<Map<String, Object>> data = new ArrayList<>();
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> record = new HashMap<>();
                    record.put("sales", rs.getInt("sales"));
                    record.put("date", rs.getString("date"));
                    data.add(record);
                }
            }
        }
        return data;
    }
    
    public List<Map<String, Object>> getYearlySales(int year) throws SQLException {
        String sql = "SELECT COUNT(order_id) as sales, DATE_FORMAT(created_at, '%M') as months " +
                    "FROM orders WHERE YEAR(created_at) = ? " +
                    "AND status != 'failed' " +
                    "GROUP BY months ORDER BY created_at ASC";
        List<Map<String, Object>> data = new ArrayList<>();
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, year);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> record = new HashMap<>();
                    record.put("sales", rs.getInt("sales"));
                    record.put("months", rs.getString("months"));
                    data.add(record);
                }
            }
        }
        return data;
    }
    
    public static int getCountSuccessfulOrders() {
        int count = 0;
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT COUNT(*) FROM orders WHERE status = 'Delivered'";
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

    public static int getCountNewOrders() {
        int count = 0;
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT COUNT(*) FROM orders WHERE status = 'Processing'";
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
}