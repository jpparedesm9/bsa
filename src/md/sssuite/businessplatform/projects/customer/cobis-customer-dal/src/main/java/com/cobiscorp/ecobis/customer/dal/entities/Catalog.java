package com.cobiscorp.ecobis.customer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQuery(name = "Catalog.getCode", query = "select ct.value FROM Catalog ct, TableCL tb "
		+ " where ct.code = :id "
		+ " and tb.table = \"cl_sectoreco\" "
		+ " AND tb.code = ct.table ")
@Entity
@Table(name = "cl_catalogo", schema = "cobis")
@IdClass(value =CatalogPK.class )
public class Catalog {
	
	@Id
	@Column(name = "tabla")
	private Integer table;
	
	@Id
	@Column(name = "codigo")
	private String code;
	
	@Column(name = "valor")
	private String value;
	
	public String getCode() {
		return code;
	}

	public Integer getTable() {
		return table;
	}

	public void setTable(Integer table) {
		this.table = table;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	
	
}
