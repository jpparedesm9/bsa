package com.cobiscorp.ecobis.clientviewer.admin.dto;

/** 
 * Class to transfer data administrator for consolidated view of customers
 * @author dcumbal
 */

public class ProductAdministratorDTO {
	/** Role code */
	private Integer idRole;
	
	/** Product code */
	private Double idProduct;
	
	/** Visible flag*/
	private Byte visible;
	
	/** Encrypted Flag*/
	private Byte encrypted;
	
	/** Role Nome */
	private String roleName;
	
	/** Product mnemonic */
	private String mnemonic;
	
	/** Product name */
	private String name;
	
	/** Product description */
	private String description;
	
	/** Parent code in hierarchy */
	private Double parent;

	public Integer getIdRole() {
		return idRole;
	}

	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
	}

	public Double getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(Double idProduct) {
		this.idProduct = idProduct;
	}

	public Byte getVisible() {
		return visible;
	}

	public void setVisible(Byte visible) {
		this.visible = visible;
	}

	public Byte getEncrypted() {
		return encrypted;
	}

	public void setEncrypted(Byte encrypted) {
		this.encrypted = encrypted;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getParent() {
		return parent;
	}

	public void setParent(Double parent) {
		this.parent = parent;
	}

	public ProductAdministratorDTO() {
	}
	
	public ProductAdministratorDTO(Integer idRole, Double idProduct, Byte visible,
			Byte encrypted, String roleName, String mnemonic, String name,
			String description, Double parent) {
		super();
		this.idRole = idRole;
		this.idProduct = idProduct;
		this.visible = visible;
		this.encrypted = encrypted;
		this.roleName = roleName;
		this.mnemonic = mnemonic;
		this.name = name;
		this.description = description;
		this.parent = parent;
	}

	public ProductAdministratorDTO(Integer idRole, String roleName) {
		super();
		this.idRole = idRole;
		this.roleName = roleName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idProduct == null) ? 0 : idProduct.hashCode());
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductAdministratorDTO other = (ProductAdministratorDTO) obj;
		if (idProduct == null) {
			if (other.idProduct != null)
				return false;
		} else if (!idProduct.equals(other.idProduct))
			return false;
		if (idRole == null) {
			if (other.idRole != null)
				return false;
		} else if (!idRole.equals(other.idRole))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProductAdministratorDTO [idRole=" + idRole + ", idProduct="
				+ idProduct + ", visible=" + visible + ", encrypted="
				+ encrypted + ", roleName=" + roleName + ", mnemonic="
				+ mnemonic + ", name=" + name + ", description=" + description
				+ ", parent=" + parent + "]";
	}
	
	

}
