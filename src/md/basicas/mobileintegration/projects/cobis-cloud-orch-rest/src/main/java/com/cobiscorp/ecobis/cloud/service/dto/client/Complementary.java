package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

public class Complementary {

	private final static ILogger logger = LogFactory.getLogger(Complementary.class);
	
	private String passport;
	private int codePerson;
	private String phoneMessage;
	private String ifeNumber;
	private String serialNumberSignatureElect;
	private String personMessage;
	private String buroAntecedent;
	private String landlineOne;
	private String hasCryptocurrencies;
	private String professionalActivity;

	public Complementary() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Complementary(String passport, int codePerson, String phoneMessage,
			String ifeNumber, String serialNumberSignatureElect,
			String personMessage, String buroAntecedent, String landlineOne) {
		super();
		this.passport = passport;
		this.codePerson = codePerson;
		this.phoneMessage = phoneMessage;
		this.ifeNumber = ifeNumber;
		this.serialNumberSignatureElect = serialNumberSignatureElect;
		this.personMessage = personMessage;
		this.buroAntecedent = buroAntecedent;
		this.landlineOne = landlineOne;
	}

	public static Complementary fromResponse(CustomerResponse response) {
		logger.logInfo("/cobis-cloud/mobile/client/readComplementaryData IsCryptoUsed=>" + response.getIsCryptoUsed());
		logger.logInfo("/cobis-cloud/mobile/client/readComplementaryData ProfessionalActivity=>" + response.getIsCryptoUsed());
		Complementary obj = new Complementary();
		obj.setPassport(response.getCustomerPassport());
		obj.setCodePerson(response.getCustomerId());
		obj.setPhoneMessage(response.getPhoneErrands());
		obj.setIfeNumber(response.getIfeNumber());
		obj.setSerialNumberSignatureElect(response.getElectronicSignature());
		obj.setPersonMessage(response.getPersonNameMessages());
		obj.setBuroAntecedent(response.getBureauBackground());
		obj.setLandlineOne(response.getLandlineOne());
		obj.setHasCryptocurrencies(response.getIsCryptoUsed());
		obj.setProfessionalActivity(response.getProfessionalActivity());
		return obj;
	}

	public CustomerTotalRequest toRequest() {
		CustomerTotalRequest request = new CustomerTotalRequest();
		request.setPassport(passport);
		request.setCodePerson(codePerson);
		request.setPhoneErrands(phoneMessage);
		request.setIfeNumber(ifeNumber);
		request.setElectronicSignature(serialNumberSignatureElect);
		request.setPersonNameMessages(personMessage);
		request.setBureauBackground(buroAntecedent);
		request.setLandlineOne(landlineOne);
		request.setIsCryptoUsed(hasCryptocurrencies);
		request.setProfessionalActivity(professionalActivity);

		return request;
	}

	public String getPassport() {
		return passport;
	}

	public void setPassport(String passport) {
		this.passport = passport;
	}

	public int getCodePerson() {
		return codePerson;
	}

	public void setCodePerson(int codePerson) {
		this.codePerson = codePerson;
	}

	public String getPhoneMessage() {
		return phoneMessage;
	}

	public void setPhoneMessage(String phoneMessage) {
		this.phoneMessage = phoneMessage;
	}

	public String getIfeNumber() {
		return ifeNumber;
	}

	public void setIfeNumber(String ifeNumber) {
		this.ifeNumber = ifeNumber;
	}

	public String getSerialNumberSignatureElect() {
		return serialNumberSignatureElect;
	}

	public void setSerialNumberSignatureElect(String serialNumberSignatureElect) {
		this.serialNumberSignatureElect = serialNumberSignatureElect;
	}

	public String getPersonMessage() {
		return personMessage;
	}

	public void setPersonMessage(String personMessage) {
		this.personMessage = personMessage;
	}

	public String getBuroAntecedent() {
		return buroAntecedent;
	}

	public void setBuroAntecedent(String buroAntecedent) {
		this.buroAntecedent = buroAntecedent;
	}

	public String getLandlineOne() {
		return landlineOne;
	}

	public void setLandlineOne(String landlineOne) {
		this.landlineOne = landlineOne;
	}

	public String getHasCryptocurrencies() {
		return hasCryptocurrencies;
	}

	public void setHasCryptocurrencies(String hasCryptocurrencies) {
		this.hasCryptocurrencies = hasCryptocurrencies;
	}

	public String getProfessionalActivity() {
		return professionalActivity;
	}

	public void setProfessionalActivity(String professionalActivity) {
		this.professionalActivity = professionalActivity;
	}

}
