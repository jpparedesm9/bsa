package com.cobiscorp.ecobis.customer.services.dtos;

import java.math.BigDecimal;
import java.util.Date;


public class CustomerDataResponse {

	private Integer customerID;
	private String customerTypeDocumentId;
	private String customerIdentification;
	private String customerCompleteName;
	private String customerName;
	private String customerSubType;
	private String customerTypePersonId;
	private String customerSector;
	
	//Sprint 2
	private String customerAffiliate;
	private Integer customerOffice;
	private String customerCreatedDate;
	private String customerModifiedDate;
	private Integer customerAddress;
	private Integer customerReference;
	private Integer customerBoxDef;
	private String customerTypeDp;
	private Integer customerBalance;
	private Integer customerGroup;
	private Integer customerCountry;
	private Integer customerOfficial;
	private String customerActivity;
	private String customerRetention;
	private String customerBadReference;
	private Integer customerBadNumber;
	private String customerSex;
	private String customerBirthDate;
	private String customerProfession;
	private String customerPassport;
	private String customerMaritalStatus;
	//sprint 3 padron service --ssa
	private String customerFirstName;
	private String customerAdditionalLastName;
	private Integer customerSexCode;	
	private String customerDateCharge;
	private String customerDescription;
	private String customerCodelec;
	private String customerBoard;
	private String customerNationalityD;
	private String customerSexType;
	private String customerBusinessName;
	
	private Integer customerBurdenNumber;
	private Integer customerChildrenNumber;
	private BigDecimal customerEntry;
	private BigDecimal customerExpense;
	private String customerStudyLevel;
	private String customerHouseType;
	private String customerPersonType;
	private Integer customerpropiedad;
	private Integer customerJob;
	private String customerIssueDate;
	private String customerExpirationDate;
	private String customerAssociated;	
	private String customerSituation;
	private BigDecimal customerPatrimonyTec;
	private String customerPatrimonyDate;
	private String customerEntailment;
	private String customerEntailmentType;
	private Integer customerOfficialSubstitute;
	private String customerIsClient;
	private String customerPreferen; 
	private String customerEmploymentStatus;
	private Integer customerNationality;
	private String customerTutorType;
	private String customerTutorName;
	private String customerOtherEntries;
	private String customerEntriesSource;

	private String customerStatus;
	private String customerAutObservation;
	private String customerContractSigned;
	private String customerUnderAge;
	private String customerAlias;
	private String customerPayroll;
	private String customerCodRisk;
	private String customerIndustry;
	private String customerActivityI;
	private String customerRegistrant;
	private String customerExcepcionPad;
	private String customerBusinessLine;
	private String customerBusinessSeg;
	private String customerIdCheck;
	private Integer customerExecutive;
	private Integer customerManagementBranch;
	private String customerActCompKYC;
	private String customerActKYCDate;
	private String customerReqKYCNumber;
	private String customerActProfile;
	private String customerActProfileDate;
	private String customerSalary;
	private String customerInSalaryDate;
	private String customerOutSalaryDate;
	private String customerUpdateCic;
	private String customerUpdateCicDate;
	private String customerExceptionCic;
	private String customerSourceIng;
	private String customerActPrin;
	private String customerDetails;
	private BigDecimal customerActDol;
	private String customerCatAml;
	private String customerEntailmentDate;
	private String customerObservationEntailment;
	
	////////////
	private String customerLastName;
	private String customerSecondLastName;
	private String customerConstitutionDate;
	private String customerSocietyType;
	private BigDecimal customerTotalAssets;
	private Integer customerNStaff;
	private String customerVerified;
	private String customerVerificationDate;
	private String customerMiddleName;
	private String customerSocialReason;
	//
	private Integer customerMonthlyIncome;
	private String  customerCategory;
	private String customerNoSalary; 
	private String customerInstitutionRelationship;
    private String customerDocValidated;
    
    
    private Date birthDate;
    private Date expirationDate;
    private Date inSalaryDate;
	private Date outSalaryDate;
	private Date actProfileDate;
	private Date actKYCDate;
	private String monthlyIncome;
	private Integer checkDigit;
	private Integer licenseNumber;
	private String knownAs;
	private Integer socialSecurity;
	private String econimicActivity;
	private String	uniqueContract;
	private String	employeeLogin;
	private String	customerCategoryCust;
	private String	mediaType;
	private String	exceptionRegister;
	private String	incomeSource;
	private String	principalActivity;
	private Integer monthlyActivityDollarized;
	
	
	public Integer getCheckDigit() {
		return checkDigit;
	}


	public void setCheckDigit(Integer checkDigit) {
		this.checkDigit = checkDigit;
	}


	public Integer getLicenseNumber() {
		return licenseNumber;
	}


	public void setLicenseNumber(Integer licenseNumber) {
		this.licenseNumber = licenseNumber;
	}


