package com.cobiscorp.ecobis.customer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQuery(name = "POBox.getAllData", query = "select new com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse("
		+ "po.entity, po.box, po.value, po.type, po.city, po.province, po.subsidiary, po.registrationDate, po.modifiedDate, po.validity,"
		+ "po.functionary, po.verified, po.verifiedDate, po.empPO, po.ownerBox, po.country, po.canton, po.correspondence"
		+ ") from POBox po where po.entity = :idCustomer")
@Entity
@Table(name = "cl_casilla", schema = "cobis")
@IdClass(value = POBoxPK.class)
public class POBox {
	@Id
	@Column(name = "cs_ente")
	Integer entity;
	
	@Id
	@Column(name = "cs_casilla")
	Integer box;
	
	@Column(name = "cs_valor")
	String value;
	
	@Column(name = "cs_tipo")
	String type;
	
	@Column(name = "cs_ciudad")
	Integer city;
	
	@Column(name = "cs_provincia")
	Integer province;
	
	@Column(name = "cs_sucursal")
	Integer subsidiary;
	
	@Column(name = "cs_fecha_registro")
	Date registrationDate;
	
	@Column(name = "cs_fecha_modificacion")
	Date modifiedDate;
	
	@Column(name = "cs_vigencia")
	String validity;
	
	@Column(name = "cs_funcionario")
	String functionary;
	
	@Column(name = "cs_verificado")
	String verified;
	
	@Column(name = "cs_fecha_ver")
	Date verifiedDate;
	
	@Column(name = "cs_emp_postal")
	String empPO;
	
	@Column(name = "cs_dueno_apdo")
	String ownerBox;
	
	@Column(name = "cs_pais")
	Integer country;
	
	@Column(name = "cs_canton")
	Integer canton;
	
	@Column(name = "cs_correspondencia")
	String correspondence;
	
}
