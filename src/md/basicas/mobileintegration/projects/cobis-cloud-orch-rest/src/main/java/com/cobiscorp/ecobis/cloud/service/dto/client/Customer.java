package com.cobiscorp.ecobis.cloud.service.dto.client;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

import java.math.BigDecimal;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.Prospect;

/**
 * @author Cesar Loachamin
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class Customer extends CustomerBase {

	private static ILogger logger = LogFactory.getLogger(Customer.class);

	private static final String YES_STRING = "S";
	private static final String NO_STRING = "N";
	private Integer countryOfBirth;
	private Integer nationality;
	private String education;
	private String profession;
	private Integer numberOfDependents;
	private String rfc;
	private boolean hasOtherIncome;
	private String otherIncomeSource;
	private BigDecimal otherIncome;
	private int numberOfCycles;
	private boolean personPep;
	private String pepRelationship;
	private String technicalLevel;
	@XmlElement(name = "bankCode")
	private String bankCode;
	@XmlElement(name = "bankAccount")
	private String bankAccount;
	@XmlElement(name = "riskBureau")
	private String riskBureau;
	private String emailAddress;

	@Override
	public CustomerTotalRequest toRequest() {
		CustomerTotalRequest request = super.toRequest();
		toRequest(request);
		return request;
	}

	public Prospect toProspect() {
		Prospect obj = new Prospect();
		obj.setCustomerId(getCustomerId());
		obj.setFirstName(getFirstName());
		obj.setSecondName(getSecondName());
		obj.setSurname(getSurname());
		obj.setSecondSurname(getSecondSurname());
		obj.setBirthDate(getBirthDate());
		obj.setGender(getGender().charAt(0) + "");
		obj.setMaritalStatus(getMaritalStatus());
		obj.setDocumentNumber(getDocumentNumber());
		obj.setDocumentType(getDocumentType());
		obj.setCityBirth(getCityBirth());
		obj.setCollective(getCollective());
		obj.setCollectiveClientLevel(getCollectiveClientLevel());
		return obj;
	}

	public static Customer fromResponse(CustomerResponse response, int customerId) {
		if (response == null) {
			return null;
		}
		Customer obj = new Customer();
		obj.fillFromResponse(response, customerId);
		obj.countryOfBirth = response.getCountryCode();
		obj.nationality = response.getNationalityCodeAux();
		obj.education = response.getAcademicLevel();
		obj.profession = response.getProfession();
		obj.numberOfDependents = response.getDependentsNum();
		obj.rfc = response.getCustomerRFC();
		obj.hasOtherIncome = YES_STRING.equals(response.getHasOtherIncome());
		obj.numberOfCycles = response.getNumCycles();
		obj.pepRelationship = response.getRelChargePub();
		obj.otherIncomeSource = response.getOtherIncomeSource();
		obj.technicalLevel = isNullOrEmpty(response.getTechnologicalDegree()) ? null : response.getTechnologicalDegree().trim();
		logger.logDebug("response.getPublicPerson()" + response.getPublicPerson());
		logger.logDebug("response.getPepPerson()" + response.getPepPerson());
		obj.personPep = YES_STRING.equals(response.getPublicPerson());
		obj.bankCode = response.getSantanderCode();
		obj.bankAccount = response.getAccountIndividual();
		
		return obj;
	}

	public CustomerTotalRequest toRequest(CustomerTotalRequest request) {
		request.setCodePerson(getCustomerId());
		request.setCountryCode(countryOfBirth);
		request.setNationalityCodeAux(nationality);
		request.setLevelStudy(education);
		request.setProfession(profession);
		request.setDependents(numberOfDependents);
		request.setCustomerRFC(rfc);
		request.setHasOtherIncome(hasOtherIncome ? YES_STRING : NO_STRING);
		request.setSales(otherIncome);// other income from Satiango mosquera Otros Ingresos--> sales
		request.setNumCycles(numberOfCycles);
		request.setPersonPEP(personPep ? YES_STRING : NO_STRING);
		request.setRelChargePub(pepRelationship);
		request.setOtherIncomeSource(otherIncomeSource); // cambos pxsg
		request.setSantanderCode(bankCode);
		request.setAccountIndividual(bankAccount);
		request.setCollective(getCollective());
		request.setCollectiveLevel(getCollectiveClientLevel());
		logger.logDebug("request.getSantanderCode()...111" + request.getSantanderCode());
		logger.logDebug("request.getAccountIndividual()...111" + request.getAccountIndividual());

		return request;
	}

	public Integer getCountryOfBirth() {
		return countryOfBirth;
	}

	public void setCountryOfBirth(Integer countryOfBirth) {
		this.countryOfBirth = countryOfBirth;
	}

	public Integer getNationality() {
		return nationality;
	}

	public void setNationality(Integer nationality) {
		this.nationality = nationality;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public Integer getNumberOfDependents() {
		return numberOfDependents;
	}

	public void setNumberOfDependents(Integer numberOfDependents) {
		this.numberOfDependents = numberOfDependents;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public boolean isHasOtherIncome() {
		return hasOtherIncome;
	}

	public void setHasOtherIncome(boolean hasOtherIncome) {
		this.hasOtherIncome = hasOtherIncome;
	}

	public BigDecimal getOtherIncome() {
		return otherIncome;
	}

	public void setOtherIncome(BigDecimal otherIncome) {
		this.otherIncome = otherIncome;
	}

	public int getNumberOfCycles() {
		return numberOfCycles;
	}

	public void setNumberOfCycles(int numberOfCycles) {
		this.numberOfCycles = numberOfCycles;
	}

	public boolean isPersonPep() {
		return personPep;
	}

	public void setPersonPep(boolean personPep) {
		this.personPep = personPep;
	}

	public String getPepRelationship() {
		return pepRelationship;
	}

	public void setPepRelationship(String pepRelationship) {
		this.pepRelationship = pepRelationship;
	}

	public String getOtherIncomeSource() {
		return otherIncomeSource;
	}

	public void setOtherIncomeSource(String otherIncomeSource) {
		this.otherIncomeSource = otherIncomeSource;
	}

	public String getTechnicalLevel() {
		return technicalLevel;
	}

	public String getBankCode() {
		return bankCode;
	}

	public String getRiskBureau() {
		return riskBureau;
	}

	public void setRiskBureau(String riskBureau) {
		this.riskBureau = riskBureau;
	}

	public String getBankAccount() {
		return bankAccount;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public void updateFromInfo(CustomerResponse response) {
		logger.logDebug("response.getPublicPerson()" + response.getPublicPerson());
		logger.logDebug("response.getPepPerson()" + response.getPepPerson());
		personPep = YES_STRING.equals(response.getPublicPerson());
		otherIncome = new BigDecimal(response.getSales());// other income from Satiango mosquera Otros Ingresos--> sales
	}

}
