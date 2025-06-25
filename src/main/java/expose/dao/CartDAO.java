package expose.dao;

import expose.model.Cart;
import java.sql.*;

import db.connection.ConnectionManager;



public class CartDAO {
 

    public static Cart getCartByCustomerId(int customerId) throws SQLException {
        String sql = "SELECT * FROM carts WHERE customer_id = ?";
        try (
        		Connection con = ConnectionManager.getConnection();
        		PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setCustomerId(rs.getInt("customer_id"));
                return cart;
            }
        }
        return null;
    }

    public static Cart createCart(int customerId) throws SQLException {
        String getIdSql = "SELECT cart_id_seq.NEXTVAL FROM dual";
        String insertSql = "INSERT INTO carts (id, customer_id) VALUES (?, ?)";

        try (
            Connection con = ConnectionManager.getConnection();
            PreparedStatement getIdStmt = con.prepareStatement(getIdSql);
            ResultSet rs = getIdStmt.executeQuery()
        ) {
            if (rs.next()) {
                int newCartId = rs.getInt(1);

                try (PreparedStatement insertStmt = con.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, newCartId);
                    insertStmt.setInt(2, customerId);
                    int affectedRows = insertStmt.executeUpdate();

                    if (affectedRows == 0) {
                        throw new SQLException("Creating cart failed, no rows affected.");
                    }
                }

                Cart cart = new Cart();
                cart.setId(newCartId);
                cart.setCustomerId(customerId);
                return cart;
            } else {
                throw new SQLException("Failed to get new cart ID from sequence.");
            }
        }
    }




}
