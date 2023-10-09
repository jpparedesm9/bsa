package com.cobiscorp.ecobis.clientviewer.dto;

import java.math.BigDecimal;
import java.sql.Date;

public class AsfiDTO {

	private String rate;
	private String branchDepartCod;
	private String entityCod;
	private String obligatedPersonCod;
	private Integer code;
	private Date dateReport;
	private String name;
	private String correlativeNumber;
	private BigDecimal debtBalance30;
	private BigDecimal debtBalanceCastIns;
	private BigDecimal debtBalanceCastPre;
	private BigDecimal debtBalanceCont;
	private BigDecimal debtBalanceExec;
	private BigDecimal debtBalanceDebtWar30;
	private BigDecimal debtBalanceWarCastIns;
	private BigDecimal debtBalanceWarCastPre;
	private BigDecimal debtBalanceWarCont;
	private BigDecimal debtBalanceWarEjec;
	private BigDecimal debtBalanceWarExp;
	private BigDecimal debtBalanceWarCurr;
	private BigDecimal debtBalanceExp;
	private BigDecimal debtBalanceCurr;
	private Integer ente;

	public AsfiDTO(String rate, String branchDepartCod, String entityCod, String obligatedPersonCod, Integer code, Date dateReport, String name,
			String correlativeNumber, BigDecimal debtBalance30, BigDecimal debtBalanceCastIns, BigDecimal debtBalanceCastPre,
			BigDecimal debtBalanceCont, BigDecimal debtBalanceExec, BigDecimal debtBalanceDebtWar30, BigDecimal debtBalanceWarCastIns,
			BigDecimal debtBalanceWarCastPre, BigDecimal debtBalanceWarCont, BigDecimal debtBalanceWarEjec, BigDecimal debtBalanceWarExp,
			BigDecimal debtBalanceWarCurr, BigDecimal debtBalanceExp, BigDecimal debtBalanceCurr, Integer ente) {
		super();
		this.rate = rate;
		this.branchDepartCod = branchDepartCod;
		this.entityCod = entityCod;
		this.obligatedPersonCod = obligatedPersonCod;
		this.code = code;
		this.dateReport = dateReport;
		this.name = name;
		this.correlativeNumber = correlativeNumber;
		this.debtBalance30 = debtBalance30;
		this.debtBalanceCastIns = debtBalanceCastIns;
		this.debtBalanceCastPre = debtBalanceCastPre;
		this.debtBalanceCont = debtBalanceCont;
		this.debtBalanceExec = debtBalanceExec;
		this.debtBalanceDebtWar30 = debtBalanceDebtWar30;
		this.debtBalanceWarCastIns = debtBalanceWarCastIns;
		this.debtBalanceWarCastPre = debtBalanceWarCastPre;
		this.debtBalanceWarCont = debtBalanceWarCont;
		this.debtBalanceWarEjec = debtBalanceWarEjec;
		this.debtBalanceWarExp = debtBalanceWarExp;
		this.debtBalanceWarCurr = debtBalanceWarCurr;
		this.debtBalanceExp = debtBalanceExp;
		this.debtBalanceCurr = debtBalanceCurr;
		this.ente = ente;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getBranchDepartCod() {
		return branchDepartCod;
	}

	public void setBranchDepartCod(String branchDepartCod) {
		this.branchDepartCod = branchDepartCod;
	}

	public String getEntityCod() {
		return entityCod;
	}

	public void setEntityCod(String entityCod) {
		this.entityCod = entityCod;
	}

	public String getObligatedPersonCod() {
		return obligatedPersonCod;
	}

	public void setObligatedPersonCod(String obligatedPersonCod) {
		this.obligatedPersonCod = obligatedPersonCod;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public Date getDateReport() {
		return dateReport;
	}

	public void setDateReport(Date dateReport) {
		this.dateReport = dateReport;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCorrelativeNumber() {
		return correlativeNumber;
	}

	public void setCorrelativeNumber(String correlativeNumber) {
		this.correlativeNumber = correlativeNumber;
	}

	public BigDecimal getDebtBalance30() {
		return debtBalance30;
	}

	public void setDebtBalance30(BigDecimal debtBalance30) {
		this.debtBalance30 = debtBalance30;
	}

	public BigDecimal getDebtBalanceCastIns() {
		return debtBalanceCastIns;
	}

	public void setDebtBalanceCastIns(BigDecimal debtBalanceCastIns) {
		this.debtBalanceCastIns = debtBalanceCastIns;
	}

	public BigDecimal getDebtBalanceCastPre() {
		return debtBalanceCastPre;
	}

	public void setDebtBalanceCastPre(BigDecimal debtBalanceCastPre) {
		this.debtBalanceCastPre = debtBalanceCastPre;
	}

	public BigDecimal getDebtBalanceCont() {
		return debtBalanceCont;
	}

	public void setDebtBalanceCont(BigDecimal debtBalanceCont) {
		this.debtBalanceCont = debtBalanceCont;
	}

	public BigDecimal getDebtBalanceExec() {
		return debtBalanceExec;
	}

	public void setDebtBalanceExec(BigDecimal debtBalanceExec) {
		this.debtBalanceExec = debtBalanceExec;
	}

	public BigDecimal getDebtBalanceDebtWar30() {
		return debtBalanceDebtWar30;
	}

	public void setDebtBalanceDebtWar30(BigDecimal debtBalanceDebtWar30) {
		this.debtBalanceDebtWar30 = debtBalanceDebtWar30;
	}

	public BigDecimal getDebtBalanceWarCastIns() {
		return debtBalanceWarCastIns;
	}

	public void setDebtBalanceWarCastIns(BigDecimal debtBalanceWarCastIns) {
		this.debtBalanceWarCastIns = debtBalanceWarCastIns;
	}

	public BigDecimal getDebtBalanceWarCastPre() {
		return debtBalanceWarCastPre;
	}

	public void setDebtBalanceWarCastPre(BigDecimal debtBalanceWarCastPre) {
		this.debtBalanceWarCastPre = debtBalanceWarCastPre;
	}

	public BigDecimal getDebtBalanceWarCont() {
		return debtBalanceWarCont;
	}

	public void setDebtBalanceWarCont(BigDecimal debtBalanceWarCont) {
		this.debtBalanceWarCont = debtBalanceWarCont;
	}

	public BigDecimal getDebtBalanceWarEjec() {
		return debtBalanceWarEjec;
	}

	public void setDebtBalanceWarEjec(BigDecimal debtBalanceWarEjec) {
		this.debtBalanceWarEjec = debtBalanceWarEjec;
	}

	public BigDecimal getDebtBalanceWarExp() {
		return debtBalanceWarExp;
	}

	public void setDebtBalanceWarExp(BigDecimal debtBalanceWarExp) {
		this.debtBalanceWarExp = debtBalanceWarExp;
	}

	public BigDecimal getDebtBalanceWarCurr() {
		return debtBalanceWarCurr;
	}

	public void setDebtBalanceWarCurr(BigDecimal debtBalanceWarCurr) {
		this.debtBalanceWarCurr = debtBalanceWarCurr;
	}

	public BigDecimal getDebtBalanceExp() {
		return debtBalanceExp;
	}

	public void setDebtBalanceExp(BigDecimal debtBalanceExp) {
		this.debtBalanceExp = debtBalanceExp;
	}

	public BigDecimal getDebtBalanceCurr() {
		return debtBalanceCurr;
	}

	public void setDebtBalanceCurr(BigDecimal debtBalanceCurr) {
		this.debtBalanceCurr = debtBalanceCurr;
	}

	public Integer getEnte() {
		return ente;
	}

	public void setEnte(Integer ente) {
		this.ente = ente;
	}

}
