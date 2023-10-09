package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.io.Serializable;

public class ValueDetailPortfolioId implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String type;
	private String sector;

	public ValueDetailPortfolioId() {
	}

	public ValueDetailPortfolioId(String type, String sector) {
		this.type = type;
		this.sector = sector;
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
		ValueDetailPortfolioId other = (ValueDetailPortfolioId) obj;
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
		return "ValueDetailPortfolioId [type=" + type + ", sector=" + sector
				+ "]";
	}
}
