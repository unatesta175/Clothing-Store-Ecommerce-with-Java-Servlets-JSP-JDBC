package expose.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Payment {
	private int id;
	private String transactionNo;
	private double amount;
	private String status;
	private String method;
	private String billcode;
	private int orderId;
	private Timestamp createdAt;
	private Timestamp updatedAt;

	// Constructors
	public Payment() {
	}

	public Payment(String transactionNo, double amount, String status, String method, String billcode, int orderId) {
		this.transactionNo = transactionNo;
		this.amount = amount;
		this.status = status;
		this.method = method;
		this.billcode = billcode;
		this.orderId = orderId;
	}

	// Getters and Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTransactionNo() {
		return transactionNo;
	}

	public void setTransactionNo(String transactionNo) {
		this.transactionNo = transactionNo;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getBillcode() {
		return billcode;
	}

	public void setBillcode(String billcode) {
		this.billcode = billcode;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
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
}