package expose.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import db.connection.ConnectionManager;
import expose.model.Customer;

public class CustomerDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static final String SELECT_CUSTOMER_LOGIN = "SELECT * FROM customers WHERE email = ? AND password = ?";
	private static final String ADD_CUSTOMERS_SQL = "INSERT INTO customers(id,name,email,password,phone,address,created_at,updated_at)VALUES(customer_id_seq.NEXTVAL,?,?,?,?,?,?,?)";
	private static final String SELECT_CUSTOMER_BY_ID = "SELECT * FROM customers WHERE id = ?";
	private static final String SELECT_ALL_CUSTOMERS = "SELECT * FROM customers";
	private static final String DELETE_CUSTOMERS_SQL = "DELETE FROM customers WHERE id = ?";
	private static final String UPDATE_CUSTOMERS_SQL = "UPDATE customers SET name = ? , address = ? , phone = ?, image =? WHERE id = ?";
	private static final String SELECT_CUSTOMER_BY_EMAIL = "SELECT * FROM customers WHERE email=?";
	private static Customer customer = null;
	private static int id;
	private static String email,password;
	
	//login
		public static Customer login(Customer customer) throws SQLException, NoSuchAlgorithmException{
			System.out.println(SELECT_CUSTOMER_LOGIN);
			
			//convert the password to MD5
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(customer.getPassword().getBytes());

			byte byteData[] = md.digest();

			//convert the byte to hex format
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			try {
				//call getConnection() method 
				con = ConnectionManager.getConnection();

				//3. create statement
				ps = con.prepareStatement(SELECT_CUSTOMER_LOGIN);

				ps.setString(1, customer.getEmail());
				ps.setString(2, sb.toString());

				//4. execute query
				rs = ps.executeQuery();

				//process ResultSet
				//if customer exists set the isLoggedIn variable to true
				if (rs.next()) {
					customer.setId(rs.getInt("id"));
					customer.setName(rs.getString("name"));
					customer.setEmail(rs.getString("email"));
					customer.setPassword(rs.getString("password"));
					customer.setPhone(rs.getString("phone"));
					customer.setAddress(rs.getString("address"));
					customer.setImage(rs.getString("image"));
					customer.setCreatedAt(rs.getTimestamp("created_at"));
					
					customer.setLoggedIn(true);

				}
				// if customer does not exist set the isLoggedIn variable to false
				else{
					customer.setLoggedIn(false);
				}

				//5. close connection
				con.close();
			}catch(SQLException e) {
				e.printStackTrace();		
			}

			return customer;
		}

	//add new customer (register)
		public static void addCustomer(Customer customer) throws  SQLException,NoSuchAlgorithmException{
			System.out.println(ADD_CUSTOMERS_SQL);
			
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(customer.getPassword().getBytes());
			byte byteData[] = md.digest();

			//convert the byte to hex format
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

			try {
				//call getConnection() method 
				con = ConnectionManager.getConnection();
				
				LocalDateTime now = LocalDateTime.now();
				Timestamp sqlNow = Timestamp.valueOf(now);
				
				//3. create statement  
				ps = con.prepareStatement(ADD_CUSTOMERS_SQL);
				ps.setString(1, customer.getName());
				ps.setString(2, customer.getEmail());
				ps.setString(3, sb.toString());
				ps.setString(4, customer.getPhone());
				ps.setString(5, customer.getAddress());
				ps.setTimestamp(6, sqlNow); 
				ps.setTimestamp(7, sqlNow); 

				
				
			
				
				
				//4. execute query
				ps.executeUpdate();			
				
				System.out.print("Customer added successfully");
				
				//5. close connection
				con.close();
				
			}catch(Exception e) {
				e.printStackTrace();		
			}
		}


	//select customer by id
	public static Customer getCustomer(int id) {
		System.out.println(SELECT_CUSTOMER_BY_ID);

		Customer customer = new Customer();

		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();

			//3. create statement
			ps = con.prepareStatement(SELECT_CUSTOMER_BY_ID);
			ps.setInt(1, id);

			//4. execute query
			rs = ps.executeQuery();

			//process ResultSet
			if (rs.next()) {
				customer.setId(rs.getInt("id"));
				customer.setName(rs.getString("name"));
				customer.setEmail(rs.getString("email"));
				customer.setPassword(rs.getString("password"));
				customer.setPhone(rs.getString("phone"));
				customer.setAddress(rs.getString("address"));
				customer.setImage(rs.getString("image"));
				customer.setCreatedAt(rs.getTimestamp("created_at"));
			}

			//5. close connection
			con.close();

		}catch(SQLException e) {
			e.printStackTrace();
		}	

		return customer;
	}

	//select all customers
	public static List<Customer> getAllCustomers() { 
		System.out.println(SELECT_ALL_CUSTOMERS);
		
		List<Customer> customers = new ArrayList<Customer>(); 
		try { 
			//call getConnection() method
			con = ConnectionManager.getConnection();

			//3. create statement
			stmt = con.createStatement();

			//4. execute query
			rs = stmt.executeQuery(SELECT_ALL_CUSTOMERS);

			//process ResultSet
			while (rs.next()) { 
				Customer customer = new Customer();
				customer.setId(rs.getInt("id"));
				customer.setEmail(rs.getString("email"));
				customer.setPassword(rs.getString("password"));
				customers.add(customer);
			}

			//5. close connection
			con.close();

		}catch(SQLException e) {
			e.printStackTrace();
		}
		return customers; 
	}

	//delete customer
	public static boolean deleteCustomer(int id) throws SQLException {
		System.out.println(DELETE_CUSTOMERS_SQL);

		boolean rowDeleted=false;
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();

			//3. create statement
			ps = con.prepareStatement(DELETE_CUSTOMERS_SQL);

			ps.setInt(1, id);

			//4. execute query
			rowDeleted = ps.executeUpdate() > 0;

			//5. close connection
			con.close();

		}catch(SQLException e) {
			e.printStackTrace();
		}	
		return rowDeleted;
	}

	//update customer
	public static void updateCustomer(Customer customer){
		System.out.println(UPDATE_CUSTOMERS_SQL);

		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();

			//3. create statement
			ps = con.prepareStatement(UPDATE_CUSTOMERS_SQL);

			ps.setString(1, customer.getName());
			ps.setString(2, customer.getAddress());
			ps.setString(3, customer.getPhone());
			ps.setString(4, customer.getImage());
			ps.setInt(5, customer.getId());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(SQLException e) {
			e.printStackTrace();
		}	
	}
	
	
		//get customer
		public static Customer getCustomer(Customer customer)  {   
			try {
				//call getConnection() method 
				con = ConnectionManager.getConnection();
				
				//3. create statement  
				
				ps=con.prepareStatement(SELECT_CUSTOMER_BY_EMAIL);
				ps.setString(1,customer.getEmail());
				
				//execute statement
				rs = ps.executeQuery();

				// if customer exists set the isValid variable to true
				if (rs.next()) {
					customer.setId(rs.getInt("id"));
					customer.setEmail(rs.getString("email"));
					customer.setPassword(rs.getString("password"));
					
					customer.setValid(true);
				}
				// if customer does not exist set the isValid variable to false
				else{
					customer.setValid(false);
				}
				//5. close connection
				con.close();	
				
			}catch(Exception e) {
				e.printStackTrace();		
			}
			return customer;
		}
		
		public boolean updatePassword(int customerId, String oldPassword, String newPassword) throws SQLException, NoSuchAlgorithmException {
	        // Check if the old password is correct
	        String currentPasswordHash = getCurrentPasswordHash(customerId);
	        if (!currentPasswordHash.equals(md5Hash(oldPassword))) {
	            return false;  // Old password does not match
	        }

	        // Hash the new password before saving
	        String newPasswordHash = md5Hash(newPassword);
	        
	        // Update the password in the database
	        try (Connection con = ConnectionManager.getConnection()) {
	            String updateQuery = "UPDATE customers SET password = ? WHERE id = ?";
	            try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
	                ps.setString(1, newPasswordHash);
	                ps.setInt(2, customerId);
	                
	                int rowsUpdated = ps.executeUpdate();
	                return rowsUpdated > 0;  // Return true if update was successful
	            }
	        }
	    }
		
		public List<Map<String, Object>> getLocationCounts() throws SQLException {
		    List<Map<String, Object>> data = new ArrayList<>();

		    // Map state names to their corresponding vector map codes
		    Map<String, String> stateCodeMap = new HashMap<>();
		    stateCodeMap.put("JOHOR", "my01");
		    stateCodeMap.put("KEDAH", "my02");
		    stateCodeMap.put("KELANTAN", "my03");
		    stateCodeMap.put("MELAKA", "my04");
		    stateCodeMap.put("NEGERI SEMBILAN", "my05");
		    stateCodeMap.put("PAHANG", "my06");
		    stateCodeMap.put("PULAU PINANG", "my07");
		    stateCodeMap.put("PERAK", "my08");
		    stateCodeMap.put("PERLIS", "my09");
		    stateCodeMap.put("SELANGOR", "my10");
		    stateCodeMap.put("TERENGGANU", "my11");
		    stateCodeMap.put("SABAH", "my12");
		    stateCodeMap.put("SARAWAK", "my13");
		    stateCodeMap.put("KUALA LUMPUR", "my14");
		    stateCodeMap.put("PUTRAJAYA", "my15");

		    // Join orders with customers and filter based on address
		    String sql = """
		        SELECT COUNT(*) as count
		        FROM orders o
		        JOIN customers c ON o.customer_id = c.id
		        WHERE o.status != 'Failed' AND o.status != 'Pending' AND
		        UPPER(c.address) LIKE ?
		    """;

		    try (Connection conn = ConnectionManager.getConnection();
		         PreparedStatement stmt = conn.prepareStatement(sql)) {

		        for (Map.Entry<String, String> entry : stateCodeMap.entrySet()) {
		            String stateName = entry.getKey();
		            String stateCode = entry.getValue();

		            stmt.setString(1, "%" + stateName + "%");
		            try (ResultSet rs = stmt.executeQuery()) {
		                if (rs.next()) {
		                    Map<String, Object> record = new HashMap<>();
		                    record.put("state", stateName);
		                    record.put("code", stateCode);
		                    record.put("count", rs.getInt("count"));
		                    data.add(record);
		                }
		            }
		        }
		    }

		    return data;
		}


		public static int getCountCustomer() {
	        int count = 0;
	        try {
	            Connection conn = ConnectionManager.getConnection();
	            String sql = "SELECT COUNT(*) FROM customers";
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
		
	    // Method to get the current password hash of the customer
	    private String getCurrentPasswordHash(int customerId) throws SQLException {
	        String query = "SELECT password FROM customers WHERE id = ?";
	        try (Connection con = ConnectionManager.getConnection(); 
	             PreparedStatement ps = con.prepareStatement(query)) {
	            ps.setInt(1, customerId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    return rs.getString("password");
	                }
	            }
	        }
	        return null;  // Return null if customer not found
	    }

	    // Method to hash the password using MD5
	    private String md5Hash(String password) throws NoSuchAlgorithmException {
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        md.update(password.getBytes());
	        byte[] byteData = md.digest();
	        
	        // Convert byte to hex format
	        StringBuilder sb = new StringBuilder();
	        for (byte b : byteData) {
	            sb.append(String.format("%02x", b));
	        }
	        return sb.toString();
	    }

   
}