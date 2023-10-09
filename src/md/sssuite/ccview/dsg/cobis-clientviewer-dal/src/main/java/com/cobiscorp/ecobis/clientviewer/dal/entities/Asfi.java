package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the cl_asfi database table.
 * 
 */
@Entity
@Table(name = "cl_asfi_vcc", schema = "cobis")
@NamedQuery(name = "Asfi.findAll", query = "SELECT c FROM Asfi c")
public class Asfi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "af_calificacion")
	private String rate;

	@Column(name = "af_cod_depart_sucur")
	private String branchDepartCod;

	@Column(name = "af_cod_entidad")
	private String entityCod;

	@Column(name = "af_cod_obligado")
	private String obligatedPersonCod;

	@ManyToOne
	@JoinColumn(name = "af_cod_obligado", referencedColumnName = "en_ced_ruc")
	private Ente enteAsfi;

	@Column(name = "af_codigo")
	private Integer code;

	@Column(name = "af_fecha_reporte")
	private Date dateReport;

	@Column(name = "af_nombre")
	private String name;

	@Column(name = "af_num_correlativo")
	private String correlativeNumber;

	@Column(name = "af_saldo_deuda_30")
	private BigDecimal debtBalance30;

	@Column(name = "af_saldo_deuda_cast_ins")
	private BigDecimal debtBalanceCastIns;

	@Column(name = "af_saldo_deuda_cast_pre")
	private BigDecimal debtBalanceCastPre;

	@Column(name = "af_saldo_deuda_cont")
	private BigDecimal debtBalanceCont;

	@Column(name = "af_saldo_deuda_ejec")
	private BigDecimal debtBalanceExec;

	@Column(name = "af_saldo_deuda_gar_30")
	private BigDecimal debtBalanceDebtWar30;

	@Column(name = "af_saldo_deuda_gar_cast_ins")
	private BigDecimal debtBalanceWarCastIns;

	@Column(name = "af_saldo_deuda_gar_cast_pre")
	private BigDecimal debtBalanceWarCastPre;

	@Column(name = "af_saldo_deuda_gar_cont")
	private BigDecimal debtBalanceWarCont;

	@Column(name = "af_saldo_deuda_gar_ejec")
	private BigDecimal debtBalanceWarEjec;

	@Column(name = "af_saldo_deuda_gar_ven")
	private BigDecimal debtBalanceWarExp;

	@Column(name = "af_saldo_deuda_gar_vig")
	private BigDecimal debtBalanceWarCurr;

	@Column(name = "af_saldo_deuda_ven")
	private BigDecimal debtBalanceExp;

	@Column(name = "af_saldo_deuda_vig")
	private BigDecimal debtBalanceCurr;

	public Asfi() {
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

	public Ente getEnteAsfi() {
		return enteAsfi;
	}

	public void setEnteAsfi(Ente enteAsfi) {
		this.enteAsfi = enteAsfi;
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
	
	

}