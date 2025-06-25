package expose.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

public class Customer implements Serializable{
	
	private int id;
	private String name;
	private String email;
	private String password;
	private String phone;
	private String address;
	
	private boolean loggedIn = false;
	private boolean valid;
	private String image;
	
	 public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	private Timestamp createdAt;
	 private Timestamp updatedAt;
	 
	public Customer() {
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;	
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public boolean isLoggedIn() {
		return loggedIn;
	}
	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}
	
	public boolean isValid() {
		return valid;
	}
	public void setValid(boolean valid) {
		this.valid = valid;
	}
	
	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	 public String timeAgo() {
	        // 1. Check if createdAt is null before attempting conversion
	        if (this.createdAt == null) {
	            return "unknown"; // Or some default text
	        }

	        // 2. Convert the java.sql.Timestamp to java.time.LocalDateTime
	        LocalDateTime createdAtLocalDateTime = this.createdAt.toLocalDateTime();

	        // 3. Get the current time
	        LocalDateTime now = LocalDateTime.now();

	        // 4. Perform calculations (rest of the logic is the same)
	        long years = ChronoUnit.YEARS.between(createdAtLocalDateTime, now);
	        long months = ChronoUnit.MONTHS.between(createdAtLocalDateTime, now);
	        long weeks = ChronoUnit.WEEKS.between(createdAtLocalDateTime, now);
	        long days = ChronoUnit.DAYS.between(createdAtLocalDateTime, now);
	        long hours = ChronoUnit.HOURS.between(createdAtLocalDateTime, now);
	        long minutes = ChronoUnit.MINUTES.between(createdAtLocalDateTime, now);

	        // 5. Determine the display string
	        if (years > 0) {
	            return years + " year" + (years > 1 ? "s" : "") + " ago";
	        } else if (months > 0) {
	            return months + " month" + (months > 1 ? "s" : "") + " ago";
	        } else if (weeks > 0) {
	            return weeks + " week" + (weeks > 1 ? "s" : "") + " ago";
	        } else if (days > 0) {
	            return days + " day" + (days > 1 ? "s" : "") + " ago";
	        } else if (hours > 0) {
	             return hours + " hour" + (hours > 1 ? "s" : "") + " ago"; // Added hours
	        } else if (minutes > 0) {
	            return minutes + " minute" + (minutes > 1 ? "s" : "") + " ago"; // Added minutes
	        }
	         else {
	            return "just now"; // Changed from "today" for better granularity
	        }
	    }
	
	

	
}