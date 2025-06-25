package expose.dao;

import expose.model.Payment;
import db.connection.ConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class PaymentDAO {
    
	public static boolean createPayment(Payment payment) throws SQLException {
	    String sql = "INSERT INTO payments (id, transaction_no, amount, status, method, billcode, order_id, created_at) " +
	                 "VALUES (payment_id_seq.nextval, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
	    
	    try (Connection conn = ConnectionManager.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setString(1, payment.getTransactionNo());
	        stmt.setDouble(2, payment.getAmount());
	        stmt.setString(3, payment.getStatus());
	        stmt.setString(4, payment.getMethod());
	        stmt.setString(5, payment.getBillcode());
	        stmt.setInt(6, payment.getOrderId());
	        
	        int affectedRows = stmt.executeUpdate();
	        
	        if (affectedRows > 0) {
	            // Query back to get the generated ID
	            String selectSql = "SELECT id FROM payments WHERE order_id = ? AND billcode = ? AND rownum = 1 ORDER BY created_at DESC";
	            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
	                selectStmt.setInt(1, payment.getOrderId());
	                selectStmt.setString(2, payment.getBillcode());
	                
	                try (ResultSet rs = selectStmt.executeQuery()) {
	                    if (rs.next()) {
	                        payment.setId(rs.getInt("id"));
	                    }
	                }
	            }
	            return true;
	        }
	        return false;
	    }
	}
    
    public static Payment getPaymentByOrderId(int orderId) throws SQLException {
        String sql = "SELECT * FROM payments WHERE order_id = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setTransactionNo(rs.getString("transaction_no"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setStatus(rs.getString("status"));
                payment.setMethod(rs.getString("method"));
                payment.setBillcode(rs.getString("billcode"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
                payment.setUpdatedAt(rs.getTimestamp("updated_at"));
                return payment;
            }
            return null;
        }
    }
    
    public static Payment getPaymentByBillCode(String billcode) throws SQLException {
        String sql = "SELECT * FROM payments WHERE billcode = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, billcode);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setTransactionNo(rs.getString("transaction_no"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setStatus(rs.getString("status"));
                payment.setMethod(rs.getString("method"));
                payment.setBillcode(rs.getString("billcode"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
                payment.setUpdatedAt(rs.getTimestamp("updated_at"));
                return payment;
            }
            return null;
        }
    }
    
    public static Payment getPaymentByTransactionNo(String transactionNo) throws SQLException {
        String sql = "SELECT * FROM payments WHERE transaction_no = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, transactionNo);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setTransactionNo(rs.getString("transaction_no"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setStatus(rs.getString("status"));
                payment.setMethod(rs.getString("method"));
                payment.setBillcode(rs.getString("billcode"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
                payment.setUpdatedAt(rs.getTimestamp("updated_at"));
                return payment;
            }
            return null;
        }
    }
    
    public static boolean updatePaymentStatus(String billcode, String status, String transactionNo) throws SQLException {
        String sql = "UPDATE payments SET status = ?, transaction_no = ?, updated_at = CURRENT_TIMESTAMP WHERE billcode = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, transactionNo);
         
            stmt.setString(3, billcode);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public static boolean updatePaymentStatusOnly(String billcode, String status) throws SQLException {
        String sql = "UPDATE payments SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE billcode = ?";
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, billcode);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public static List<Payment> getPaymentsByCustomerId(int customerId) throws SQLException {
        String sql = "SELECT p.* FROM payments p " +
                    "INNER JOIN orders o ON p.order_id = o.id " +
                    "WHERE o.customer_id = ? ORDER BY p.created_at DESC";
        
        List<Payment> payments = new ArrayList<>();
        
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setTransactionNo(rs.getString("transaction_no"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setStatus(rs.getString("status"));
                payment.setMethod(rs.getString("method"));
                payment.setBillcode(rs.getString("billcode"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
                payment.setUpdatedAt(rs.getTimestamp("updated_at"));
                payments.add(payment);
            }
        }
        
        return payments;
    }
}