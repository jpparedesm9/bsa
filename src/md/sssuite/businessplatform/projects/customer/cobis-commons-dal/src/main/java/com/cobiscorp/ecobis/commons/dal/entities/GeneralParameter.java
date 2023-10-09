package com.cobiscorp.ecobis.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


@Entity
@IdClass(GeneralParameterId.class)
@Table(name = "cl_parametro", schema = "cobis")
@NamedQueries({ 
	@NamedQuery(name = "GeneralParameter.getParameter", query = "SELECT new com.cobiscorp.ecobis.commons.dal.entities.GeneralParameter(g.fieldMoney, g.fieldTinyint, g.fieldChar, g.fieldInt, g.fieldFloat)"		
			+ " from GeneralParameter g "				
			+ " WHERE (g.product = :product) AND (g.mnemonic = :mnemonic) "),
	
	@NamedQuery(name = "GeneralParameter.getParameterByNemonic", query = "SELECT new com.cobiscorp.ecobis.commons.dal.entities.GeneralParameter(g.fieldMoney, g.fieldTinyint, g.fieldChar, g.fieldInt, g.fieldFloat)"		
			+ " from GeneralParameter g "				
			+ " WHERE (g.mnemonic = :mnemonic) ") })

/**
 * Class used to access the database using JPA
 * related table: cl_parametro, bdd: cobis
 * @author bbuendia
 *
 */
public class GeneralParameter {
	
	@Id
	@Column(name = "pa_producto")
	private String product;
	
	@Id
	@Column(name = "pa_nemonico")
	private String mnemonic;
	
	@Column(name = "pa_money")
	private Double fieldMoney;
	
	@Column(name = "pa_tinyint")
	private Integer fieldTinyint;
	
	@Column(name = "pa_char")
	private String fieldChar;
	
	@Column(name = "pa_int")
	private Integer fieldInt;
	
	@Column(name = "pa_float")
	private Float fieldFloat;
	
	/** Default constructor */
	public GeneralParameter() {
		
	}
	
	/** Constructor */
	public GeneralParameter(String product, String mnemonic, Double fieldMoney, Integer fieldTinyint, 
			                String fieldChar, Integer fieldInt, Float fieldFloat) {
		this.product = product;
		this.mnemonic = mnemonic;
		this.fieldMoney = fieldMoney;
		this.fieldTinyint = fieldTinyint;
		this.fieldChar = fieldChar;
		this.fieldInt = fieldInt;
		this.fieldFloat = fieldFloat;
	}
	/** Constructor */
	public GeneralParameter(Double fieldMoney, Integer fieldTinyint, 
            String fieldChar, Integer fieldInt, Float fieldFloat) {
		this.fieldMoney = fieldMoney;
		this.fieldTinyint = fieldTinyint;
		this.fieldChar = fieldChar;
		this.fieldInt = fieldInt;
		this.fieldFloat = fieldFloat;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	public Double getFieldMoney() {
		return fieldMoney;
	}

	public void setFieldMoney(Double fieldMoney) {
		this.fieldMoney = fieldMoney;
	}

	public Integer getFieldTinyint() {
		return fieldTinyint;
	}

	public void setFieldTinyint(Integer fieldTinyint) {
		this.fieldTinyint = fieldTinyint;
	}

	public String getFieldChar() {
		return fieldChar;
	}

	public void setFieldChar(String fieldChar) {
		this.fieldChar = fieldChar;
	}

	public Integer getFieldInt() {
		return fieldInt;
	}

	public void setFieldInt(Integer fieldInt) {
		this.fieldInt = fieldInt;
	}

	public Float getFieldFloat() {
		return fieldFloat;
	}

	public void setFieldFloat(Float fieldFloat) {
		this.fieldFloat = fieldFloat;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((mnemonic == null) ? 0 : mnemonic.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
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
		GeneralParameter other = (GeneralParameter) obj;
		if (mnemonic == null) {
			if (other.mnemonic != null)
				return false;
		} else if (!mnemonic.equals(other.mnemonic))
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "GeneralParameter [product=" + product + ", mnemonic=" + mnemonic
				+ ", fieldMoney=" + fieldMoney + ", fieldTinyint="
				+ fieldTinyint + ", fieldChar=" + fieldChar + ", fieldInt="
				+ fieldInt + ", fieldFloat=" + fieldFloat + "]";
	}	
	
}
