package com.cobiscorp.ecobis.customer.services.dtos;

import java.util.Date;

public class CustomerQuickCreateRequest {

	private String operation;
	private String firstName;
	private String lastName;
	private String additionalLastName;
	private int filialId;
	private int officeId;
	private Integer official;
	private String identificationTypeCode;
	private String id;
	private String marriedName;
	private String middleName;
	private String taxpayerIdentificationNumber;
	private Date idExpirationDate;
	private String passport;
	private String sexCode;
	private String idIssueCityCode;
	private Date birthDate;
	private String digitCheck;
	private String blocked;
	private String maritalStatusCode;
	private String incomingsLevelCode;
	private String industryCode;
	private String economicActivityCode;
	private String typeCode;
	private String statusCode;
	private String professionCode;
    private Integer nationalityCode;
    
    //service padron --ssa
    private Integer modeCode;
    private String type;
    private String padron;
    
    
    public Integer getOfficial() {
		return official;
	}

	public void setOfficial(Integer official) {
		this.official = official;
	}
	
	public Integer getModeCode() {
		return modeCode;
	}

	public void setModeCode(Integer modeCode) {
		this.modeCode = modeCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPadron() {
		return padron;
	}

	public void setPadron(String padron) {
		this.padron = padron;
	}

	public Integer getNationalityCode() {
		return nationalityCode;
	}

	public void setNationalityCode(Integer nationalityCode) {
		this.nationalityCode = nationalityCode;
	}

	public String getProfessionCode() {
		return professionCode;
	}

	public void setProfessionCode(String professionCode) {
		this.professionCode = professionCode;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	public String getAdditionalLastName() {
		return additionalLastName;
	}

	public void setAdditionalLastName(String additionalLastName) {
		this.additionalLastName = additionalLastName;
	}

	public int getFilialId() {
		return filialId;
	}

	public void setFilialId(int filialId) {
		this.filialId = filialId;
	}

	public int getOfficeId() {
		return officeId;
	}

	public void setOfficeId(int officeId) {
		this.officeId = officeId;
	}

	public String getIdentificationTypeCode() {
		return identificationTypeCode;
	}

	public void setIdentificationTypeCode(String identificationTypeCode) {
		this.identificationTypeCode = identificationTypeCode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMarriedName() {
		return marriedName;
	}

	public void setMarriedName(String marriedName) {
		this.marriedName = marriedName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getTaxpayerIdentificationNumber() {
		return taxpayerIdentificationNumber;
	}

	public void setTaxpayerIdentificationNumber(
			String taxpayerIdentificationNumber) {
		this.taxpayerIdentificationNumber = taxpayerIdentificationNumber;
	}

	public Date getIdExpirationDate() {
		return idExpirationDate;
	}

	public void setIdExpirationDate(Date idExpirationDate) {
		this.idExpirationDate = idExpirationDate;
	}

	public String getPassport() {
		return passport;
	}

	public void setPassport(String passport) {
		this.passport = passport;
	}

	public String getSexCode() {
		return sexCode;
	}

	public void setSexCode(String sexCode) {
		this.sexCode = sexCode;
	}

	public String getIdIssueCityCode() {
		return idIssueCityCode;
	}

	public void setIdIssueCityCode(String idIssueCityCode) {
		this.idIssueCityCode = idIssueCityCode;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public String getDigitCheck() {
		return digitCheck;
	}

	public void setDigitCheck(String digitCheck) {
		this.digitCheck = digitCheck;
	}

	public String getBlocked() {
		return blocked;
	}

	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}

	public String getMaritalStatusCode() {
		return maritalStatusCode;
	}

	public void setMaritalStatusCode(String maritalStatusCode) {
		this.maritalStatusCode = maritalStatusCode;
	}

	public String getIncomingsLevelCode() {
		return incomingsLevelCode;
	}

	public void setIncomingsLevelCode(String incomingsLevelCode) {
		this.incomingsLevelCode = incomingsLevelCode;
	}

	public String getIndustryCode() {
		return industryCode;
	}

	public void setIndustryCode(String industryCode) {
		this.industryCode = industryCode;
	}

	public String getEconomicActivityCode() {
		return economicActivityCode;
	}

	public void setEconomicActivityCode(String economicActivityCode) {
		this.economicActivityCode = economicActivityCode;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	

}
