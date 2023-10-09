package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.io.Serializable;

import javax.persistence.*;

import java.sql.Date;
import java.util.List;
import java.math.BigDecimal;

/**
 * The persistent class for the cl_infocred_central database table.
 * 
 */
@Entity
@Table(name = "cl_infocred_central", schema = "cobis")
@NamedQuery(name = "ClInfocredCentral.findAll", query = "SELECT c FROM ClInfocredCentral c")
public class InfoCred implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "ic_entidad")
	private String entity;

	@Column(name = "ic_estado_act")
	private String currentStatus;

	@Column(name = "ic_fecha_act_deuda")
	private Date dateActDebt;

	@Column(name = "ic_fecha_crea_deuda")
	private Date dateCreaDebt;

	@Column(name = "ic_fecha_nac")
	private Date birthday;

	@Column(name = "ic_id")
	private String cId;

	@ManyToOne
	@JoinColumn(name = "ic_id", referencedColumnName = "en_ced_ruc")
	private Ente enteAsfi;

	@Column(name = "ic_monto_act")
	private BigDecimal currentAmount;

	@Column(name = "ic_nomlar")
	private String largeName;

	@Column(name = "ic_tipo_credito")
	private String loanType;

	@Column(name = "ic_tipo_id")
	private String idType;

	@Column(name = "ic_tipo_obligacion")
	private String obligationType;

	public InfoCred() {
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getCurrentStatus() {
		return currentStatus;
	}

	public void setCurrentStatus(String currentStatus) {
		this.currentStatus = currentStatus;
	}

	public Date getDateActDebt() {
		return dateActDebt;
	}

	public void setDateActDebt(Date dateActDebt) {
		this.dateActDebt = dateActDebt;
	}

	public Date getDateCreaDebt() {
		return dateCreaDebt;
	}

	public void setDateCreaDebt(Date dateCreaDebt) {
		this.dateCreaDebt = dateCreaDebt;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getcId() {
		return cId;
	}

	public void setcId(String cId) {
		this.cId = cId;
	}

	public Ente getEnteAsfi() {
		return enteAsfi;
	}

	public void setEnteAsfi(Ente enteAsfi) {
		this.enteAsfi = enteAsfi;
	}

	public BigDecimal getCurrentAmount() {
		return currentAmount;
	}

	public void setCurrentAmount(BigDecimal currentAmount) {
		this.currentAmount = currentAmount;
	}

	public String getLargeName() {
		return largeName;
	}

	public void setLargeName(String largeName) {
		this.largeName = largeName;
	}

	public String getLoanType() {
		return loanType;
	}

	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}

	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}

	public String getObligationType() {
		return obligationType;
	}

	public void setObligationType(String obligationType) {
		this.obligationType = obligationType;
	}

}