package com.cobiscorp.ecobis.clientviewer.admin.dto;

import java.util.List;

/**
 * Class to transfer data by default the administrator for consolidated view of
 * customers
 * 
 * @author dcumbal
 */

public class DefaultProductAdministratorDTO {
	/** Product code */
	private Double idProduct;
	/** DTO id */
	private Integer idDtoFk;
	/** Product mnemonic */
	private String mnemonic;
	/** Product name */
	private String name;
	/** Product description */
	private String description;
	/** Parent code in hierarchy */
	private Double parent;
	/** Role code default */
	private Integer idRol;
	/** Visible flag default */
	private Byte visible;
	/** Encrypted flag default */
	private Byte encrypted;
	/** Role description default */
	private String defaultRoleDescription;
	/** dto id */
	private DtosDTO dtoId;
	/** dto_type_client */
	private String clientType;
	/** prd_order */
	private Integer order;

	private List<DefaultProductAdministratorDTO> defaultProductSons;

	public List<DefaultProductAdministratorDTO> getConditionDefaultProductSons() {
		return defaultProductSons;
	}

	public void setConditionDefaultProductSons(
			List<DefaultProductAdministratorDTO> defaultProductSons) {
		this.defaultProductSons = defaultProductSons;
	}

	public String getTypeClient() {
		return clientType;
	}

	public void setTypeClient(String typeClient) {
		this.clientType = typeClient;
	}

	public DtosDTO getDtoId() {
		return dtoId;
	}

	public void setDtoId(DtosDTO dtoId) {
		this.dtoId = dtoId;
	}

	public Double getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(Double idProduct) {
		this.idProduct = idProduct;
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

	public Integer getIdRol() {
		return idRol;
	}

	public void setIdRol(Integer idRol) {
		this.idRol = idRol;
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

	public String getDefaultRoleDescription() {
		return defaultRoleDescription;
	}

	public void setDefaultRoleDescription(String defaultRoleDescription) {
		this.defaultRoleDescription = defaultRoleDescription;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public String getClientType() {
		return clientType;
	}

	public void setClientType(String clientType) {
		this.clientType = clientType;
	}

	public Integer getIdDtoFk() {
		return idDtoFk;
	}

	public void setIdDtoFk(Integer idDtoFk) {
		this.idDtoFk = idDtoFk;
	}

	public DefaultProductAdministratorDTO() {

	}

	public DefaultProductAdministratorDTO(Double idProduct, Integer idDtoFk,
			String mnemonic, String name, String description, Double parent,
			Integer order) {
		this.idProduct = idProduct;
		this.mnemonic = mnemonic;
		this.idDtoFk = idDtoFk;
		this.name = name;
		this.description = description;
		this.parent = parent;
		this.encrypted = 0;
		this.visible = 1;
		this.idRol = -1;
		this.order = order;
		this.defaultRoleDescription = "ROL_DEFAULT_VCC";
	}

	public DefaultProductAdministratorDTO(Double idProduct, Integer idDtoFk,
			String mnemonic, String name, String description, Double parent,
			DtosDTO dtoId, String typeClient, Integer order) {
		this.idProduct = idProduct;
		this.mnemonic = mnemonic;
		this.idDtoFk = idDtoFk;
		this.name = name;
		this.description = description;
		this.parent = parent;
		this.encrypted = 0;
		this.visible = 1;
		this.idRol = -1;
		this.defaultRoleDescription = "ROL_DEFAULT_VCC";
		this.dtoId = dtoId;
		this.clientType = typeClient;
		this.order = order;
	}
	
	public DefaultProductAdministratorDTO(Double idProduct, Integer idDtoFk,
			String mnemonic, String name, String description, Double parent,
		    String typeClient, Integer order) {
		this.idProduct = idProduct;
		this.mnemonic = mnemonic;
		this.idDtoFk = idDtoFk;
		this.name = name;
		this.description = description;
		this.parent = parent;
		this.encrypted = 0;
		this.visible = 1;
		this.idRol = -1;
		this.defaultRoleDescription = "ROL_DEFAULT_VCC";
		this.clientType = typeClient;
		this.order = order;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idProduct == null) ? 0 : idProduct.hashCode());
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
		DefaultProductAdministratorDTO other = (DefaultProductAdministratorDTO) obj;
		if (idProduct == null) {
			if (other.idProduct != null)
				return false;
		} else if (!idProduct.equals(other.idProduct))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DefaultProductAdministratorDTO [idProduct=" + idProduct
				+ ", mnemonic=" + mnemonic + ", name=" + name
				+ ", description=" + description + ", parent=" + parent
				+ ", idRol=" + idRol + ", visible=" + visible + ", encrypted="
				+ encrypted + ", defaultRoleDescription="
				+ defaultRoleDescription + ", dtoId=" + dtoId + ", order="
				+ order + ", idDtoFk=" + idDtoFk + "]";
	}

}
