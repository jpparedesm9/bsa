package com.cobiscorp.ecobis.customer.services.dtos;

import java.util.Date;
/**
 * DTO used to represent a cl_client table. 
 *
 */
public class ClientDTO {
	private Integer client;
	private ProductDetailDTO productDetail;
	private String role;
	private String identification;
	private Date date;
	
	public Integer getClient() {
		return client;
	}
	public void setClient(Integer client) {
		this.client = client;
	}
	public ProductDetailDTO getProductDetail() {
		return productDetail;
	}
	public void setProductDetail(ProductDetailDTO productDetail) {
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
	public ClientDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ClientDTO(Integer client, ProductDetailDTO productDetail,
			String role, String identification, Date date) {
		super();
		this.client = client;
		this.productDetail = productDetail;
		this.role = role;
		this.identification = identification;
		this.date = date;
	}
}
