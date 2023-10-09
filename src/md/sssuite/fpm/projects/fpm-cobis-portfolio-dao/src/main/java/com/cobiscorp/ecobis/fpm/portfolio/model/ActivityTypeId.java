package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.io.Serializable;

/**
 * Class for definition the economic destination and activity association
 * 
 * @author mcabay
 * 
 */
public class ActivityTypeId implements Serializable {
	private static final long serialVersionUID = 1L;

	/** BankingProduct Id */
	private String productId;
	/** Module Mnemonic */
	private String productType;
	private String activityCode;
	private String type;

	/**
	 * @param productId
	 * @param productType
	 * @param activityCode
	 * @param type
	 */
	public ActivityTypeId(String productId, String productType,
			String activityCode, String type) {
		super();
		this.productId = productId;
		this.productType = productType;
		this.activityCode = activityCode;
		this.type = type;
	}

	/**
	 * 
	 */
	public ActivityTypeId() {

		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the productId
	 */
	public String getProductId() {
		return productId;
	}

	/**
	 * @param productId
	 *            the productId to set
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
	 * @param productType
	 *            the productType to set
	 */
	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getActivityCode() {
		return activityCode;
	}

	public void setActivityCode(String activityCode) {
		this.activityCode = activityCode;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
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
				+ ((activityCode == null) ? 0 : activityCode.hashCode());
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
		ActivityTypeId other = (ActivityTypeId) obj;
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
		if (activityCode == null) {
			if (other.activityCode != null)
				return false;
		} else if (!activityCode.equals(other.activityCode))
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
		return "ActivityTypeId [productId=" + productId + ", productType="
				+ productType + ", activityCode=" + activityCode + ", type="
				+ type + "]";
	}

}
