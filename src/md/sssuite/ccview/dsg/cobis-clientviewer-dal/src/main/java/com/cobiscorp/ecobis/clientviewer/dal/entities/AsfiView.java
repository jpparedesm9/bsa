package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;

/**
 * The persistent class for the cl_asfi_vcc database table.
 * 
 */
@Entity
@Table(name = "cl_asfi_vcc", schema = "cobis")
@NamedQuery(name = "ClAsfiVcc.findAll", query = "SELECT c FROM ClAsfiVcc c")
public class AsfiView implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "af_cod_depart_sucur")
	private String branchDepartCod;

	@Column(name = "af_cod_entidad")
	private String entityCode;

	@Column(name = "af_cod_obligado")
	private String obligatedCode;

	@Column(name = "af_num_correlativo")
	private String correlativeNumber;

	@Column(name = "en_ente")
	private Integer ente;

	@Column(name = "saldo_deuda_castigada")
	private BigDecimal badDebtBalance;

	@Column(name = "saldo_deuda_contingente")
	private BigDecimal contingentDebtBalance;

	@Column(name = "saldo_deuda_ejecucion")
	private BigDecimal executionDebtBalance;

	@Column(name = "saldo_deuda_vencida")
	private BigDecimal expiredDebtBalance;

	@Column(name = "saldo_deuda_vigente")
	private BigDecimal currentDebtBalance;

	@Column(name = "saldo_total")
	private BigDecimal totalBalance;

	@Column(name = "tipo_deuda")
	private String debtType;

	@Column(name = "calificacion")
	private String calificacion;

	public AsfiView() {
	}

	public String getBranchDepartCod() {
		return branchDepartCod;
	}

	public void setBranchDepartCod(String branchDepartCod) {
		this.branchDepartCod = branchDepartCod;
	}

	public String getEntityCode() {
		return entityCode;
	}

	public void setEntityCode(String entityCode) {
		this.entityCode = entityCode;
	}

	public String getObligatedCode() {
		return obligatedCode;
	}

	public void setObligatedCode(String obligatedCode) {
		this.obligatedCode = obligatedCode;
	}

	public String getCorrelativeNumber() {
		return correlativeNumber;
	}

	public void setCorrelativeNumber(String correlativeNumber) {
		this.correlativeNumber = correlativeNumber;
	}

	public int getEnte() {
		return ente;
	}

	public void setEnte(int ente) {
		this.ente = ente;
	}

	public BigDecimal getBadDebtBalance() {
		return badDebtBalance;
	}

	public void setBadDebtBalance(BigDecimal badDebtBalance) {
		this.badDebtBalance = badDebtBalance;
	}

	public BigDecimal getContingentDebtBalance() {
		return contingentDebtBalance;
	}

	public void setContingentDebtBalance(BigDecimal contingentDebtBalance) {
		this.contingentDebtBalance = contingentDebtBalance;
	}

	public BigDecimal getExecutionDebtBalance() {
		return executionDebtBalance;
	}

	public void setExecutionDebtBalance(BigDecimal executionDebtBalance) {
		this.executionDebtBalance = executionDebtBalance;
	}

	public BigDecimal getExpiredDebtBalance() {
		return expiredDebtBalance;
	}

	public void setExpiredDebtBalance(BigDecimal expiredDebtBalance) {
		this.expiredDebtBalance = expiredDebtBalance;
	}

	public BigDecimal getCurrentDebtBalance() {
		return currentDebtBalance;
	}

	public void setCurrentDebtBalance(BigDecimal currentDebtBalance) {
		this.currentDebtBalance = currentDebtBalance;
	}

	public BigDecimal getTotalBalance() {
		return totalBalance;
	}

	public void setTotalBalance(BigDecimal totalBalance) {
		this.totalBalance = totalBalance;
	}

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public String getCalificacion() {
		return calificacion;
	}

	public void setCalificacion(String calificacion) {
		this.calificacion = calificacion;
	}

}