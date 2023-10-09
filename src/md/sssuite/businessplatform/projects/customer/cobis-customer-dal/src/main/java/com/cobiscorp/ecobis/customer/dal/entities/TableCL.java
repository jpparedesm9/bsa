package com.cobiscorp.ecobis.customer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "cl_tabla", schema = "cobis")

public class TableCL {
	@Id
	@Column(name = "codigo")
	private Integer code;
	
	@Column(name = "tabla")
	private String table;
	
	@Column(name = "descripcion")
	private String description;

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
