package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@IdClass(RatesId.class)
@Table(name = "cb_cotizaciones", schema = "cob_credito")
@NamedQueries({
	@NamedQuery(name = "Rates.countRates", query = "SELECT count(r) from Rates r ") })
/**
 * Class used to access the database using JPA
 * related table: cb_cotizaciones bdd: cob_credito
 * @author bbuendia
 *
 */
public class Rates {
	
	@Id
	@Column(name = "ct_fecha")
	private Date date;	
	
	@Id
	@Column(name = "ct_moneda")
	private Integer currency;
	
	@Column(name = "ct_valor")
	private Double value;
	
	/** Default constructor */
	public Rates(){
		
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((currency == null) ? 0 : currency.hashCode());
		result = prime * result + ((date == null) ? 0 : date.hashCode());
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
		Rates other = (Rates) obj;
		if (currency == null) {
			if (other.currency != null)
				return false;
		} else if (!currency.equals(other.currency))
			return false;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Quotes [date=" + date + ", currency=" + currency + ", value="
				+ value + "]";
	}	

}
