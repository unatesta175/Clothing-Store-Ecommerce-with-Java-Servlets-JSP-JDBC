package expose.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class Order implements Serializable {
    private int id;
    private String status;
    private int customerId;
    private double totalPrice;
    private Customer customer;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Payment payment;

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	

    public Order() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public Order(  int customerId, String status, double totalPrice) {
		
		this.status = status;
		this.customerId = customerId;
		this.totalPrice = totalPrice;
		
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
	
	  
    public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
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
