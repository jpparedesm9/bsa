package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "ct_fecha" and "ct_moneda"
 * from the table: cb_cotizaciones
 * @author bbuendia
 *
 */
@Embeddable
public class RatesId {
	
	private Date date;
	
	private Integer currency;
	
	/** Default constructor */
	public RatesId(){
		
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
		RatesId other = (RatesId) obj;
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
		return "RatesId [date=" + date + ", currency=" + currency + "]";
	}

}
