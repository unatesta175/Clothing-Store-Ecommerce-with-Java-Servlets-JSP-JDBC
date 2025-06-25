package expose.model;

import java.io.Serializable;

public class Cart implements Serializable {
    private int id;
    private int customerId;

    public Cart() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

    
}