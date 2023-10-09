package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@IdClass(ActivityTypeId.class)
@Table(name = "cr_toperacion_actividad", schema = "cob_credito")
@NamedQueries({ @NamedQuery(name = "ActivityType.findAllByActivityByProduct", query = "select at from ActivityType at where at.productId = :productId") })
public class ActivityType {

	/** BankingProduct Id */
	@Id
	@Column(name = "ta_identificador")
	private String productId;

	@Id
	@Column(name = "ta_producto")
	private String productType;

	@Id
	@Column(name = "ta_proposito")
	private String activityCode;

	@Id
	@Column(name = "ta_tipo")
	private String type;

	@Column(name = "ta_usuario")
	private String user;

	@Column(name = "ta_fecha")
	private Date dateActivity;

	/**
	 * 
	 */
	public ActivityType() {

		// TODO Auto-generated constructor stub
	}

	/**
	 * @param productId
	 * @param productType
	 * @param activityCode
	 * @param user
	 * @param date
	 * @param type
	 */
	public ActivityType(String productId, String productType,
			String activityCode, String user, Date dateActivity, String type) {
		super();
		this.productId = productId;
		this.productType = productType;
		this.activityCode = activityCode;
		this.user = user;
		this.dateActivity = dateActivity;
		this.type = type;
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

	/**
	 * @return the user
	 */
	public String getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(String user) {
		this.user = user;
	}

	public String getActivityCode() {
		return activityCode;
	}

	public void setActivityCode(String activityCode) {
		this.activityCode = activityCode;
	}

	public Date getDateActivity() {
		return dateActivity;
	}

	public void setDateActivity(Date dateActivity) {
		this.dateActivity = dateActivity;
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
	public String toString() {
		return "ActivityType [productId=" + productId + ", productType="
				+ productType + ", activityCode=" + activityCode + ", type="
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
		ActivityType other = (ActivityType) obj;
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

}