	public String getKnownAs() {
		return knownAs;
	}


	public void setKnownAs(String knownAs) {
		this.knownAs = knownAs;
	}


	public Integer getSocialSecurity() {
		return socialSecurity;
	}


	public void setSocialSecurity(Integer socialSecurity) {
		this.socialSecurity = socialSecurity;
	}


	public String getEconimicActivity() {
		return econimicActivity;
	}


	public void setEconimicActivity(String econimicActivity) {
		this.econimicActivity = econimicActivity;
	}


	public String getUniqueContract() {
		return uniqueContract;
	}


	public void setUniqueContract(String uniqueContract) {
		this.uniqueContract = uniqueContract;
	}


	public String getEmployeeLogin() {
		return employeeLogin;
	}


	public void setEmployeeLogin(String employeeLogin) {
		this.employeeLogin = employeeLogin;
	}


	public String getCustomerCategoryCust() {
		return customerCategoryCust;
	}


	public void setCustomerCategoryCust(String customerCategoryCust) {
		this.customerCategoryCust = customerCategoryCust;
	}


	public String getMediaType() {
		return mediaType;
	}


	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}


	public String getExceptionRegister() {
		return exceptionRegister;
	}


	public void setExceptionRegister(String exceptionRegister) {
		this.exceptionRegister = exceptionRegister;
	}


	public String getIncomeSource() {
		return incomeSource;
	}


	public void setIncomeSource(String incomeSource) {
		this.incomeSource = incomeSource;
	}


	public String getPrincipalActivity() {
		return principalActivity;
	}


	public void setPrincipalActivity(String principalActivity) {
		this.principalActivity = principalActivity;
	}


	public Integer getMonthlyActivityDollarized() {
		return monthlyActivityDollarized;
	}


	public void setMonthlyActivityDollarized(Integer monthlyActivityDollarized) {
		this.monthlyActivityDollarized = monthlyActivityDollarized;
	}


	public String getMonthlyIncome() {
		return monthlyIncome;
	}


	public void setMonthlyIncome(String monthlyIncome) {
		this.monthlyIncome = monthlyIncome;
	}


	public String getCustomerDocValidated() {
		return customerDocValidated;
	}


	public Date getBirthDate() {
		return birthDate;
	}


	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}


	public Date getExpirationDate() {
		return expirationDate;
	}


	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}


	public Date getInSalaryDate() {
		return inSalaryDate;
	}


	public void setInSalaryDate(Date inSalaryDate) {
		this.inSalaryDate = inSalaryDate;
	}


	public Date getOutSalaryDate() {
		return outSalaryDate;
	}


	public void setOutSalaryDate(Date outSalaryDate) {
		this.outSalaryDate = outSalaryDate;
	}


	public Date getActProfileDate() {
		return actProfileDate;
	}


	public void setActProfileDate(Date actProfileDate) {
		this.actProfileDate = actProfileDate;
	}


	public Date getActKYCDate() {
		return actKYCDate;
	}


	public void setActKYCDate(Date actKYCDate) {
		this.actKYCDate = actKYCDate;
	}


	public void setCustomerDocValidated(String customerDocValidated) {
		this.customerDocValidated = customerDocValidated;
	}


	public String getCustomerInstitutionRelationship() {
		return customerInstitutionRelationship;
	}


	public void setCustomerInstitutionRelationship(
			String customerInstitutionRelationship) {
		this.customerInstitutionRelationship = customerInstitutionRelationship;
	}


	public String getCustomerNoSalary() {
		return customerNoSalary;
	}


	public void setCustomerNoSalary(String customerNoSalary) {
		this.customerNoSalary = customerNoSalary;
	}


	public String getCustomerCategory() {
		return customerCategory;
	}


	public void setCustomerCategory(String customerCategory) {
		this.customerCategory = customerCategory;
	}


	public Integer getCustomerMonthlyIncome() {
		return customerMonthlyIncome;
	}


	public void setCustomerMonthlyIncome(Integer customerMonthlyIncome) {
		this.customerMonthlyIncome = customerMonthlyIncome;
	}


	public String getCustomerFirstName() {
		return customerFirstName;
	}


	public void setCustomerFirstName(String customerFirstName) {
		this.customerFirstName = customerFirstName;
	}


	public String getCustomerAdditionalLastName() {
		return customerAdditionalLastName;
	}


	public void setCustomerAdditionalLastName(String customerAdditionalLastName) {
		this.customerAdditionalLastName = customerAdditionalLastName;
	}


	public Integer getCustomerSexCode() {
		return customerSexCode;
	}


	public void setCustomerSexCode(Integer customerSexCode) {
		this.customerSexCode = customerSexCode;
	}


	public String getCustomerDateCharge() {
		return customerDateCharge;
	}


	public void setCustomerDateCharge(String customerDateCharge) {
		this.customerDateCharge = customerDateCharge;
	}


	public String getCustomerDescription() {
		return customerDescription;
	}


	public void setCustomerDescription(String customerDescription) {
		this.customerDescription = customerDescription;
	}


	public String getCustomerCodelec() {
		return customerCodelec;
	}


	public void setCustomerCodelec(String customerCodelec) {
		this.customerCodelec = customerCodelec;
	}


	public String getCustomerBoard() {
		return customerBoard;
	}


	public void setCustomerBoard(String customerBoard) {
		this.customerBoard = customerBoard;
	}


	public String getCustomerNationalityD() {
		return customerNationalityD;
	}


	public void setCustomerNationalityD(String customerNationalityD) {
		this.customerNationalityD = customerNationalityD;
	}


	public String getCustomerSexType() {
		return customerSexType;
	}


	public void setCustomerSexType(String customerSexType) {
		this.customerSexType = customerSexType;
	}


	public String getCustomerBusinessName() {
		return customerBusinessName;
	}


	public void setCustomerBusinessName(String customerBusinessName) {
		this.customerBusinessName = customerBusinessName;
	}


	public String getCustomerConstitutionDate() {
		return customerConstitutionDate;
	}


	public void setCustomerConstitutionDate(String customerConstitutionDate) {
		this.customerConstitutionDate = customerConstitutionDate;
	}


	public String getCustomerSocietyType() {
		return customerSocietyType;
	}


	public void setCustomerSocietyType(String customerSocietyType) {
		this.customerSocietyType = customerSocietyType;
	}


	public BigDecimal getCustomerTotalAssets() {
		return customerTotalAssets;
	}


	public void setCustomerTotalAssets(BigDecimal customerTotalAssets) {
		this.customerTotalAssets = customerTotalAssets;
	}


	public Integer getCustomerNStaff() {
		return customerNStaff;
	}


	public void setCustomerNStaff(Integer customerNStaff) {
		this.customerNStaff = customerNStaff;
	}


	public String getCustomerVerified() {
		return customerVerified;
	}


	public void setCustomerVerified(String customerVerified) {
		this.customerVerified = customerVerified;
	}


	public String getCustomerVerificationDate() {
		return customerVerificationDate;
	}


	public void setCustomerVerificationDate(String customerVerificationDate) {
		this.customerVerificationDate = customerVerificationDate;
	}


	public String getCustomerMiddleName() {
		return customerMiddleName;
	}


	public void setCustomerMiddleName(String customerMiddleName) {
		this.customerMiddleName = customerMiddleName;
	}


	public String getCustomerSocialReason() {
		return customerSocialReason;
	}


	public void setCustomerSocialReason(String customerSocialReason) {
		this.customerSocialReason = customerSocialReason;
	}


	
	
	
	
	public String getCustomerBirthDate() {
		return customerBirthDate;
	}


	public void setCustomerBirthDate(String customerBirthDate) {
		this.customerBirthDate = customerBirthDate;
	}


	public Integer getCustomerChildrenNumber() {
		return customerChildrenNumber;
	}


	public void setCustomerChildrenNumber(Integer customerChildrenNumber) {
		this.customerChildrenNumber = customerChildrenNumber;
	}


	public String getCustomerLastName() {
		return customerLastName;
	}


	public void setCustomerLastName(String customerLastName) {
		this.customerLastName = customerLastName;
	}


	public String getCustomerSecondLastName() {
		return customerSecondLastName;
	}


	public void setCustomerSecondLastName(String customerSecondLastName) {
		this.customerSecondLastName = customerSecondLastName;
	}


	public Integer getCustomerID() {
		return customerID;
	}


	public void setCustomerID(Integer customerID) {
		this.customerID = customerID;
	}


	public String getCustomerTypeDocumentId() {
		return customerTypeDocumentId;
	}


	public void setCustomerTypeDocumentId(String customerTypeDocumentId) {
		this.customerTypeDocumentId = customerTypeDocumentId;
	}


	public String getCustomerIdentification() {
		return customerIdentification;
	}


	public void setCustomerIdentification(String customerIdentification) {
		this.customerIdentification = customerIdentification;
	}


	public String getCustomerCompleteName() {
		return customerCompleteName;
	}


	public void setCustomerCompleteName(String customerCompleteName) {
		this.customerCompleteName = customerCompleteName;
	}


	public String getCustomerName() {
		return customerName;
	}


	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}


	public String getCustomerSubType() {
		return customerSubType;
	}


	public void setCustomerSubType(String customerSubType) {
		this.customerSubType = customerSubType;
	}


	public String getCustomerTypePersonId() {
		return customerTypePersonId;
	}


	public void setCustomerTypePersonId(String customerTypePersonId) {
		this.customerTypePersonId = customerTypePersonId;
	}


	public String getCustomerSector() {
		return customerSector;
	}


	public void setCustomerSector(String customerSector) {
		this.customerSector = customerSector;
	}


	public String getCustomerAffiliate() {
		return customerAffiliate;
	}


	public void setCustomerAffiliate(String customerAffiliate) {
		this.customerAffiliate = customerAffiliate;
	}


	public Integer getCustomerOffice() {
		return customerOffice;
	}


	public void setCustomerOffice(Integer customerOffice) {
		this.customerOffice = customerOffice;
	}


	public String getCustomerCreatedDate() {
		return customerCreatedDate;
	}


	public void setCustomerCreatedDate(String customerCreatedDate) {
		this.customerCreatedDate = customerCreatedDate;
	}


	public String getCustomerModifiedDate() {
		return customerModifiedDate;
	}


	public void setCustomerModifiedDate(String customerModifiedDate) {
		this.customerModifiedDate = customerModifiedDate;
	}


	public Integer getCustomerAddress() {
		return customerAddress;
	}


	public void setCustomerAddress(Integer customerAddress) {
		this.customerAddress = customerAddress;
	}


	public Integer getCustomerReference() {
		return customerReference;
	}


	public void setCustomerReference(Integer customerReference) {
		this.customerReference = customerReference;
	}


	public Integer getCustomerBoxDef() {
		return customerBoxDef;
	}


	public void setCustomerBoxDef(Integer customerBoxDef) {
		this.customerBoxDef = customerBoxDef;
	}


	public String getCustomerTypeDp() {
		return customerTypeDp;
	}


	public void setCustomerTypeDp(String customerTypeDp) {
		this.customerTypeDp = customerTypeDp;
	}


	public Integer getCustomerBalance() {
		return customerBalance;
	}


	public void setCustomerBalance(Integer customerBalance) {
		this.customerBalance = customerBalance;
	}


	public Integer getCustomerGroup() {
		return customerGroup;
	}


	public void setCustomerGroup(Integer customerGroup) {
		this.customerGroup = customerGroup;
	}


	public Integer getCustomerCountry() {
		return customerCountry;
	}


	public void setCustomerCountry(Integer customerCountry) {
		this.customerCountry = customerCountry;
	}


	public Integer getCustomerOfficial() {
		return customerOfficial;
	}


	public void setCustomerOfficial(Integer customerOfficial) {
		this.customerOfficial = customerOfficial;
	}


	public String getCustomerActivity() {
		return customerActivity;
	}


	public void setCustomerActivity(String customerActivity) {
		this.customerActivity = customerActivity;
	}


	public String getCustomerRetention() {
		return customerRetention;
	}


	public void setCustomerRetention(String customerRetention) {
		this.customerRetention = customerRetention;
	}


	public String getCustomerBadReference() {
		return customerBadReference;
	}


	public void setCustomerBadReference(String customerBadReference) {
		this.customerBadReference = customerBadReference;
	}


	public Integer getCustomerBadNumber() {
		return customerBadNumber;
	}


	public void setCustomerBadNumber(Integer customerBadNumber) {
		this.customerBadNumber = customerBadNumber;
	}


	public String getCustomerSex() {
		return customerSex;
	}


	public void setCustomerSex(String customerSex) {
		this.customerSex = customerSex;
	}


	

	public String getCustomerProfession() {
		return customerProfession;
	}


	public void setCustomerProfession(String customerProfession) {
		this.customerProfession = customerProfession;
	}


	public String getCustomerPassport() {
		return customerPassport;
	}


	public void setCustomerPassport(String customerPassport) {
		this.customerPassport = customerPassport;
	}


	public String getCustomerMaritalStatus() {
		return customerMaritalStatus;
	}


	public void setCustomerMaritalStatus(String customerMaritalStatus) {
		this.customerMaritalStatus = customerMaritalStatus;
	}


	public Integer getCustomerBurdenNumber() {
		return customerBurdenNumber;
	}


	public void setCustomerBurdenNumber(Integer customerBurdenNumber) {
		this.customerBurdenNumber = customerBurdenNumber;
	}


	
	public BigDecimal getCustomerEntry() {
		return customerEntry;
	}


	public void setCustomerEntry(BigDecimal customerEntry) {
		this.customerEntry = customerEntry;
	}


	public BigDecimal getCustomerExpense() {
		return customerExpense;
	}


	public void setCustomerExpense(BigDecimal customerExpense) {
		this.customerExpense = customerExpense;
	}


	public String getCustomerStudyLevel() {
		return customerStudyLevel;
	}


	public void setCustomerStudyLevel(String customerStudyLevel) {
		this.customerStudyLevel = customerStudyLevel;
	}


	public String getCustomerHouseType() {
		return customerHouseType;
	}


	public void setCustomerHouseType(String customerHouseType) {
		this.customerHouseType = customerHouseType;
	}


	public String getCustomerPersonType() {
		return customerPersonType;
	}


	public void setCustomerPersonType(String customerPersonType) {
		this.customerPersonType = customerPersonType;
	}


	public Integer getCustomerpropiedad() {
		return customerpropiedad;
	}


	public void setCustomerpropiedad(Integer customerpropiedad) {
		this.customerpropiedad = customerpropiedad;
	}


	public Integer getCustomerJob() {
		return customerJob;
	}


	public void setCustomerJob(Integer customerJob) {
		this.customerJob = customerJob;
	}


	public String getCustomerIssueDate() {
		return customerIssueDate;
	}


	public void setCustomerIssueDate(String customerIssueDate) {
		this.customerIssueDate = customerIssueDate;
	}


	public String getCustomerExpirationDate() {
		return customerExpirationDate;
	}


	public void setCustomerExpirationDate(String customerExpirationDate) {
		this.customerExpirationDate = customerExpirationDate;
	}


	public String getCustomerAssociated() {
		return customerAssociated;
	}


	public void setCustomerAssociated(String customerAssociated) {
		this.customerAssociated = customerAssociated;
	}


	public String getCustomerSituation() {
		return customerSituation;
	}


	public void setCustomerSituation(String customerSituation) {
		this.customerSituation = customerSituation;
	}


	public BigDecimal getCustomerPatrimonyTec() {
		return customerPatrimonyTec;
	}


	public void setCustomerPatrimonyTec(BigDecimal customerPatrimonyTec) {
		this.customerPatrimonyTec = customerPatrimonyTec;
	}


	public String getCustomerPatrimonyDate() {
		return customerPatrimonyDate;
	}


	public void setCustomerPatrimonyDate(String customerPatrimonyDate) {
		this.customerPatrimonyDate = customerPatrimonyDate;
	}


	public String getCustomerEntailment() {
		return customerEntailment;
	}


	public void setCustomerEntailment(String customerEntailment) {
		this.customerEntailment = customerEntailment;
	}


	public String getCustomerEntailmentType() {
		return customerEntailmentType;
	}


	public void setCustomerEntailmentType(String customerEntailmentType) {
		this.customerEntailmentType = customerEntailmentType;
	}


	public Integer getCustomerOfficialSubstitute() {
		return customerOfficialSubstitute;
	}


	public void setCustomerOfficialSubstitute(Integer customerOfficialSubstitute) {
		this.customerOfficialSubstitute = customerOfficialSubstitute;
	}


	public String getCustomerIsClient() {
		return customerIsClient;
	}


	public void setCustomerIsClient(String customerIsClient) {
		this.customerIsClient = customerIsClient;
	}


	public String getCustomerPreferen() {
		return customerPreferen;
	}


	public void setCustomerPreferen(String customerPreferen) {
		this.customerPreferen = customerPreferen;
	}


	public String getCustomerEmploymentStatus() {
		return customerEmploymentStatus;
	}


	public void setCustomerEmploymentStatus(String customerEmploymentStatus) {
		this.customerEmploymentStatus = customerEmploymentStatus;
	}


	public Integer getCustomerNationality() {
		return customerNationality;
	}


	public void setCustomerNationality(Integer customerNationality) {
		this.customerNationality = customerNationality;
	}


	public String getCustomerTutorType() {
		return customerTutorType;
	}


	public void setCustomerTutorType(String customerTutorType) {
		this.customerTutorType = customerTutorType;
	}


	public String getCustomerTutorName() {
		return customerTutorName;
	}


	public void setCustomerTutorName(String customerTutorName) {
		this.customerTutorName = customerTutorName;
	}


	public String getCustomerOtherEntries() {
		return customerOtherEntries;
	}


	public void setCustomerOtherEntries(String customerOtherEntries) {
		this.customerOtherEntries = customerOtherEntries;
	}


	public String getCustomerEntriesSource() {
		return customerEntriesSource;
	}


	public void setCustomerEntriesSource(String customerEntriesSource) {
		this.customerEntriesSource = customerEntriesSource;
	}


	public String getCustomerStatus() {
		return customerStatus;
	}


	public void setCustomerStatus(String customerStatus) {
		this.customerStatus = customerStatus;
	}


	public String getCustomerAutObservation() {
		return customerAutObservation;
	}


	public void setCustomerAutObservation(String customerAutObservation) {
		this.customerAutObservation = customerAutObservation;
	}


	public String getCustomerContractSigned() {
		return customerContractSigned;
	}


	public void setCustomerContractSigned(String customerContractSigned) {
		this.customerContractSigned = customerContractSigned;
	}


	public String getCustomerUnderAge() {
		return customerUnderAge;
	}


	public void setCustomerUnderAge(String customerUnderAge) {
		this.customerUnderAge = customerUnderAge;
	}


	public String getCustomerAlias() {
		return customerAlias;
	}


	public void setCustomerAlias(String customerAlias) {
		this.customerAlias = customerAlias;
	}


	public String getCustomerPayroll() {
		return customerPayroll;
	}


	public void setCustomerPayroll(String customerPayroll) {
		this.customerPayroll = customerPayroll;
	}


	public String getCustomerCodRisk() {
		return customerCodRisk;
	}


	public void setCustomerCodRisk(String customerCodRisk) {
		this.customerCodRisk = customerCodRisk;
	}


	public String getCustomerIndustry() {
		return customerIndustry;
	}


	public void setCustomerIndustry(String customerIndustry) {
		this.customerIndustry = customerIndustry;
	}


	public String getCustomerActivityI() {
		return customerActivityI;
	}


	public void setCustomerActivityI(String customerActivityI) {
		this.customerActivityI = customerActivityI;
	}


	public String getCustomerRegistrant() {
		return customerRegistrant;
	}


	public void setCustomerRegistrant(String customerRegistrant) {
		this.customerRegistrant = customerRegistrant;
	}


	public String getCustomerExcepcionPad() {
		return customerExcepcionPad;
	}


	public void setCustomerExcepcionPad(String customerExcepcionPad) {
		this.customerExcepcionPad = customerExcepcionPad;
	}


	public String getCustomerBusinessLine() {
		return customerBusinessLine;
	}


	public void setCustomerBusinessLine(String customerBusinessLine) {
		this.customerBusinessLine = customerBusinessLine;
	}


	public String getCustomerBusinessSeg() {
		return customerBusinessSeg;
	}


	public void setCustomerBusinessSeg(String customerBusinessSeg) {
		this.customerBusinessSeg = customerBusinessSeg;
	}


	public String getCustomerIdCheck() {
		return customerIdCheck;
	}


	public void setCustomerIdCheck(String customerIdCheck) {
		this.customerIdCheck = customerIdCheck;
	}


	public Integer getCustomerExecutive() {
		return customerExecutive;
	}


	public void setCustomerExecutive(Integer customerExecutive) {
		this.customerExecutive = customerExecutive;
	}


	public Integer getCustomerManagementBranch() {
		return customerManagementBranch;
	}


	public void setCustomerManagementBranch(Integer customerManagementBranch) {
		this.customerManagementBranch = customerManagementBranch;
	}


	public String getCustomerActCompKYC() {
		return customerActCompKYC;
	}


	public void setCustomerActCompKYC(String customerActCompKYC) {
		this.customerActCompKYC = customerActCompKYC;
	}


	public String getCustomerActKYCDate() {
		return customerActKYCDate;
	}


	public void setCustomerActKYCDate(String customerActKYCDate) {
		this.customerActKYCDate = customerActKYCDate;
	}


	public String getCustomerReqKYCNumber() {
		return customerReqKYCNumber;
	}


	public void setCustomerReqKYCNumber(String customerReqKYCNumber) {
		this.customerReqKYCNumber = customerReqKYCNumber;
	}


	public String getCustomerActProfile() {
		return customerActProfile;
	}


	public void setCustomerActProfile(String customerActProfile) {
		this.customerActProfile = customerActProfile;
	}


	public String getCustomerActProfileDate() {
		return customerActProfileDate;
	}


	public void setCustomerActProfileDate(String customerActProfileDate) {
		this.customerActProfileDate = customerActProfileDate;
	}


	public String getCustomerSalary() {
		return customerSalary;
	}


	public void setCustomerSalary(String customerSalary) {
		this.customerSalary = customerSalary;
	}


	public String getCustomerInSalaryDate() {
		return customerInSalaryDate;
	}


	public void setCustomerInSalaryDate(String customerInSalaryDate) {
		this.customerInSalaryDate = customerInSalaryDate;
	}


	public String getCustomerOutSalaryDate() {
		return customerOutSalaryDate;
	}


	public void setCustomerOutSalaryDate(String customerOutSalaryDate) {
		this.customerOutSalaryDate = customerOutSalaryDate;
	}


	public String getCustomerUpdateCic() {
		return customerUpdateCic;
	}


	public void setCustomerUpdateCic(String customerUpdateCic) {
		this.customerUpdateCic = customerUpdateCic;
	}


	public String getCustomerUpdateCicDate() {
		return customerUpdateCicDate;
	}


	public void setCustomerUpdateCicDate(String customerUpdateCicDate) {
		this.customerUpdateCicDate = customerUpdateCicDate;
	}


	public String getCustomerExceptionCic() {
		return customerExceptionCic;
	}


	public void setCustomerExceptionCic(String customerExceptionCic) {
		this.customerExceptionCic = customerExceptionCic;
	}


	public String getCustomerSourceIng() {
		return customerSourceIng;
	}


	public void setCustomerSourceIng(String customerSourceIng) {
		this.customerSourceIng = customerSourceIng;
	}


	public String getCustomerActPrin() {
		return customerActPrin;
	}


	public void setCustomerActPrin(String customerActPrin) {
		this.customerActPrin = customerActPrin;
	}


	public String getCustomerDetails() {
		return customerDetails;
	}


	public void setCustomerDetails(String customerDetails) {
		this.customerDetails = customerDetails;
	}


	public BigDecimal getCustomerActDol() {
		return customerActDol;
	}


	public void setCustomerActDol(BigDecimal customerActDol) {
		this.customerActDol = customerActDol;
	}


	public String getCustomerCatAml() {
		return customerCatAml;
	}


	public void setCustomerCatAml(String customerCatAml) {
		this.customerCatAml = customerCatAml;
	}


	public String getCustomerEntailmentDate() {
		return customerEntailmentDate;
	}


	public void setCustomerEntailmentDate(String customerEntailmentDate) {
		this.customerEntailmentDate = customerEntailmentDate;
	}


	public String getCustomerObservationEntailment() {
		return customerObservationEntailment;
	}


	public void setCustomerObservationEntailment(
			String customerObservationEntailment) {
		this.customerObservationEntailment = customerObservationEntailment;
	}


	public CustomerDataResponse() {
		super();		
	}


	public CustomerDataResponse(Integer customerID,
			String customerTypeDocumentId, String customerIdentification,
			String customerCompleteName) {
		super();
		this.customerID = customerID;
		this.customerTypeDocumentId = customerTypeDocumentId;
		this.customerIdentification = customerIdentification;
		this.customerCompleteName = customerCompleteName;
	}


	public CustomerDataResponse(Integer customerID,
			String customerTypeDocumentId, String customerIdentification,
			String customerCompleteName, String customerName,
			String customerSubType, String customerTypePersonId,
			String customerSector) {
		super();
		this.customerID = customerID;
		this.customerTypeDocumentId = customerTypeDocumentId;
		this.customerIdentification = customerIdentification;
		this.customerCompleteName = customerCompleteName;
		this.customerName = customerName;
		this.customerSubType = customerSubType;
		this.customerTypePersonId = customerTypePersonId;
		this.customerSector = customerSector;
	}
	
	
	
	public CustomerDataResponse(Integer customerID,
			String customerTypeDocumentId, String customerIdentification,
			String customerCompleteName, String customerName,
			String customerSubType, String customerTypePersonId,
			String customerSector, String customerAffiliate,
			Integer customerOffice, String customerCreatedDate,
			String customerModifiedDate, Integer customerAddress,
			Integer customerReference, Integer customerBoxDef,
			Integer customerBalance, Integer customerGroup,
			Integer customerCountry, Integer customerOfficial,
			String customerActivity, String customerRetention,
			String customerBadReference, String customerSex,
			String customerbirthDate, String customerProfession,
			String customerMaritalStatus, Integer customerBurdenNumber,
			Integer customerChildreNumber, BigDecimal customerEntry,
			BigDecimal customerExpense, String customerStudyLevel,
			String customerHouseType, String customerPersonType,
			Integer customerJob, String customerIssueDate,
			String customerAssociated,String customerEntailment,
			String customerEntailmentType, Integer customerOfficialSubstitute,
			String customerIsClient, Integer customerNationality,
			String customerTutorType, String customerTutorName,
			String customerPayroll, String customerCodRisk,
			String customerActivityI,
			String customerRegistrant, String customerExcepcionPad,
			String customerBusinessLine, String customerBusinessSeg,
			String customerIdCheck, Integer customerExecutive,
			Integer customerManagementBranch, String customerActCompKYC,
			String customerActKYCDate, String customerReqKYCNumber,
			String customerActProfile, String customerActProfileDate,
			String customerSalary, String customerInSalaryDate,
			String customerOutSalaryDate, String customerUpdateCic,
			String customerUpdateCicDate, String customerExceptionCic,
			String customerSourceIng, String customerActPrin,
			BigDecimal customerActDol, String customerCatAml,
			String customerEntailmentDate, String customerStatus,
			
			String customerLastName, String customerSecondLastName,
			String customerConstitutionDate, String customerSocietyType,
			BigDecimal customerTotalAssets, Integer customerNStaff,
			String customerVerified, String customerVerificationDate,
			String customerMiddleName,	String customerSocialReason) {
		super();
		this.customerID = customerID;
		this.customerTypeDocumentId = customerTypeDocumentId;
		this.customerIdentification = customerIdentification;
		this.customerCompleteName = customerCompleteName;
		this.customerName = customerName;
		this.customerSubType = customerSubType;
		this.customerTypePersonId = customerTypePersonId;
		this.customerSector = customerSector;
		this.customerAffiliate = customerAffiliate;
		this.customerOffice = customerOffice;
		this.customerCreatedDate = customerCreatedDate;
		this.customerModifiedDate = customerModifiedDate;
		this.customerAddress = customerAddress;
		this.customerReference = customerReference;
		this.customerBoxDef = customerBoxDef;
		this.customerBalance = customerBalance;
		this.customerGroup = customerGroup;
		this.customerCountry = customerCountry;
		this.customerOfficial = customerOfficial;
		this.customerActivity = customerActivity;
		this.customerRetention = customerRetention;
		this.customerBadReference = customerBadReference;
		this.customerSex = customerSex;
		this.customerBirthDate = customerbirthDate;
		this.customerProfession = customerProfession;
		this.customerMaritalStatus = customerMaritalStatus;
		this.customerBurdenNumber = customerBurdenNumber;
		this.customerChildrenNumber = customerChildreNumber;
		this.customerEntry = customerEntry;
		this.customerExpense = customerExpense;
		this.customerStudyLevel = customerStudyLevel;
		this.customerHouseType = customerHouseType;
		this.customerPersonType = customerPersonType;
		this.customerJob = customerJob;
		this.customerIssueDate = customerIssueDate;		
		this.customerAssociated = customerAssociated;		
		this.customerEntailment = customerEntailment;
		this.customerEntailmentType = customerEntailmentType;
		this.customerOfficialSubstitute = customerOfficialSubstitute;
		this.customerIsClient = customerIsClient;		
		this.customerNationality = customerNationality;
		this.customerTutorType = customerTutorType;
		this.customerTutorName = customerTutorName;
		this.customerPayroll = customerPayroll;
		this.customerCodRisk = customerCodRisk;		
		this.customerActivityI = customerActivityI;
		this.customerRegistrant = customerRegistrant;
		this.customerExcepcionPad = customerExcepcionPad;
		this.customerBusinessLine = customerBusinessLine;
		this.customerBusinessSeg = customerBusinessSeg;
		this.customerIdCheck = customerIdCheck;
		this.customerExecutive = customerExecutive;
		this.customerManagementBranch = customerManagementBranch;
		this.customerActCompKYC = customerActCompKYC;
		this.customerActKYCDate = customerActKYCDate;
		this.customerReqKYCNumber = customerReqKYCNumber;
		this.customerActProfile = customerActProfile;
		this.customerActProfileDate = customerActProfileDate;
		this.customerSalary = customerSalary;
		this.customerInSalaryDate = customerInSalaryDate;
		this.customerOutSalaryDate = customerOutSalaryDate;
		this.customerUpdateCic = customerUpdateCic;
		this.customerUpdateCicDate = customerUpdateCicDate;
		this.customerExceptionCic = customerExceptionCic;
		this.customerSourceIng = customerSourceIng;
		this.customerActPrin = customerActPrin;
		this.customerActDol = customerActDol;
		this.customerCatAml = customerCatAml;
		this.customerEntailmentDate = customerEntailmentDate;
		this.customerStatus=customerStatus;
		
		this.customerLastName=customerLastName;
		this.customerSecondLastName=customerSecondLastName;
		this.customerConstitutionDate=customerConstitutionDate;
		this.customerSocietyType=customerSocietyType;
		this.customerTotalAssets=customerTotalAssets;
		this.customerNStaff=customerNStaff;
		this.customerVerified=customerVerified;
		this.customerVerificationDate=customerVerificationDate;
		this.customerMiddleName=customerMiddleName;
		this.customerSocialReason=customerSocialReason;
	}


	@Override
	public String toString() {
		return "CustomerDataResponse [customerID=" + customerID
				+ ", customerTypeDocumentId=" + customerTypeDocumentId
				+ ", customerIdentification=" + customerIdentification
				+ ", customerCompleteName=" + customerCompleteName
				+ ", customerName=" + customerName + ", customerSubType="
				+ customerSubType + ", customerTypePersonId="
				+ customerTypePersonId + ", customerSector=" + customerSector
				+ ", getCustomerID()=" + getCustomerID()
				+ ", getCustomerTypeDocumentId()="
				+ getCustomerTypeDocumentId()
				+ ", getCustomerIdentification()="
				+ getCustomerIdentification() + ", getCustomerCompleteName()="
				+ getCustomerCompleteName() + ", getCustomerName()="
				+ getCustomerName() + ", getCustomerSubType()="
				+ getCustomerSubType() + ", getCustomerTypePersonId()="
				+ getCustomerTypePersonId() + ", getCustomerSector()="
				+ getCustomerSector() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}


	
	
}
