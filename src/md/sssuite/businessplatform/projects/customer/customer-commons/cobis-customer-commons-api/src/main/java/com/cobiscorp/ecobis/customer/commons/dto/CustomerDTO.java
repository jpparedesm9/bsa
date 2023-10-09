package com.cobiscorp.ecobis.customer.commons.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * DTO used to save all information of Customers.
 * 
 * @author bbuendia
 * 
 */
public class CustomerDTO {
	private Integer clientNumber;
	private Integer code;
	private String documentId;
	private String name;
	private String fullName;
	private String firstSurname;
	private String secondSurname;
	private String subtype;
	private String documentType;
	private String documentTypeDescription;
	private String passport;
	private String entailment;
	private Date birthdate;
	private Date joinDate;
	private String linkUpType;
	private String linkUpTypeDescription;
	private String codeGender;
	private String gender;
	private String profession;
	private String professionDescription;
	private String activity;
	private String activityDescription;
	private String civilStatus;
	private String civilStatusDescription;
	private String personType;
	private String personTypeDescription;
	private String studyLevel;
	private String studyLevelDescription;
	private Integer groupOrg;
	private String groupDescription;
	private Integer official;
	private String descriptionOfficial;
	private String mainLogin;
	private String superBancariaReported;
	private String customerSituation;
	private String customerSituationDescription;
	private String preferredClient;
	private Double maxDebtQuota;
	private String secondName;
	private Integer departmentDocuments;
	private Integer IdNationality;
	private String concordat;
	private String composedName;
	private Integer cityOfBirth;
	private String cityOfBirthDescription;
	private Integer placeDoc;
	private String placeDocDescription;
	private Double totalAssets;
	private Integer numberEmployees;
	private Double heritage;
	private Date dateHeritage;
	private String typeCompanyId;
	private String segmentId;
	private String coverageId;
	private String activityMark;
	private String typeCompany;
	private String relationCorp;
	private String descriptionSegment;
	private String descriptionCoverage;
	private String functionaryName;
	private String marriedLastName;
	private String blocked;
	private String isClient;
	private String descriptionStatus;
	private String commercialName;
	private String groupName;
	// private String descriptionActivity;
	private String descriptionDocument;
	private String status;
	private String customerType;
	private String legalRepresentative;
	private String office;
	private String nationality;
	private Double incomeLevel;
	private Double outcomesLevel;
	private Integer age;
	private String fullNameCouple;
	private String relationName;
	private String nit;
	private String officeName;
	private Date expirationDate;
	private String descState;
	private String identificationType;
	private String califCartera;
	private Integer cycleNumber;
	private String role;
	private String roleDescription;
	private String clientNumberB;

	private List<EconomicActivityDTO> economicActivity;

	/** Default constructor */
	public CustomerDTO() {
		economicActivity = new ArrayList<EconomicActivityDTO>();
	}

	/**
	 * 
	 * @param code
	 * @param fullName
	 *            --> en_nomlar
	 */
	public CustomerDTO(Integer code, String fullName) {
		this.code = code;
		this.fullName = fullName;
	}

	/**
	 * 
	 * @param code
	 * @param fullName
	 *            es la razón social
	 * @param commercialName
	 */
	public CustomerDTO(Integer code, String fullName, String commercialName) {
		this.code = code;
		this.fullName = fullName;
		this.commercialName = commercialName;

	}

	public CustomerDTO(Integer code, String documentId, String fullName, String subtype, String documentType) {
		this.code = code;
		this.documentId = documentId;
		this.fullName = fullName;
		this.subtype = subtype;
		this.documentType = documentType;
	}

	public CustomerDTO(Integer code, String documentId, String name, String firstSurname, String secondSurname, String subtype, String passport, String entailment,
			String identificationType, String linkUpType, Integer cycleNumber, String role) {
		this.code = code;
		this.documentId = documentId;
		this.name = name;
		this.firstSurname = firstSurname;
		this.secondSurname = secondSurname;
		this.subtype = subtype;
		this.passport = passport;
		this.entailment = entailment;
		firstSurname = firstSurname == null ? "" : firstSurname;
		secondSurname = secondSurname == null ? "" : secondSurname;
		name = name == null ? "" : name;
		this.composedName = firstSurname + " " + secondSurname + " " + name;
		this.identificationType = identificationType;
		this.linkUpType = linkUpType;
		this.cycleNumber = cycleNumber;
		this.role = role;
	}

