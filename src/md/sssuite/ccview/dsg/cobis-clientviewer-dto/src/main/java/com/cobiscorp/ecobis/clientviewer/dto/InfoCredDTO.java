package com.cobiscorp.ecobis.clientviewer.dto;

import java.math.BigDecimal;
import java.sql.Date;

public class InfoCredDTO {

	private String entity;
	private String currentStatus;
	private Date dateActDebt;
	private Date dateCreaDebt;
	private Date birthday;
	private String cId;
	private BigDecimal currentAmount;
	private String largeName;
	private String loanType;
	private String idType;
	private String obligationType;
	private Integer ente;

	public InfoCredDTO(String entity, String currentStatus, Date dateActDebt, Date dateCreaDebt, Date birthday, String cId,
			BigDecimal currentAmount, String largeName, String loanType, String idType, String obligationType, Integer ente) {
		this.entity = entity;
		this.currentStatus = currentStatus;
		this.dateActDebt = dateActDebt;
		this.dateCreaDebt = dateCreaDebt;
		this.birthday = birthday;
		this.cId = cId;
		this.currentAmount = currentAmount;
		this.largeName = largeName;
		this.loanType = loanType;
		this.idType = idType;
		this.obligationType = obligationType;
		this.setEnte(ente);
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

	public Integer getEnte() {
		return ente;
	}

	public void setEnte(Integer ente) {
		this.ente = ente;
	}

}