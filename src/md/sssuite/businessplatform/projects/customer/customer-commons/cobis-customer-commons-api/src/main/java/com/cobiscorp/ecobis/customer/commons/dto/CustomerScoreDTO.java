package com.cobiscorp.ecobis.customer.commons.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO used in the method getCustomerScoreHis
 * @author bbuendia
 *
 */
public class CustomerScoreDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer codeScoreHis;
	private String customerScoreHis;
	private Date changeDateHis;
	
	public Integer getCodeScoreHis() {
		return codeScoreHis;
	}

	public void setCodeScoreHis(Integer codeScoreHis) {
		this.codeScoreHis = codeScoreHis;
	}

	public String getCustomerScoreHis() {
		return customerScoreHis;
	}

	public void setCustomerScoreHis(String customerScoreHis) {
		this.customerScoreHis = customerScoreHis;
	}

	public Date getChangeDateHis() {
		return changeDateHis;
	}

	public void setChangeDateHis(Date changeDateHis) {
		this.changeDateHis = changeDateHis;
	}

	public CustomerScoreDTO() {
	}

	public CustomerScoreDTO(Integer codeScoreHis, String customerScoreHis,
			Date changeDateHis) {
		this.codeScoreHis = codeScoreHis;
		this.customerScoreHis = customerScoreHis;
		this.changeDateHis = changeDateHis;
	}
	
	public CustomerScoreDTO(String internalScore, String customerScoreHis,
			Date changeDateHis) {
		internalScore = "CALIFICACION INTERNA";
		this.customerScoreHis = customerScoreHis;
		this.changeDateHis = changeDateHis;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((changeDateHis == null) ? 0 : changeDateHis.hashCode());
		result = prime * result
				+ ((codeScoreHis == null) ? 0 : codeScoreHis.hashCode());
		result = prime
				* result
				+ ((customerScoreHis == null) ? 0 : customerScoreHis.hashCode());
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
		CustomerScoreDTO other = (CustomerScoreDTO) obj;
		if (changeDateHis == null) {
			if (other.changeDateHis != null)
				return false;
		} else if (!changeDateHis.equals(other.changeDateHis))
			return false;
		if (codeScoreHis == null) {
			if (other.codeScoreHis != null)
				return false;
		} else if (!codeScoreHis.equals(other.codeScoreHis))
			return false;
		if (customerScoreHis == null) {
			if (other.customerScoreHis != null)
				return false;
		} else if (!customerScoreHis.equals(other.customerScoreHis))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CustomerScoreDTO [codeScoreHis=" + codeScoreHis
				+ ", customerScoreHis=" + customerScoreHis + ", changeDateHis="
				+ changeDateHis + "]";
	}	
}