	public CustomerDTO(String firstSurname, String secondSurname, String name, String documentId, Date birthdate, Date joinDate, String documentType, String linkUpType,
			String codeGender, String profession, String activity, String civilStatus, String personType, String studyLevel, Integer groupOrg, Integer official,
			String superBancariaReported, String customerSituation, String preferredClient, Double maxDebtQuota, String secondName, Integer departmentDocuments,
			Integer idNationality, String concordat, String nit, String officeName, Date expirationDate) {

		this.firstSurname = firstSurname;
		this.secondSurname = secondSurname;
		this.name = name;
		this.documentId = documentId;
		this.birthdate = birthdate;
		this.joinDate = joinDate;
		this.documentType = documentType;
		this.linkUpType = linkUpType;
		this.codeGender = codeGender;
		this.profession = profession;
		this.activity = activity;
		this.civilStatus = civilStatus;
		this.personType = personType;
		this.studyLevel = studyLevel;
		this.groupOrg = groupOrg;
		this.official = official;
		this.superBancariaReported = superBancariaReported;
		this.customerSituation = customerSituation;
		this.preferredClient = preferredClient;
		this.maxDebtQuota = maxDebtQuota;
		this.secondName = secondName;
		this.departmentDocuments = departmentDocuments;
		this.IdNationality = idNationality;
		this.concordat = concordat;
		this.nit = nit;
		this.officeName = officeName;
		this.expirationDate = expirationDate;
	}

	public CustomerDTO(Date joinDate, String documentType, String documentId, String fullName, Double totalAssets, Integer numberEmployees, String superBancariaReported,
			String groupName, String customerSituation, Double heritage, Date dateHeritage, String preferredClient, Double maxDebtQuota, String descriptionDocument,
			Integer official, String typeCompanyId, String linkUpType, String segmentId, String coverageId, Integer groupOrg, String activityMark, String blocked,
			String entailment, String legalRepresentative, String office, String nationality, Double incomeLevel, Double outcomesLevel) {

		this.joinDate = joinDate;
		this.documentType = documentType;
		this.documentId = documentId;
		this.fullName = fullName;
		this.totalAssets = totalAssets;
		this.numberEmployees = numberEmployees;
		this.superBancariaReported = superBancariaReported;
		this.customerSituation = customerSituation;
		this.heritage = heritage;
		this.dateHeritage = dateHeritage;
		this.preferredClient = preferredClient;
		this.maxDebtQuota = maxDebtQuota;
		/*
		 * this.economicGroup = new EconomicGroup();
		 * economicGroup.setGroupName(groupName);
		 */
		this.groupName = groupName;

		/*
		 * this.activityEc = new Activity();
		 * activityEc.setDescription(description);
		 */
		// this.descriptionActivity = description;

		/*
		 * this.documentT = new DocumentType();
		 * documentT.setDescriptionDocument(descriptionDocument);
		 */
		this.descriptionDocument = descriptionDocument;

		this.official = official;
		this.typeCompanyId = typeCompanyId;
		this.linkUpType = linkUpType;
		this.segmentId = segmentId;
		this.coverageId = coverageId;
		this.groupOrg = groupOrg;
		this.activityMark = activityMark;
		this.blocked = blocked;
		this.entailment = entailment;
		this.legalRepresentative = legalRepresentative;
		this.office = office;
		this.nationality = nationality;
		this.incomeLevel = incomeLevel;
		this.outcomesLevel = outcomesLevel;

	}

	/**
	 * This constructor is used for queryClientByParameters Some attributes are
	 * seted by the customer type (Person or Company)
	 * 
	 * @author lcorrales
	 */
	public CustomerDTO(Integer code, String firstSurname, String secondSurname, String marriedLastName, String name, String secondName, String documentId, String documentType,
			Integer official, String descriptionOfficial, String blocked, String status, String isClient, String descriptionStatus, String type, String customerType,
			String califCartera) {

		this.code = code;
		if (type.equals("C")) {
			this.commercialName = firstSurname;
			this.marriedLastName = null;
			this.name = secondSurname;
			this.secondName = null;

		}
		if (type.equals("P")) {
			this.firstSurname = firstSurname;
			this.secondSurname = secondSurname;
			this.marriedLastName = marriedLastName;
			this.name = name;
			this.secondName = secondName;
		}

		this.customerType = customerType;
		this.documentId = documentId;
		this.documentType = documentType;
		this.official = official;
		this.descriptionOfficial = descriptionOfficial;
		this.blocked = blocked;
		this.status = status;
		this.isClient = isClient;
		this.descriptionStatus = descriptionStatus;
		this.califCartera = califCartera;
	}
	
