package com.cobiscorp.ecobis.customer.dal.entities;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQueries({

@NamedQuery(name = "CustomerAux.getAllData", 
	query = "select ca"
		+ " from CustomerAux ca where ca.id = :id")
})
@Entity
@Table(name = "cl_ente_aux", schema = "cobis")
public class CustomerAux {
	@Id
	@Column(name = "ea_ente")
	Integer id;
	
	@Column(name = "ea_estado")
	String status;
	
	@Column(name = "ea_contrato_firmado")
	String agreementSigned;
	
	@Column(name = "ea_menor_edad")
	String isMinor;
	
	@Column(name = "ea_cliente_planilla")
	String customerReturn;
	
	@Column(name = "ea_cod_risk")
	String codeRisk;
	
	@Column(name = "ea_sector_eco")
	String economicSector;
	
	@Column(name = "ea_actividad")
	String activity;
	
	@Column(name = "ea_empadronado")
	String registrant;
	
	@Column(name = "ea_excepcion_pad")
	String exceptionRegistrant;
	
	@Column(name = "ea_excepcion_pad")
	String exceptionCensus;
	
	@Column(name = "ea_lin_neg")
	String businessline;
	
	@Column(name = "ea_seg_neg")
	String businessSegment;
	
	@Column(name = "ea_val_id_check")
	String validateIdCheck;
	
	@Column(name = "ea_suc_gestion")
	Integer branchMangement;
	
	@Column(name = "ea_constitucion")
	Integer constitution;
	
	@Column(name = "ea_remp_legal")
	Integer legalRepresentant;
	
	@Column(name = "ea_apoderado_legal")
	Integer legalGuardian;
	
	@Column(name = "ea_act_comp_kyc")
	String updateKYC;
	
	@Column(name = "ea_fecha_act_kyc")
	Date updateDateKYC;
	
	@Column(name = "ea_no_req_kyc_comp")
	String isNotRequeridKYC;
	
	@Column(name = "ea_act_perfiltran")
	String updateTransProfile;
	
	@Column(name = "ea_fecha_act_perfiltran")
	Date updateDateTransProfile;
	
	@Column(name = "ea_con_salario")
	String withSalary;
	
	@Column(name = "ea_fecha_consal")
	Date withSalaryDate;
	
	@Column(name = "ea_sin_salario")
	String withoutSalary;
	
	@Column(name = "ea_fecha_sinsal")
	Date withoutSalaryDate;
	
	@Column(name = "ea_actualizacion_cic")
	String cicUpdate;
	
	@Column(name = "ea_fecha_act_cic")
	Date cicUpdateDate;
	
	@Column(name = "ea_excepcion_cic")
	String cicException;
	
	@Column(name = "ea_fuente_ing")
	String sourceIncome;
	
	@Column(name = "ea_fuente_ing")
	String principalActivity;
	
	@Column(name = "ea_act_dol")
	BigDecimal dolarizedActivity;
	
	@Column(name = "ea_cat_aml")
	String amlCategory;
	
	@Column(name = "ea_fecha_vincula")
	Date vinculationDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAgreementSigned() {
		return agreementSigned;
	}

	public void setAgreementSigned(String agreementSigned) {
		this.agreementSigned = agreementSigned;
	}

	public String getIsMinor() {
		return isMinor;
	}

	public void setIsMinor(String isMinor) {
		this.isMinor = isMinor;
	}

	public String getCustomerReturn() {
		return customerReturn;
	}

	public void setCustomerReturn(String customerReturn) {
		this.customerReturn = customerReturn;
	}

	public String getCodeRisk() {
		return codeRisk;
	}

	public void setCodeRisk(String codeRisk) {
		this.codeRisk = codeRisk;
	}

	public String getEconomicSector() {
		return economicSector;
	}

	public void setEconomicSector(String economicSector) {
		this.economicSector = economicSector;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getRegistrant() {
		return registrant;
	}

	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}

	public String getExceptionRegistrant() {
		return exceptionRegistrant;
	}

	public void setExceptionRegistrant(String exceptionRegistrant) {
		this.exceptionRegistrant = exceptionRegistrant;
	}

	public String getExceptionCensus() {
		return exceptionCensus;
	}

	public void setExceptionCensus(String exceptionCensus) {
		this.exceptionCensus = exceptionCensus;
	}

	public String getBusinessline() {
		return businessline;
	}

