package com.cobiscorp.ecobis.commons.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "codigo" and "tabla"
 * from the tables: cl_catalogo and cl_tabla
 * @author bbuendia
 *
 */
@Embeddable
public class CatalogId {

	private String code;
	private int catalogTable;

	public CatalogId() {}
	
	public CatalogId(String id, int catalogTable) {
		super();
		this.code = id;
		this.catalogTable = catalogTable;
	}

	public String getId() {
		return code;
	}

	public void setId(String id) {
		this.code = id;
	}

	public int getCatalogTable() {
		return catalogTable;
	}

	public void setCatalogTable(int catalogTable) {
		this.catalogTable = catalogTable;
	}
		
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + catalogTable;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
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
		CatalogId other = (CatalogId) obj;
		if (catalogTable != other.catalogTable)
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CatalogId [id=" + code + ", catalogTable=" + catalogTable + "]";
	}
}
