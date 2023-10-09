package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
// @IdClass(ScoreId.class)
@Table(name = "ca_cliente_calificacion", schema = "cob_cartera")
@NamedQueries({ @NamedQuery(name = "ClienteCalificacion.getPunctuationCustomer", query = " select  new com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO(s.score, s.customerType, s.idCustomer, s.date) from ClienteCalificacion s where s.idCustomer = :idCustomer and s.date = (select max(s1.date) from ClienteCalificacion s1 where s1.idCustomer = :idCustomer) ") })
/**
 * Class used to access the database using JPA
 * related table: cr_his_calif bdd: cob_credito
 * @author aandy
 *
 */
public class ClienteCalificacion {

	@Id
	@Column(name = "ca_ente")
	private Integer idCustomer;

	@Column(name = "ca_fecha_calif")
	private Date date;

	@Column(name = "ca_puntos_operacion")
	private Double score;

	@Column(name = "ca_tipo_cliente")
	private String customerType;

	public Integer getIdCustomer() {
		return idCustomer;
	}

	public void setIdCustomer(Integer idCustomer) {
		this.idCustomer = idCustomer;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

}