	/*Busqueda de Clientes*/
	 
	public CustomerDTO(Integer code, String firstSurname, String secondSurname, String marriedLastName, String name, String secondName, String documentId, String documentType,
			Integer official, String descriptionOfficial, String blocked, String status, String isClient, String descriptionStatus, String type, String customerType,
			String califCartera, String clientNumberB) {

		this.code = code;
		if (type.equals("C")) {
			this.commercialName = firstSurname;
			this.marriedLastName = null;
			this.name = secondSurname;
			this.secondName = null;

		}
		if (type.equals("P")) {
			this.firstSurname = firstSurname;
			this.secondSurname = secondSurname;
			this.marriedLastName = marriedLastName;
			this.name = name;
			this.secondName = secondName;
		}

		this.customerType = customerType;
		this.documentId = documentId;
		this.documentType = documentType;
		this.official = official;
		this.descriptionOfficial = descriptionOfficial;
		this.blocked = blocked;
		this.status = status;
		this.isClient = isClient;
		this.descriptionStatus = descriptionStatus;
		this.califCartera = califCartera;
	}

	

	public Integer getClientNumber() {
		return clientNumber;
	}

	public void setClientNumber(Integer clientNumber) {
		this.clientNumber = clientNumber;
	}

	public String getClientNumberB() {
		return clientNumberB;
	}

	public void setClientNumberB(String clientNumberB) {
		this.clientNumberB = clientNumberB;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getFirstSurname() {
		return firstSurname;
	}

	public void setFirstSurname(String firstSurname) {
		this.firstSurname = firstSurname;
	}

	public String getIdentificationType() {
		return identificationType;
	}

	public void setIdentificationType(String identificationType) {
		this.identificationType = identificationType;
	}

	public String getSecondSurname() {
		return secondSurname;
	}

	public void setSecondSurname(String secondSurname) {
		this.secondSurname = secondSurname;
	}

	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}

	public String getDocumentTypeDescription() {
		return documentTypeDescription;
	}

	public void setDocumentTypeDescription(String documentTypeDescription) {
		this.documentTypeDescription = documentTypeDescription;
	}

	public String getPassport() {
		return passport;
	}

	public void setPassport(String passport) {
		this.passport = passport;
	}

	public String getEntailment() {
		return entailment;
	}

