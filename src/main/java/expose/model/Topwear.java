package expose.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Topwear extends Product implements Serializable {
	
	
    private String collarType;

    public Topwear() {}
    
    
   


	public Topwear(int id, String name, String size, double price, String description, int stock, String image,
			String type, String category, Timestamp createdAt, Timestamp updatedAt , String collarType) {
		super(id, name, size, price, description, stock, image, type, category, createdAt, updatedAt);
		// TODO Auto-generated constructor stub
		this.collarType =collarType;
	}







	public String getCollarType() {
		return collarType;
	}

	public void setCollarType(String collarType) {
		this.collarType = collarType;
	}

	


}