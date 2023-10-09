package com.cobiscorp.ecobis.commons.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "pa_producto" and "pa_nemonico"
 * from the table: cl_parametro
 * @author bbuendia
 *
 */
@Embeddable
public class GeneralParameterId {
	
	private String product;
	
	private String mnemonic;	
	
	/** Default constructor */
	public GeneralParameterId() {
		
	}
	
	/** Constructor */
	public GeneralParameterId (String product, String mnemonic){
		this.product = product;
		this.mnemonic = mnemonic;
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
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((mnemonic == null) ? 0 : mnemonic.hashCode());
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
		GeneralParameterId other = (GeneralParameterId) obj;
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
		return "GeneralParameterId [product=" + product + ", mnemonic="
				+ mnemonic + "]";
	}
}
