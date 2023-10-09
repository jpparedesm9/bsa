package com.cobiscorp.ecobis.cloud.service.dto.client;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

/**
 * @author Cesar Loachamin
 */
public class CustomerBase {
	private Integer customerId;
	private String firstName;
	private String secondName;
	private String surname;
	private String secondSurname;
	private String birthDate; // calendar
	private String gender;
	private String maritalStatus;
	private String documentType;
	private String documentNumber;
	private Integer cityBirth;
	private String bioIdentificationType;
	private String bioCIC;
	private String bioOCR;
	private String bioEmissionNumber;
	private String bioReaderKey;
	private String bioHasFingerprint;
	private String checkRenapo;
	private String collective;
	private String collectiveClientLevel;
	private String registerYear;
	private String emissionYear;
	private String whichProfession;

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getSecondName() {
		return secondName;
	}

	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getSecondSurname() {
		return secondSurname;
	}

	public void setSecondSurname(String secondSurname) {
		this.secondSurname = secondSurname;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}

	public String getDocumentNumber() {
		return documentNumber;
	}

	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}

	public Integer getCityBirth() {
		return cityBirth;
	}

	public void setCityBirth(Integer cityBirth) {
		this.cityBirth = cityBirth;
	}

	public String getBioIdentificationType() {
		return bioIdentificationType;
	}

	public void setBioIdentificationType(String bioIdentificationType) {
		this.bioIdentificationType = bioIdentificationType;
	}

	public String getBioCIC() {
		return bioCIC;
	}

	public void setBioCIC(String bioCIC) {
		this.bioCIC = bioCIC;
	}

	public String getBioOCR() {
		return bioOCR;
	}

	public void setBioOCR(String bioOCR) {
		this.bioOCR = bioOCR;
	}

	public String getBioEmissionNumber() {
		return bioEmissionNumber;
	}

	public void setBioEmissionNumber(String bioEmissionNumber) {
		this.bioEmissionNumber = bioEmissionNumber;
	}

	public String getBioReaderKey() {
		return bioReaderKey;
	}

	public void setBioReaderKey(String bioReaderKey) {
		this.bioReaderKey = bioReaderKey;
	}

	public String getBioHasFingerprint() {
		return bioHasFingerprint;
	}

	public void setBioHasFingerprint(String bioHasFingerprint) {
		this.bioHasFingerprint = bioHasFingerprint;
	}

	public String getCheckRenapo() {
		return checkRenapo;
	}

	public void setCheckRenapo(String checkRenapo) {
		this.checkRenapo = checkRenapo;
	}

	public String getCollective() {
		return collective;
	}

	public void setCollective(String collective) {
		this.collective = collective;
	}

	public String getCollectiveClientLevel() {
		return collectiveClientLevel;
	}

	public void setCollectiveClientLevel(String collectiveClientLevel) {
		this.collectiveClientLevel = collectiveClientLevel;
	}

	public String getRegisterYear() {
		return registerYear;
	}

	public void setRegisterYear(String registerYear) {
		this.registerYear = registerYear;
	}

	public String getEmissionYear() {
		return emissionYear;
	}

	public void setEmissionYear(String emissionYear) {
		this.emissionYear = emissionYear;
	}

	public String getWhichProfession() {
		return whichProfession;
	}

	public void setWhichProfession(String whichProfession) {
		this.whichProfession = whichProfession;
	}

	public CustomerTotalRequest toRequest() {
		CustomerTotalRequest request = new CustomerTotalRequest();
		request.setCodePerson(customerId);
		request.setName(firstName);
		request.setFirstSurname(surname);
		if (secondName != null && secondName.length() == 0) {
			secondName = "*";
		}
		request.setSecondName(secondName);
		if (secondSurname != null && secondSurname.length() == 0) {
			secondSurname = "*";
		}
		request.setSecondSurname(secondSurname);
		request.setIdentification(documentNumber);
		request.setIdentificationType(documentType);
		request.setGender(gender.charAt(0));
		request.setCountyOfBirth(cityBirth);
		request.setNumCycles(0);
		request.setCivilStatus(maritalStatus);
		request.setBirthDate(CalendarUtil.fromISOTime(birthDate));
		// request.setSubsidiary(SessionUtil.getFilial()); TODO: Fix this
		request.setSubsidiary(1);
		request.setOffice(SessionUtil.getOffice());
		request.setOfficial(3);// TODO: Cesar replace for the real user id
		// request.setOfficial(SessionUtil.getUser());
		request.setBioIdentificationType(getBioIdentificationType());
		request.setBioCIC(getBioCIC());
		request.setBioOCR(getBioOCR());
		request.setBioEmissionNumber(getBioEmissionNumber());
		request.setBioReaderKey(getBioReaderKey());
		request.setBioHasFingerprinter(getBioHasFingerprint());
		request.setCollective(getCollective());
		request.setCollectiveLevel(getCollectiveClientLevel());
		request.setEmissionYear(getEmissionYear());
		request.setRegisterYear(getRegisterYear());
		request.setOtherProfession(getWhichProfession());
		return request;
	}

	protected void fillFromResponse(CustomerResponse response, int customerId) {
		if (response != null) {
			this.setCustomerId(customerId);
			this.setFirstName(response.getCustomerName());
			this.setSecondName(response.getCustomerSecondName());
			this.setSurname(response.getCustomerLastName());
			this.setSecondSurname(response.getCustomerSecondLastName());
			this.setBirthDate(CalendarUtil.toISOTime(response.getCustomerBirthdate()));
			this.setGender(response.getGender() == null ? null : response.getGender().charAt(0) + "");
			this.setMaritalStatus(response.getCustomerMaritalStatus());
			this.setDocumentNumber(response.getCustomerIdentificaction());
			this.setDocumentType(response.getIdentificationtype());
			this.setCityBirth(response.getCountyOfBirth());
			this.setBioIdentificationType(response.getBioIdentificationType());
			this.setBioCIC(response.getBioCIC());
			this.setBioOCR(response.getBioOCR());
			this.setBioEmissionNumber(response.getBioEmissionNumber());
			this.setBioReaderKey(response.getBioReaderKey());
			this.setBioHasFingerprint(response.getBioHasFingerprint());
			this.setCheckRenapo(response.getCheckRenapo());
			this.setCollective(response.getColectivo());
			this.setCollectiveClientLevel(response.getNivelColectivo());
			this.setEmissionYear(response.getEmissionYear() == null ? "0" : response.getEmissionYear());
			this.setRegisterYear(response.getRegisterYear() == null ? "0" : response.getRegisterYear());
			this.setWhichProfession(response.getOtherProfession());
		}
	}

}
