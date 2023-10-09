package com.cobiscorp.ecobis.fpm.portfolio.model;


import java.io.Serializable;

/**
 * Class for definition the economic destination and  purpose association
 * @author mcabay
 *
 */
public class PurposeTypeId implements Serializable{
	private static final long serialVersionUID = 1L;

	/** BankingProduct Id */
	private String productId;
	/** Module  Mnemonic */
	private String productType;
	/** Code Purpose*/
	private String purposeCode;
	/** Type purpose*/
	private String type;
	/**
	 * @param productId
	 * @param productType
	 * @param purposeCode
	 * @param type
	 */
	public PurposeTypeId(String productId, String productType,
			String purposeCode, String type) {
		super();
		this.productId = productId;
		this.productType = productType;
		this.purposeCode = purposeCode;
		this.type = type;
	}
	/**
	 * 
	 */
	public PurposeTypeId() {
		
		// TODO Auto-generated constructor stub
	}
	/**
	 * @return the productId
	 */
	public String getProductId() {
		return productId;
	}
	/**
	 * @param productId the productId to set
	 */
	public void setProductId(String productId) {
		this.productId = productId;
	}
	/**
	 * @return the productType
	 */
	public String getProductType() {
		return productType;
	}
	/**
	 * @param productType the productType to set
	 */
	public void setProductType(String productType) {
		this.productType = productType;
	}
	/**
	 * @return the purposeCode
	 */
	public String getPurposeCode() {
		return purposeCode;
	}
	/**
	 * @param purposeCode the purposeCode to set
	 */
	public void setPurposeCode(String purposeCode) {
		this.purposeCode = purposeCode;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((productId == null) ? 0 : productId.hashCode());
		result = prime * result
				+ ((productType == null) ? 0 : productType.hashCode());
		result = prime * result
				+ ((purposeCode == null) ? 0 : purposeCode.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		PurposeTypeId other = (PurposeTypeId) obj;
		if (productId == null) {
			if (other.productId != null)
				return false;
		} else if (!productId.equals(other.productId))
			return false;
		if (productType == null) {
			if (other.productType != null)
				return false;
		} else if (!productType.equals(other.productType))
			return false;
		if (purposeCode == null) {
			if (other.purposeCode != null)
				return false;
		} else if (!purposeCode.equals(other.purposeCode))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "PurposeTypeId [productId=" + productId + ", productType="
				+ productType + ", purposeCode=" + purposeCode + ", type="
				+ type + "]";
	}

	
}