	public void setBusinessline(String businessline) {
		this.businessline = businessline;
	}

	public String getBusinessSegment() {
		return businessSegment;
	}

	public void setBusinessSegment(String businessSegment) {
		this.businessSegment = businessSegment;
	}

	public String getValidateIdCheck() {
		return validateIdCheck;
	}

	public void setValidateIdCheck(String validateIdCheck) {
		this.validateIdCheck = validateIdCheck;
	}

	public Integer getBranchMangement() {
		return branchMangement;
	}

	public void setBranchMangement(Integer branchMangement) {
		this.branchMangement = branchMangement;
	}

	public Integer getConstitution() {
		return constitution;
	}

	public void setConstitution(Integer constitution) {
		this.constitution = constitution;
	}

	public Integer getLegalRepresentant() {
		return legalRepresentant;
	}

	public void setLegalRepresentant(Integer legalRepresentant) {
		this.legalRepresentant = legalRepresentant;
	}

	public Integer getLegalGuardian() {
		return legalGuardian;
	}

	public void setLegalGuardian(Integer legalGuardian) {
		this.legalGuardian = legalGuardian;
	}

	public String getUpdateKYC() {
		return updateKYC;
	}

	public void setUpdateKYC(String updateKYC) {
		this.updateKYC = updateKYC;
	}

	public Date getUpdateDateKYC() {
		return updateDateKYC;
	}

	public void setUpdateDateKYC(Date updateDateKYC) {
		this.updateDateKYC = updateDateKYC;
	}

	public String getIsNotRequeridKYC() {
		return isNotRequeridKYC;
	}

	public void setIsNotRequeridKYC(String isNotRequeridKYC) {
		this.isNotRequeridKYC = isNotRequeridKYC;
	}

	public String getUpdateTransProfile() {
		return updateTransProfile;
	}

	public void setUpdateTransProfile(String updateTransProfile) {
		this.updateTransProfile = updateTransProfile;
	}

	public Date getUpdateDateTransProfile() {
		return updateDateTransProfile;
	}

	public void setUpdateDateTransProfile(Date updateDateTransProfile) {
		this.updateDateTransProfile = updateDateTransProfile;
	}

	public String getWithSalary() {
		return withSalary;
	}

	public void setWithSalary(String withSalary) {
		this.withSalary = withSalary;
	}

	public Date getWithSalaryDate() {
		return withSalaryDate;
	}

	public void setWithSalaryDate(Date withSalaryDate) {
		this.withSalaryDate = withSalaryDate;
	}

	public String getWithoutSalary() {
		return withoutSalary;
	}

	public void setWithoutSalary(String withoutSalary) {
		this.withoutSalary = withoutSalary;
	}

	public Date getWithoutSalaryDate() {
		return withoutSalaryDate;
	}

	public void setWithoutSalaryDate(Date withoutSalaryDate) {
		this.withoutSalaryDate = withoutSalaryDate;
	}

	public String getCicUpdate() {
		return cicUpdate;
	}

	public void setCicUpdate(String cicUpdate) {
		this.cicUpdate = cicUpdate;
	}

	public Date getCicUpdateDate() {
		return cicUpdateDate;
	}

	public void setCicUpdateDate(Date cicUpdateDate) {
		this.cicUpdateDate = cicUpdateDate;
	}

	public String getCicException() {
		return cicException;
	}

	public void setCicException(String cicException) {
		this.cicException = cicException;
	}

	public String getSourceIncome() {
		return sourceIncome;
	}

	public void setSourceIncome(String sourceIncome) {
		this.sourceIncome = sourceIncome;
	}

	public String getPrincipalActivity() {
		return principalActivity;
	}

	public void setPrincipalActivity(String principalActivity) {
		this.principalActivity = principalActivity;
	}

	public BigDecimal getDolarizedActivity() {
		return dolarizedActivity;
	}

	public void setDolarizedActivity(BigDecimal dolarizedActivity) {
		this.dolarizedActivity = dolarizedActivity;
	}

	public String getAmlCategory() {
		return amlCategory;
	}

	public void setAmlCategory(String amlCategory) {
		this.amlCategory = amlCategory;
	}

	public Date getVinculationDate() {
		return vinculationDate;
	}

	public void setVinculationDate(Date vinculationDate) {
		this.vinculationDate = vinculationDate;
	}
	
	
	
}