	public void setEntailment(String entailment) {
		this.entailment = entailment;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getLinkUpType() {
		return linkUpType;
	}

	public void setLinkUpType(String linkUpType) {
		this.linkUpType = linkUpType;
	}

	public String getLinkUpTypeDescription() {
		return linkUpTypeDescription;
	}

	public void setLinkUpTypeDescription(String linkUpTypeDescription) {
		this.linkUpTypeDescription = linkUpTypeDescription;
	}

	public String getCodeGender() {
		return codeGender;
	}

	public void setCodeGender(String codeGender) {
		this.codeGender = codeGender;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getProfessionDescription() {
		return professionDescription;
	}

	public void setProfessionDescription(String professionDescription) {
		this.professionDescription = professionDescription;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getActivityDescription() {
		return activityDescription;
	}

	public void setActivityDescription(String activityDescription) {
		this.activityDescription = activityDescription;
	}

	public String getCivilStatus() {
		return civilStatus;
	}

	public void setCivilStatus(String civilStatus) {
		this.civilStatus = civilStatus;
	}

	public String getCivilStatusDescription() {
		return civilStatusDescription;
	}

	public void setCivilStatusDescription(String civilStatusDescription) {
		this.civilStatusDescription = civilStatusDescription;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getPersonTypeDescription() {
		return personTypeDescription;
	}

	public void setPersonTypeDescription(String personTypeDescription) {
		this.personTypeDescription = personTypeDescription;
	}

	public String getStudyLevel() {
		return studyLevel;
	}

	public void setStudyLevel(String studyLevel) {
		this.studyLevel = studyLevel;
	}

	public String getStudyLevelDescription() {
		return studyLevelDescription;
	}

	public void setStudyLevelDescription(String studyLevelDescription) {
		this.studyLevelDescription = studyLevelDescription;
	}

	public Integer getGroupOrg() {
		return groupOrg;
	}

	public void setGroupOrg(Integer groupOrg) {
		this.groupOrg = groupOrg;
	}

	public String getGroupDescription() {
		return groupDescription;
	}

	public void setGroupDescription(String groupDescription) {
		this.groupDescription = groupDescription;
	}

	public Integer getOfficial() {
		return official;
	}

	public void setOfficial(Integer official) {
		this.official = official;
	}

	public String getDescriptionOfficial() {
		return descriptionOfficial;
	}

	public void setDescriptionOfficial(String descriptionOfficial) {
		this.descriptionOfficial = descriptionOfficial;
	}

	public String getMainLogin() {
		return mainLogin;
	}

	public void setMainLogin(String mainLogin) {
		this.mainLogin = mainLogin;
	}

	public String getSuperBancariaReported() {
		return superBancariaReported;
	}

	public void setSuperBancariaReported(String superBancariaReported) {
		this.superBancariaReported = superBancariaReported;
	}

	public String getCustomerSituation() {
		return customerSituation;
	}

	public void setCustomerSituation(String customerSituation) {
		this.customerSituation = customerSituation;
	}

	public String getCustomerSituationDescription() {
		return customerSituationDescription;
	}

	public void setCustomerSituationDescription(String customerSituationDescription) {
		this.customerSituationDescription = customerSituationDescription;
	}

	public String getPreferredClient() {
		return preferredClient;
	}

	public void setPreferredClient(String preferredClient) {
		this.preferredClient = preferredClient;
	}

	public Double getMaxDebtQuota() {
		return maxDebtQuota;
	}

	public void setMaxDebtQuota(Double maxDebtQuota) {
		this.maxDebtQuota = maxDebtQuota;
	}

	public String getSecondName() {
		return secondName;
	}

	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}

	public Integer getDepartmentDocuments() {
		return departmentDocuments;
	}

	public void setDepartmentDocuments(Integer departmentDocuments) {
		this.departmentDocuments = departmentDocuments;
	}

	public Integer getIdNationality() {
		return IdNationality;
	}

	public void setIdNationality(Integer idNationality) {
		IdNationality = idNationality;
	}

	public String getConcordat() {
		return concordat;
	}

	public void setConcordat(String concordat) {
		this.concordat = concordat;
	}

	public String getComposedName() {
		return composedName;
	}

	public void setComposedName(String composedName) {
		this.composedName = composedName;
	}

	public Integer getCityOfBirth() {
		return cityOfBirth;
	}

	public void setCityOfBirth(Integer cityOfBirth) {
		this.cityOfBirth = cityOfBirth;
	}

	public String getCityOfBirthDescription() {
		return cityOfBirthDescription;
	}

	public void setCityOfBirthDescription(String cityOfBirthDescription) {
		this.cityOfBirthDescription = cityOfBirthDescription;
	}

	public Integer getPlaceDoc() {
		return placeDoc;
	}

	public void setPlaceDoc(Integer placeDoc) {
		this.placeDoc = placeDoc;
	}

	public String getPlaceDocDescription() {
		return placeDocDescription;
	}

	public void setPlaceDocDescription(String placeDocDescription) {
		this.placeDocDescription = placeDocDescription;
	}

	public Double getTotalAssets() {
		return totalAssets;
	}

	public void setTotalAssets(Double totalAssets) {
		this.totalAssets = totalAssets;
	}

	public Integer getNumberEmployees() {
		return numberEmployees;
	}

	public void setNumberEmployees(Integer numberEmployees) {
		this.numberEmployees = numberEmployees;
	}

	public Double getHeritage() {
		return heritage;
	}

	public void setHeritage(Double heritage) {
		this.heritage = heritage;
	}

	public Date getDateHeritage() {
		return dateHeritage;
	}

	public void setDateHeritage(Date dateHeritage) {
		this.dateHeritage = dateHeritage;
	}

	public String getTypeCompanyId() {
		return typeCompanyId;
	}

	public void setTypeCompanyId(String typeCompanyId) {
		this.typeCompanyId = typeCompanyId;
	}

	public String getSegmentId() {
		return segmentId;
	}

	public void setSegmentId(String segmentId) {
		this.segmentId = segmentId;
	}

	public String getCoverageId() {
		return coverageId;
	}

	public void setCoverageId(String coverageId) {
		this.coverageId = coverageId;
	}

	public String getActivityMark() {
		return activityMark;
	}

	public void setActivityMark(String activityMark) {
		this.activityMark = activityMark;
	}

	public String getTypeCompany() {
		return typeCompany;
	}

	public void setTypeCompany(String typeCompany) {
		this.typeCompany = typeCompany;
	}

	public String getRelationCorp() {
		return relationCorp;
	}

	public void setRelationCorp(String relationCorp) {
		this.relationCorp = relationCorp;
	}

	public String getDescriptionSegment() {
		return descriptionSegment;
	}

	public void setDescriptionSegment(String descriptionSegment) {
		this.descriptionSegment = descriptionSegment;
	}

	public String getDescriptionCoverage() {
		return descriptionCoverage;
	}

	public void setDescriptionCoverage(String descriptionCoverage) {
		this.descriptionCoverage = descriptionCoverage;
	}

	public String getFunctionaryName() {
		return functionaryName;
	}

	public void setFunctionaryName(String functionaryName) {
		this.functionaryName = functionaryName;
	}

	public String getMarriedLastName() {
		return marriedLastName;
	}

	public void setMarriedLastName(String marriedLastName) {
		this.marriedLastName = marriedLastName;
	}

	public String getBlocked() {
		return blocked;
	}

	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}

	public String getIsClient() {
		return isClient;
	}

	public void setIsClient(String isClient) {
		this.isClient = isClient;
	}

	public String getDescriptionStatus() {
		return descriptionStatus;
	}

	public void setDescriptionStatus(String descriptionStatus) {
		this.descriptionStatus = descriptionStatus;
	}

	public String getCommercialName() {
		return commercialName;
	}

	public void setCommercialName(String commercialName) {
		this.commercialName = commercialName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	/*
	 * public String getDescriptionActivity() { return descriptionActivity; }
	 * 
	 * public void setDescriptionActivity(String descriptionActivity) {
	 * this.descriptionActivity = descriptionActivity; }
	 */

	public String getDescriptionDocument() {
		return descriptionDocument;
	}

	public void setDescriptionDocument(String descriptionDocument) {
		this.descriptionDocument = descriptionDocument;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public List<EconomicActivityDTO> getEconomicActivity() {
		return economicActivity;
	}

	public void setEconomicActivity(List<EconomicActivityDTO> economicActivity) {
		this.economicActivity = economicActivity;
	}

	public String getLegalRepresentative() {
		return legalRepresentative;
	}

	public void setLegalRepresentative(String legalRepresentative) {
		this.legalRepresentative = legalRepresentative;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	/**
	 * @return the age
	 */
	public Integer getAge() {
		return age;
	}

	/**
	 * @param age
	 *            the age to set
	 */
	public void setAge(Integer age) {
		this.age = age;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public Double getIncomeLevel() {
		return incomeLevel;
	}

	public void setIncomeLevel(Double incomeLevel) {
		this.incomeLevel = incomeLevel;
	}

	public Double getOutcomesLevel() {
		return outcomesLevel;
	}

	public void setOutcomesLevel(Double outcomesLevel) {
		this.outcomesLevel = outcomesLevel;
	}

	/**
	 * @return the fullNameCouple
	 */
	public String getFullNameCouple() {
		return fullNameCouple;
	}

	/**
	 * @param fullNameCouple
	 *            the fullNameCouple to set
	 */
	public void setFullNameCouple(String fullNameCouple) {
		this.fullNameCouple = fullNameCouple;
	}

	/**
	 * @return the relationName
	 */
	public String getRelationName() {
		return relationName;
	}

	/**
	 * @param relationName
	 *            the relationName to set
	 */
	public void setRelationName(String relationName) {
		this.relationName = relationName;
	}

	/**
	 * @return the nit
	 */
	public String getNit() {
		return nit;
	}

	/**
	 * @param nit
	 *            the nit to set
	 */
	public void setNit(String nit) {
		this.nit = nit;
	}

	/**
	 * @return the officeName
	 */
	public String getOfficeName() {
		return officeName;
	}

	/**
	 * @param officeName
	 *            the officeName to set
	 */
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

	/**
	 * @return the expirationDate
	 */
	public Date getExpirationDate() {
		return expirationDate;
	}

	/**
	 * @param expirationDate
	 *            the expirationDate to set
	 */
	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	/**
	 * @return the descState
	 */
	public String getDescState() {
		return descState;
	}

	/**
	 * @param descState
	 *            the descState to set
	 */
	public void setDescState(String descState) {
		this.descState = descState;
	}

	public String getCalifCartera() {
		return califCartera;
	}

	public void setCalifCartera(String califCartera) {
		this.califCartera = califCartera;
	}

	public Integer getCycleNumber() {
		return cycleNumber;
	}

	public void setCycleNumber(Integer cycleNumber) {
		this.cycleNumber = cycleNumber;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((clientNumber == null) ? 0 : clientNumber.hashCode());
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CustomerDTO other = (CustomerDTO) obj;
		if (clientNumber == null) {
			if (other.clientNumber != null)
				return false;
		} else if (!clientNumber.equals(other.clientNumber))
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CustomerDTO [clientNumber=" + clientNumber + ", code=" + code + ", documentId=" + documentId + ", name=" + name + ", fullName=" + fullName + ", firstSurname="
				+ firstSurname + ", secondSurname=" + secondSurname + ", subtype=" + subtype + ", documentType=" + documentType + ", documentTypeDescription="
				+ documentTypeDescription + ", passport=" + passport + ", entailment=" + entailment + ", birthdate=" + birthdate + ", joinDate=" + joinDate + ", linkUpType="
				+ linkUpType + ", linkUpTypeDescription=" + linkUpTypeDescription + ", codeGender=" + codeGender + ", gender=" + gender + ", profession=" + profession
				+ ", professionDescription=" + professionDescription + ", activity=" + activity + ", activityDescription=" + activityDescription + ", civilStatus=" + civilStatus
				+ ", civilStatusDescription=" + civilStatusDescription + ", personType=" + personType + ", personTypeDescription=" + personTypeDescription + ", studyLevel="
				+ studyLevel + ", studyLevelDescription=" + studyLevelDescription + ", groupOrg=" + groupOrg + ", groupDescription=" + groupDescription + ", official=" + official
				+ ", descriptionOfficial=" + descriptionOfficial + ", mainLogin=" + mainLogin + ", superBancariaReported=" + superBancariaReported + ", customerSituation="
				+ customerSituation + ", customerSituationDescription=" + customerSituationDescription + ", preferredClient=" + preferredClient + ", maxDebtQuota=" + maxDebtQuota
				+ ", secondName=" + secondName + ", departmentDocuments=" + departmentDocuments + ", IdNationality=" + IdNationality + ", concordat=" + concordat
				+ ", composedName=" + composedName + ", cityOfBirth=" + cityOfBirth + ", cityOfBirthDescription=" + cityOfBirthDescription + ", placeDoc=" + placeDoc
				+ ", placeDocDescription=" + placeDocDescription + ", totalAssets=" + totalAssets + ", numberEmployees=" + numberEmployees + ", heritage=" + heritage
				+ ", dateHeritage=" + dateHeritage + ", typeCompanyId=" + typeCompanyId + ", segmentId=" + segmentId + ", coverageId=" + coverageId + ", activityMark="
				+ activityMark + ", typeCompany=" + typeCompany + ", relationCorp=" + relationCorp + ", descriptionSegment=" + descriptionSegment + ", descriptionCoverage="
				+ descriptionCoverage + ", functionaryName=" + functionaryName + ", marriedLastName=" + marriedLastName + ", blocked=" + blocked + ", isClient=" + isClient
				+ ", descriptionStatus=" + descriptionStatus + ", commercialName=" + commercialName + ", groupName=" + groupName + ", descriptionDocument=" + descriptionDocument
				+ ", status=" + status + ", customerType=" + customerType + ", legalRepresentative=" + legalRepresentative + ", office=" + office + ", nationality=" + nationality
				+ ", incomeLevel=" + incomeLevel + ", outcomesLevel=" + outcomesLevel + ", age=" + age + ", fullNameCouple=" + fullNameCouple + ", relationName=" + relationName
				+ ", nit=" + nit + ", officeName=" + officeName + ", expirationDate=" + expirationDate + ", descState=" + descState + ", identificationType=" + identificationType
				+ ", califCartera=" + califCartera + ", economicActivity=" + economicActivity + ", clientNumberB=" + clientNumberB + "]";
	}

}
