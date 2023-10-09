package com.cobiscorp.ecobis.customer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQueries({
		@NamedQuery(name = "Phone.getPhoneCustomer", query = "select new com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse(ph.entity,ph.address,ph.sequential,ph.value,ph.typePhone,ph.phoneCharge,ph.functionary,ph.verified,ph.dateSee,ph.dateRegistration,ph.dateModified,ph.area) FROM Phone ph WHERE ph.entity =:Idcustomer"),
		@NamedQuery(name = "Phone.getPhoneCustomerAddress", query = "select new com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse(ph.entity,ph.address,ph.sequential,ph.value,ct.value,ph.phoneCharge,ph.functionary,ph.verified,ph.dateSee,ph.dateRegistration,ph.dateModified,ph.area) FROM Phone ph,"
				+ " TableCL tb, Catalog ct "
				+ " WHERE ph.typePhone = ct.code "
				+ " AND tb.table = \"cl_ttelefono\" "
				+ " AND tb.code = ct.table"
				+ " AND ph.entity =:IdCustomer AND ph.address=:IdAddress") })
@Entity
@Table(name = "cl_telefono", schema = "cobis")
@IdClass(value = PhonePk.class)
public class Phone {
	public Phone() {

	}

	@Id
	@Column(name = "te_ente")
	private Integer entity;

	@Id
	@Column(name = "te_direccion")
	private Integer address;

	@Id
	@Column(name = "te_secuencial")
	private Integer sequential;

	@Column(name = "te_valor")
	private String value;

	@Column(name = "te_tipo_telefono")
	private String typePhone;

	@Column(name = "te_telf_cobro")
	private String phoneCharge;

	@Column(name = "te_funcionario")
	private String functionary;

	@Column(name = "te_verificado")
	private String verified;

	@Column(name = "te_fecha_ver")
	private Date dateSee;

	@Column(name = "te_fecha_registro")
	private Date dateRegistration;

	@Column(name = "te_fecha_modificacion")
	private Date dateModified;

	@Column(name = "te_area")
	private String area;

	public Integer getEntity() {
		return entity;
	}

	public void setEntity(Integer entity) {
		this.entity = entity;
	}

	public Integer getAddress() {
		return address;
	}

	public void setAddress(Integer address) {
		this.address = address;
	}

	public Integer getSequential() {
		return sequential;
	}

	public void setSequential(Integer sequential) {
		this.sequential = sequential;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getTypePhone() {
		return typePhone;
	}

	public void setTypePhone(String typePhone) {
		this.typePhone = typePhone;
	}

	public String getPhoneCharge() {
		return phoneCharge;
	}

	public void setPhoneCharge(String phoneCharge) {
		this.phoneCharge = phoneCharge;
	}

	public String getFunctionary() {
		return functionary;
	}

	public void setFunctionary(String functionary) {
		this.functionary = functionary;
	}

	public String getVerified() {
		return verified;
	}

	public void setVerified(String verified) {
		this.verified = verified;
	}

	public Date getDateSee() {
		return dateSee;
	}

	public void setDateSee(Date dateSee) {
		this.dateSee = dateSee;
	}

	public Date getDateRegistration() {
		return dateRegistration;
	}

	public void setDateRegistration(Date dateRegistration) {
		this.dateRegistration = dateRegistration;
	}

	public Date getDateModified() {
		return dateModified;
	}

	public void setDateModified(Date dateModified) {
		this.dateModified = dateModified;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

}