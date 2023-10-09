package com.cobiscorp.ecobis.customer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQuery(name = "Contact.getContactsbyCustomer", query = "SELECT new com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse(c.entity, c.contact, c.name, c.address, c.phone, c.email) FROM Contact c WHERE c.entity =:Idcustomer")
@Entity
@Table(name = "cl_contacto", schema = "cobis")
@IdClass(value = ContactPK.class)
public class Contact {
	public Contact() {

	}

	@Id
	@Column(name = "co_ente")
	private Integer entity;

	@Id
	@Column(name = "co_contacto")
	private Integer contact;

	@Column(name = "co_nombre")
	private String name;

	@Column(name = "co_cargo")
	private String office;

	@Column(name = "co_telefono")
	private String phone;

	@Column(name = "co_direccioi")
	private String addressI;

	@Column(name = "co_verificado")
	private String checked;

	@Column(name = "co_fecha_ver")
	private Date dateChecked;

	@Column(name = "co_funcionario")
	private String official;

	@Column(name = "co_direccion")
	private String address;

	@Column(name = "co_email")
	private String email;

	@Column(name = "co_fecha_reg")
	private Date dateRegister;

	@Column(name = "co_fecha_mod")
	private Date dateUpdate;

	@Column(name = "co_area")
	private String area;

	@Column(name = "co_fuente_verif")
	private String sourceChecked;

	@Column(name = "co_telefono2")
	private String phone2;

	public Integer getEntity() {
		return entity;
	}

	public void setEntity(Integer entity) {
		this.entity = entity;
	}

	public Integer getContact() {
		return contact;
	}

	public void setContact(Integer contact) {
		this.contact = contact;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddressI() {
		return addressI;
	}

	public void setAddressI(String addressI) {
		this.addressI = addressI;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public Date getDateChecked() {
		return dateChecked;
	}

	public void setDateChecked(Date dateChecked) {
		this.dateChecked = dateChecked;
	}

	public String getOfficial() {
		return official;
	}

	public void setOfficial(String official) {
		this.official = official;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDateRegister() {
		return dateRegister;
	}

	public void setDateRegister(Date dateRegister) {
		this.dateRegister = dateRegister;
	}

	public Date getDateUpdate() {
		return dateUpdate;
	}

	public void setDateUpdate(Date dateUpdate) {
		this.dateUpdate = dateUpdate;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getSourceChecked() {
		return sourceChecked;
	}

	public void setSourceChecked(String sourceChecked) {
		this.sourceChecked = sourceChecked;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

}
