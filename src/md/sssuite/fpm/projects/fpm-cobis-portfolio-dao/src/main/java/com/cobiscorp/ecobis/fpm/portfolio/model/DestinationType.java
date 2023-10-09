package com.cobiscorp.ecobis.fpm.portfolio.model;

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
@IdClass(DestinationTypeId.class)
@Table(name = "cr_toperacion_destino", schema = "cob_credito")
@NamedQueries({ @NamedQuery(name = "DestinationType.findAllByDestinationByProduct", query = "select dt from DestinationType dt where dt.productId = :productId") })
public class DestinationType {
	

	/** BankingProduct Id */
	@Id
	@Column(name = "td_toperacion")
	private String productId;
	
	/** Destination or Purpose Id. */
	@Id
	@Column(name = "td_destino")
	private String codeId;
	/** Destination or Purpose Id. */
	
	@Id
	@Column(name = "td_producto")
	private String productType;
	
	
	
	/**
	 * @param productId
	 * @param codeId
	 * @param productType
	 */
	public DestinationType(String productId, String codeId, String productType) {
		super();
		this.productId = productId;
		this.codeId = codeId;
		this.productType = productType;
	}
		
	/**
	 * 
	 */
	public DestinationType() {
		
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
	 * @return the codeId
	 */
	public String getCodeId() {
		return codeId;
	}
	/**
	 * @param codeId the codeId to set
	 */
	public void setCodeId(String codeId) {
		this.codeId = codeId;
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
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((codeId == null) ? 0 : codeId.hashCode());
		result = prime * result
				+ ((productId == null) ? 0 : productId.hashCode());
		result = prime * result
				+ ((productType == null) ? 0 : productType.hashCode());
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
		DestinationType other = (DestinationType) obj;
		if (codeId == null) {
			if (other.codeId != null)
				return false;
		} else if (!codeId.equals(other.codeId))
			return false;
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
		return true;
	}

	
	@Override
	public String toString() {
		return "DestinationType [productId=" + productId + ", codeId=" + codeId
				+ ", productType=" + productType + "]";
	}
	
	
	
}
