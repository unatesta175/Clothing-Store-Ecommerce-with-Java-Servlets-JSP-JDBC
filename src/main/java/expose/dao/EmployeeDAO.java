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
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import db.connection.ConnectionManager;
import expose.model.Employee;

public class EmployeeDAO {

	private static final String SELECT_EMPLOYEE_LOGIN = "SELECT * FROM employees WHERE email = ? AND password = ?";
	private static final String ADD_EMPLOYEES_SQL = "INSERT INTO employees(id,name,phone,email,password,role,admin_id,created_at,updated_at)VALUES(employee_id_seq.NEXTVAL,?,?,?,?,?,?,?,?)";
	private static final String SELECT_EMPLOYEE_BY_ID = "SELECT * FROM employees WHERE id = ?";
	private static final String SELECT_ALL_EMPLOYEES = "SELECT e.* , m.name as manager_name FROM employees e LEFT OUTER JOIN employees m ON e.admin_id = m.id";
	private static final String DELETE_EMPLOYEES_SQL = "DELETE FROM employees WHERE id = ?";
	private static final String UPDATE_EMPLOYEES_SQL = "UPDATE employees SET name = ? ,  phone = ? , email = ? , role =? , admin_id =? , updated_at = ? , image = ? WHERE id = ?";
	private static final String SELECT_EMPLOYEE_BY_EMAIL = "SELECT * FROM employees WHERE email=?";

	// login
	public static Employee login(Employee employee) throws SQLException, NoSuchAlgorithmException {
		System.out.println(SELECT_EMPLOYEE_LOGIN);

		// convert the password to MD5
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(employee.getPassword().getBytes());

		byte byteData[] = md.digest();

		// convert the byte to hex format
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		}

		try {
			// call getConnection() method
			Connection con = ConnectionManager.getConnection();

			// 3. create statement
			PreparedStatement ps = con.prepareStatement(SELECT_EMPLOYEE_LOGIN);

			ps.setString(1, employee.getEmail());
			ps.setString(2, sb.toString());

			// 4. execute query
			ResultSet rs = ps.executeQuery();

			// process ResultSet
			// if employee exists set the isLoggedIn variable to true
			if (rs.next()) {
				employee.setId(rs.getInt("id"));
				employee.setName(rs.getString("name"));
				employee.setPhone(rs.getString("phone"));
				employee.setEmail(rs.getString("email"));
				employee.setPassword(rs.getString("password"));
				employee.setRole(rs.getString("role"));
				employee.setImage(rs.getString("image"));
				employee.setAdminId(rs.getInt("admin_id"));
				employee.setCreatedAt(rs.getTimestamp("created_at"));
				employee.setLoggedIn(true);

			}
			// if employee does not exist set the isLoggedIn variable to false
			else {
				employee.setLoggedIn(false);
			}

			// 5. close connection
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return employee;
	}

	// add new employee (register)
	public static void addEmployee(Employee employee) throws SQLException, NoSuchAlgorithmException {
		System.out.println(ADD_EMPLOYEES_SQL);

		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(employee.getPassword().getBytes());
		byte byteData[] = md.digest();

		// convert the byte to hex format
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		}

