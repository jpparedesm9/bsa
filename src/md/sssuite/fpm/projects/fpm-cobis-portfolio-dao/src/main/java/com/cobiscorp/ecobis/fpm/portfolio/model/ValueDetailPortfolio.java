package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="ca_valor_det", schema="cob_cartera")
@IdClass(ValueDetailPortfolioId.class)
@NamedQueries({
	@NamedQuery(name="ValueDetailPortfolio.FindAll", query="Select vdp from ValueDetailPortfolio vdp")
})
public class ValueDetailPortfolio {

	@Id
	@Column(name="vd_tipo")
	private String type;
	@Id
	@Column(name="vd_sector")
	private String sector;
	@Column(name="vd_signo_default")
	private String defaultSign;
	@Column(name="vd_valor_default")
	private long defaultValue;
	@Column(name="vd_signo_maximo")
	private String maxSign;
	@Column(name="vd_valor_maximo")
	private long maxValue;
	@Column(name="vd_signo_minimo")
	private String minSign;
	@Column(name="vd_valor_minimo")
	private long minValue;
	@Column(name="vd_referencia")
	private String reference;
	@Column(name="vd_aplica_ajuste")
	private String appliesAdjustment;
	@Column(name="vd_periodo_ajuste")
	private long periodAdjustment;

	public ValueDetailPortfolio() {
	}

	public ValueDetailPortfolio(String type, String sector, String defaultSign,
			long defaultValue, String maxSign, long maxValue, String minSign,
			long minValue, String reference, String appliesAdjustment,
			long periodAdjustment) {
		this.type = type;
		this.sector = sector;
		this.defaultSign = defaultSign;
		this.defaultValue = defaultValue;
		this.maxSign = maxSign;
		this.maxValue = maxValue;
		this.minSign = minSign;
		this.minValue = minValue;
		this.reference = reference;
		this.appliesAdjustment = appliesAdjustment;
		this.periodAdjustment = periodAdjustment;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public String getDefaultSign() {
		return defaultSign;
	}

	public void setDefaultSign(String defaultSign) {
		this.defaultSign = defaultSign;
	}

	public long getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(long defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getMaxSign() {
		return maxSign;
	}

	public void setMaxSign(String maxSign) {
		this.maxSign = maxSign;
	}

	public long getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(long maxValue) {
		this.maxValue = maxValue;
	}

	public String getMinSign() {
		return minSign;
	}

	public void setMinSign(String minSign) {
		this.minSign = minSign;
	}

	public long getMinValue() {
		return minValue;
	}

	public void setMinValue(long minValue) {
		this.minValue = minValue;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getAppliesAdjustment() {
		return appliesAdjustment;
	}

	public void setAppliesAdjustment(String appliesAdjustment) {
		this.appliesAdjustment = appliesAdjustment;
	}

	public long getPeriodAdjustment() {
		return periodAdjustment;
	}

	public void setPeriodAdjustment(short periodAdjustment) {
		this.periodAdjustment = periodAdjustment;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((sector == null) ? 0 : sector.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ValueDetailPortfolio other = (ValueDetailPortfolio) obj;
		if (sector == null) {
			if (other.sector != null)
				return false;
		} else if (!sector.equals(other.sector))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	public String toString() {
		return "ValueDetailPortfolio [type=" + type + ", sector=" + sector
				+ ", defaultSign=" + defaultSign + ", defaultValue="
				+ defaultValue + ", maxSign=" + maxSign + ", maxValue="
				+ maxValue + ", minSign=" + minSign + ", minValue=" + minValue
				+ ", reference=" + reference + ", appliesAdjustment="
				+ appliesAdjustment + ", periodAdjustment=" + periodAdjustment
				+ "]";
	}
}

