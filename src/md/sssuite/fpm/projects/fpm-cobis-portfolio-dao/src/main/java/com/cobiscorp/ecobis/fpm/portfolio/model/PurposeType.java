package com.cobiscorp.ecobis.fpm.portfolio.model;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Class for definition the economic destination and  purpose association
 * @author mcabay
 *
 */

@Entity
@IdClass(PurposeTypeId.class)
@Table(name = "cr_tipo_proposito", schema = "cob_credito")
@NamedQueries({ @NamedQuery(name = "PurposeType.findAllByPurposeByProduct", query = "select pt from PurposeType pt where pt.productId = :productId") })
public class PurposeType {
	

	/** BankingProduct Id */
	@Id
	@Column(name = "td_identificador")
	private String productId;
	
	/** Destination or Purpose Id. */
	@Id
	@Column(name = "td_producto")
	private String productType;
	/** Destination or Purpose Id. */
	
	@Id
	@Column(name = "td_proposito")
	private String purposeCode;
	
	@Id
	@Column(name = "td_tipo")
	private String type;
	
	@Column(name = "td_usuario")
	private String user;
	
	@Column(name = "td_fecha")
	private Date datePurpose;
	
	

	/**
	 * 
	 */
	public PurposeType() {
		
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param productId
	 * @param productType
	 * @param purposeCode
	 * @param user
	 * @param date
	 * @param type
	 */
	public PurposeType(String productId, String productType,
			String purposeCode, String user, Date datePurpose, String type) {
		super();
		this.productId = productId;
		this.productType = productType;
		this.purposeCode = purposeCode;
		this.user = user;
		this.datePurpose = datePurpose;
		this.type = type;
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
	 * @return the user
	 */
	public String getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(String user) {
		this.user = user;
	}

	/**
	 * @return the date
	 */
	public Date getDatePurpose() {
		return datePurpose;
	}

	/**
	 * @param date the date to set
	 */
	public void setDatePurpose(Date datePurpose) {
		this.datePurpose = datePurpose;
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
	public String toString() {
		return "PurposeType [productId=" + productId + ", productType="
				+ productType + ", purposeCode=" + purposeCode + ", type="
				+ type + "]";
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
		PurposeType other = (PurposeType) obj;
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
	
	
	
}
