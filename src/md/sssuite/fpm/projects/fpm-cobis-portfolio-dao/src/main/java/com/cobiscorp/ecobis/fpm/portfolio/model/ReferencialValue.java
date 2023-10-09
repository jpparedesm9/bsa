package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
//@Table(name="ca_valor_referencial", schema="cob_cartera")
@Table(name="ca_valor_referencial_view", schema="cob_cartera")
@NamedQueries({
	@NamedQuery(name="ReferencialValue.findAll", query="Select rv from ReferencialValue rv"),
	@NamedQuery(name="ReferencialValue.findByState", query="Select distinct rv from ReferencialValue rv where rv.state = 'V' ")
})
public class ReferencialValue {

	@Id
	@Column(name="vr_secuencial")
	private int sequencial;
	
	@Column(name="vr_tasa")
	private String rate;
	
	@Column(name="vr_descripcion")
	private String description;
	
	@Column(name="vr_modalidad")
	private String modality;
	
	@Column(name="vr_periodicidad")
	private int periodicity;
	
	@Column(name="vr_rango_unico")
	private String uniqueRange;
	
	@Column(name="vr_estado")
	private String state;

	public ReferencialValue() {
	}

	public ReferencialValue(int sequencial, String rate, String description,
			String modality, int periodicity, String uniqueRange, String state) {
		this.sequencial = sequencial;
		this.rate = rate;
		this.description = description;
		this.modality = modality;
		this.periodicity = periodicity;
		this.uniqueRange = uniqueRange;
		this.state = state;
	}

	public int getSequencial() {
		return sequencial;
	}

	public void setSequencial(int sequencial) {
		this.sequencial = sequencial;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getModality() {
		return modality;
	}

	public void setModality(String modality) {
		this.modality = modality;
	}

	public int getPeriodicity() {
		return periodicity;
	}

	public void setPeriodicity(int periodicity) {
		this.periodicity = periodicity;
	}

	public String getUniqueRange() {
		return uniqueRange;
	}

	public void setUniqueRange(String uniqueRange) {
		this.uniqueRange = uniqueRange;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rate == null) ? 0 : rate.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReferencialValue other = (ReferencialValue) obj;
		if (rate == null) {
			if (other.rate != null)
				return false;
		} else if (!rate.equals(other.rate))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		return true;
	}

	public String toString() {
		return "ReferencialValue [sequencial=" + sequencial + ", rate=" + rate
				+ ", description=" + description + ", modality=" + modality
				+ ", periodicity=" + periodicity + ", uniqueRange="
				+ uniqueRange + ", state=" + state + "]";
	}
}
