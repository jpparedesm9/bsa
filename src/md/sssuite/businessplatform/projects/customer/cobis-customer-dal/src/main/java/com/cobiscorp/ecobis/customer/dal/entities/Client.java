package com.cobiscorp.ecobis.customer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

/**
 * Class to represent the table cl_cliente, this have a data from clients and operations
 *
 */
@Entity
@Table(name = "cl_cliente", schema = "cobis")
@IdClass(value =ClientPK.class )
public class Client {
	@Id
	@Column(name = "cl_cliente")
	private Integer client;
	@Id
	@Column(name = "cl_det_producto")
	private Integer productDetail;
	@Column(name = "cl_rol")
	private String role;
	@Column(name = "cl_ced_ruc")
	private String identification;
	@Column(name = "cl_fecha")
	private Date date;
	public Integer getClient() {
		return client;
	}
	public void setClient(Integer client) {
		this.client = client;
	}
	public Integer getProductDetail() {
		return productDetail;
	}
	public void setProductDetail(Integer productDetail) {
		this.productDetail = productDetail;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getIdentification() {
		return identification;
	}
	public void setIdentification(String identification) {
		this.identification = identification;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	public Client() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Client(Integer client, Integer productDetail, String role,
			String identification, Date date) {
		super();
		this.client = client;
		this.productDetail = productDetail;
		this.role = role;
		this.identification = identification;
		this.date = date;
	}
}
