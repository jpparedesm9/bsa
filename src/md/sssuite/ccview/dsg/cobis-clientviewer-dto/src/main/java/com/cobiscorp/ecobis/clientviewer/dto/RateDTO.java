package com.cobiscorp.ecobis.clientviewer.dto;

import java.sql.Date;

public class RateDTO {

	private int operation;
	private int quota;
	private String tQuota;
	private Date expirationDate;
	private Date cancelationDate;
	private int lateDays;
	private double rate;

	public RateDTO(int operation, int quota, String tQuota, Date expirationDate, Date cancelationDate, int lateDays, double rate) {
		super();
		this.operation = operation;
		this.quota = quota;
		this.tQuota = tQuota;
		this.expirationDate = expirationDate;
		this.cancelationDate = cancelationDate;
		this.lateDays = lateDays;
		this.rate = rate;
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public int getQuota() {
		return quota;
	}

	public void setQuota(int quota) {
		this.quota = quota;
	}

	public String gettQuota() {
		return tQuota;
	}

	public void settQuota(String tQuota) {
		this.tQuota = tQuota;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Date getCancelationDate() {
		return cancelationDate;
	}

	public void setCancelationDate(Date cancelationDate) {
		this.cancelationDate = cancelationDate;
	}

	public int getLateDays() {
		return lateDays;
	}

	public void setLateDays(int lateDays) {
		this.lateDays = lateDays;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

}