		try {
			// call getConnection() method
			Connection con = ConnectionManager.getConnection();

			LocalDateTime now = LocalDateTime.now();
			Timestamp sqlNow = Timestamp.valueOf(now);

			// 3. create statement
			PreparedStatement ps = con.prepareStatement(ADD_EMPLOYEES_SQL);
			ps.setString(1, employee.getName());
			ps.setString(2, employee.getPhone());
			ps.setString(3, employee.getEmail());
			ps.setString(4, sb.toString());
			ps.setString(5, employee.getRole());
			if (employee.getAdminId() != null) {
				ps.setInt(6, employee.getAdminId());
			} else {
				ps.setNull(6, Types.INTEGER);
			}
			ps.setTimestamp(7, sqlNow);
			ps.setTimestamp(8, sqlNow);

			// 4. execute query
			ps.executeUpdate();

			System.out.print("Employee added successfully");

			// 5. close connection
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// select employee by id
	public static Employee getEmployee(Integer id) {
		System.out.println(SELECT_EMPLOYEE_BY_ID);

		Employee employee = new Employee();

		try {
			// call getConnection() method
			Connection con = ConnectionManager.getConnection();

			// 3. create statement
			PreparedStatement ps = con.prepareStatement(SELECT_EMPLOYEE_BY_ID);
			ps.setInt(1, id);

			// 4. execute query
			ResultSet rs = ps.executeQuery();

			// process ResultSet
			if (rs.next()) {
				employee.setId(rs.getInt("id"));
				employee.setName(rs.getString("name"));
				employee.setEmail(rs.getString("email"));
				employee.setPhone(rs.getString("phone"));
				employee.setPassword(rs.getString("password"));
				employee.setRole(rs.getString("role"));
				employee.setAdminId(rs.wasNull() ? null : rs.getInt("admin_id"));
				employee.setImage(rs.getString("image"));  
				employee.setCreatedAt(rs.getTimestamp("created_at"));
				employee.setUpdatedAt(rs.getTimestamp("updated_at"));

			}

			// 5. close connection
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return employee;
	}

	// select all employees
	public static List<Employee> getAllEmployees() {
		List<Employee> employees = new ArrayList<>();

		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SELECT_ALL_EMPLOYEES);
				ResultSet rs = ps.executeQuery();) {
			while (rs.next()) {
				Employee employee = new Employee();
				employee.setId(rs.getInt("id"));
				employee.setName(rs.getString("name"));
				employee.setEmail(rs.getString("email"));
				employee.setPhone(rs.getString("phone"));
				employee.setPassword(rs.getString("password"));
				employee.setRole(rs.getString("role"));
				employee.setCreatedAt(rs.getTimestamp("created_at"));
				employee.setUpdatedAt(rs.getTimestamp("updated_at"));
				employee.setImage(rs.getString("image")); 
				int managerId = rs.getInt("admin_id");
				employee.setAdminId(rs.wasNull() ? null : managerId);

				// rs.wasNull() refers to the last column read of admin_id

				String managerName = rs.getString("manager_name");
				if (managerName != null) {
					Employee manager = new Employee();
					manager.setName(managerName);
					employee.setManager(manager);
				}

				employees.add(employee);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return employees;
	}

	// delete employee
	public static boolean deleteEmployee(int id) throws SQLException {
		System.out.println(DELETE_EMPLOYEES_SQL);

		boolean rowDeleted = false;
		try {
			// call getConnection() method
			Connection con = ConnectionManager.getConnection();

			// 3. create statement
			PreparedStatement ps = con.prepareStatement(DELETE_EMPLOYEES_SQL);

			ps.setInt(1, id);

			// 4. execute query
			rowDeleted = ps.executeUpdate() > 0;

			// 5. close connection
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowDeleted;
	}

	// update employee
	public static void updateEmployee(Employee employee) {
		System.out.println(UPDATE_EMPLOYEES_SQL);

		try {
			// call getConnection() method
			Connection con = ConnectionManager.getConnection();

			// 3. create statement
			PreparedStatement ps = con.prepareStatement(UPDATE_EMPLOYEES_SQL);

			LocalDateTime now = LocalDateTime.now();
			Timestamp sqlNow = Timestamp.valueOf(now);

			ps.setString(1, employee.getName());
			ps.setString(2, employee.getPhone());
			ps.setString(3, employee.getEmail());
			ps.setString(4, employee.getRole());
			if (employee.getAdminId() != null) {
				ps.setInt(5, employee.getAdminId());
			} else {
				ps.setNull(5, Types.INTEGER);
			}
			ps.setTimestamp(6, sqlNow);
			ps.setString(7, employee.getImage()); // image file path
			ps.setInt(8, employee.getId());

			// 4. execute query
			ps.executeUpdate();

			// 5. close connection
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// get employee
	public static Employee getEmployee(Employee employee) {
		try {
			// call getConnection() method
			Connection con = ConnectionManager.getConnection();

			// 3. create statement

			PreparedStatement ps = con.prepareStatement(SELECT_EMPLOYEE_BY_EMAIL);
			ps.setString(1, employee.getEmail());

			// execute statement
			ResultSet rs = ps.executeQuery();

			// if employee exists set the isValid variable to true
			if (rs.next()) {
				employee.setId(rs.getInt("id"));
				employee.setEmail(rs.getString("email"));
				employee.setPassword(rs.getString("password"));

				employee.setValid(true);
			}
			// if employee does not exist set the isValid variable to false
			else {
				employee.setValid(false);
			}
			// 5. close connection
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return employee;
	}

	public boolean updatePassword(int employeeId, String oldPassword, String newPassword)
			throws SQLException, NoSuchAlgorithmException {
		// Check if the old password is correct
		String currentPasswordHash = getCurrentPasswordHash(employeeId);
		if (!currentPasswordHash.equals(md5Hash(oldPassword))) {
			return false; // Old password does not match
		}

		// Hash the new password before saving
		String newPasswordHash = md5Hash(newPassword);

		// Update the password in the database
		try (Connection con = ConnectionManager.getConnection()) {
			String updateQuery = "UPDATE employees SET password = ? WHERE id = ?";
			try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
				ps.setString(1, newPasswordHash);
				ps.setInt(2, employeeId);

				int rowsUpdated = ps.executeUpdate();
				return rowsUpdated > 0; // Return true if update was successful
			}
		}
	}

	// Method to get the current password hash of the employee
	private String getCurrentPasswordHash(int employeeId) throws SQLException {
		String query = "SELECT password FROM employees WHERE id = ?";
		try (Connection con = ConnectionManager.getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
			ps.setInt(1, employeeId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return rs.getString("password");
				}
			}
		}
		return null; // Return null if employee not found
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