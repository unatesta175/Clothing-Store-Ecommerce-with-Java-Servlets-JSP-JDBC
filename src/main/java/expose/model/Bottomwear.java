package expose.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Bottomwear extends Product implements Serializable {
	
	
    private String fitType;

	public Bottomwear(int id, String name, String size, double price, String description, int stock, String image,
			String type, String category, Timestamp createdAt, Timestamp updatedAt , String fitType) {
		super(id, name, size, price, description, stock, image, type, category, createdAt, updatedAt );
		this.fitType = fitType;
		// TODO Auto-generated constructor stub
	}

	

    public Bottomwear() {}



	public String getFitType() {
		return fitType;
	}

	public void setFitType(String fitType) {
		this.fitType = fitType;
	}

    
}