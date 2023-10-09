package com.cobiscorp.ecobis.customer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQuery(name = "EconomicActivity.getEconomicActivity", query = "select new com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse(ea.code, ea.description, ea.sense, ea.industry, ct.value, ea.status) FROM EconomicActivity ea, "
		+ " TableCL tb, Catalog ct " 
		+ " WHERE ea.industry = ct.code "
		+ " AND tb.table = \"cl_sectoreco\" "
		+ " AND tb.code = ct.table"
		+ " AND ea.industry = :idIndustry"
		+ " AND ea.status = \"V\" "
		+ " ORDER BY ea.code ASC ")

@Entity
@Table(name = "cl_actividad_ec", schema = "cobis")
public class EconomicActivity {
	@Id
	@Column(name = "ac_codigo")
	private String code;
	
	@Column(name = "ac_descripcion")
	private String description;
	
	@Column(name = "ac_sensitiva")
	private String sense;
	
	@Column(name = "ac_industria")
	private String industry;
	
	@Column(name = "ac_estado")
	private String status;
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSense() {
		return sense;
	}

	public void setSense(String sense) {
		this.sense = sense;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
