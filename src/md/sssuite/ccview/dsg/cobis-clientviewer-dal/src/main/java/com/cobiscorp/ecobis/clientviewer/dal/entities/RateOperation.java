package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "ca_calif_operacion", schema = "cob_cartera")
@NamedQuery(name = "RateOperation.getRateByClientId", query = " "
		+ " SELECT new com.cobiscorp.ecobis.clientviewer.dto.RateDTO(ro.operation, ro.quota, di.tDescription, ro.expirationDate, ro.cancelationDate, ro.lateDays, ro.rate) "
		+ " FROM  Operation o, RateOperation ro, TDividend di " + " WHERE ro.operation = o.operation " + " and ro.clientId=:clientId "
				+ " and ro.tQuota = di.tdividend ")
public class RateOperation implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "ca_operacion")
	private int operation;

	@Column(name = "ca_calificacion")
	private double rate;

	@Column(name = "ca_cliente")
	private int clientId;

	@Column(name = "ca_dias")
	private int lateDays;

	@Column(name = "ca_dividendo")
	private int quota;

	@Column(name = "ca_estado")
	private int status;

	@Column(name = "ca_fecha_can")
	private Date cancelationDate;

	@Column(name = "ca_fecha_proceso")
	private Date processDate;

	@Column(name = "ca_fecha_ven")
	private Date expirationDate;

	@Column(name = "ca_tdividendo")
	private String tQuota;

	public RateOperation() {
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getLateDays() {
		return lateDays;
	}

	public void setLateDays(int lateDays) {
		this.lateDays = lateDays;
	}

	public int getQuota() {
		return quota;
	}

	public void setQuota(int quota) {
		this.quota = quota;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCancelationDate() {
		return cancelationDate;
	}

	public void setCancelationDate(Date cancelationDate) {
		this.cancelationDate = cancelationDate;
	}

	public Date getProcessDate() {
		return processDate;
	}

	public void setProcessDate(Date processDate) {
		this.processDate = processDate;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String gettQuota() {
		return tQuota;
	}

	public void settQuota(String tQuota) {
		this.tQuota = tQuota;
	}

}