package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(name = "cr_his_calif", schema = "cob_credito")
@NamedNativeQuery(name = "CustomerScore.getCustomerScore", query = "select new com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO(hc_calificacion , hc_fecha_cambio)"
		+ " from cob_credito..cr_his_calif"
		+ " where hc_ente = ?1"
		+ " and hc_fecha_cambio = (select max(hc_fecha_cambio) from cob_credito..cr_his_calif where hc_ente = ?1)" )

/**
 * Class used to access the database using JPA
 * related table: cr_his_calif, bdd: cob_credito
 * @author bbuendia
 *
 */
public class CustomerScore {
	@Id
	@Column(name = "hc_ente")
	private Integer codeScoreHis;
	
	@Column(name = "hc_calificacion")
	private String customerScoreHis;

	@Column(name = "hc_fecha_cambio")
	private Date changeDateHis;

	public CustomerScore() {
	}

	public CustomerScore(Integer codeScoreHis, String customerScoreHis,
			Date changeDateHis) {
		this.codeScoreHis = codeScoreHis;
		this.customerScoreHis = customerScoreHis;
		this.changeDateHis = changeDateHis;
	}
	
	public CustomerScore(String internalScore, String customerScoreHis,
			Date changeDateHis) {
		internalScore = "CALIFICACION INTERNA";
		this.customerScoreHis = customerScoreHis;
		this.changeDateHis = changeDateHis;
	}

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
		CustomerScore other = (CustomerScore) obj;
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
		return "CustomerScore [codeScoreHis=" + codeScoreHis
				+ ", customerScoreHis=" + customerScoreHis + ", changeDateHis="
				+ changeDateHis + "]";
	}
	
	

}
