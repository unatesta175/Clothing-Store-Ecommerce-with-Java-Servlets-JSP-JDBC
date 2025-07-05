package expose.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Product implements Serializable {
    private int id;
    private String name;
    private String size;
    private double price;
    private String description;
    private int stock;
    private String image;
    private String type;
    private String category;
    private int variantCount;
	private Timestamp createdAt;
    private Timestamp updatedAt;

    public Product() {}
    
    public Product(int id, String name, String size, double price, String description, int stock, String image,
			String type, String category, Timestamp createdAt, Timestamp updatedAt) {
		this.id = id;
		this.name = name;
		this.size = size;
		this.price = price;
		this.description = description;
		this.stock = stock;
		this.image = image;
		this.type = type;
		this.category = category;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public String getType() {
  		return type;
  	}

  	public void setType(String type) {
  		this.type = type;
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

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	
	 public int getVariantCount() {
	        return variantCount;
	    }

	    public void setVariantCount(int variantCount) {
	        this.variantCount = variantCount;
	    }

	

    
}