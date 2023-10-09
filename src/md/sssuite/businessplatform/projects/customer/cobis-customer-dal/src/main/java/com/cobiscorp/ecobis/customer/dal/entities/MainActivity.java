package com.cobiscorp.ecobis.customer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQuery(name="MainActivity.getMainActivity",query="SELECT new com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse(ma.code,ma.description,ma.business,ma.status) FROM MainActivity ma WHERE ma.business = :Idbusiness")

@Entity
@Table(name="cl_actividad_principal", schema="cobis")


public class MainActivity {
	public MainActivity(){
		
	}
	@Id
	@Column(name = "ap_codigo")
	private String code;
	
	@Column(name = "ap_descripcion")
	private String description;
	
	@Column(name = "ap_activ_comer")
	private String business;
	
	@Column(name = "ap_estado")
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

	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}

