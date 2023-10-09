package com.cobiscorp.ecobis.customer.dal.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

public class CatalogPK implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "tabla")
	private Integer table;
	
	@Id
	@Column(name = "codigo")
	private String code;

	public Integer getTable() {
		return table;
	}

	public void setTable(Integer table) {
		this.table = table;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((table == null) ? 0 : table.hashCode());
		result = prime * result
				+ ((code == null) ? 0 : code.hashCode());
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
		CatalogPK other = (CatalogPK) obj;
		if (table == null) {
			if (other.table != null)
				return false;
		} else if (!table.equals(other.table))
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}

	
    
}
