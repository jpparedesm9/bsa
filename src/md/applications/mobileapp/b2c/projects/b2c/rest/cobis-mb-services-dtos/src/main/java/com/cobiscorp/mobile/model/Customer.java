package com.cobiscorp.mobile.model;

import org.codehaus.jackson.annotate.JsonIgnore;

public class Customer {

	@JsonIgnore
	private Integer id;
	private String firstName;
	private String secondName;
	private String lastname;
	private String secondLastname;
	private String birthdate;
	private String birthplace;
	private String gender;
	private String curp;
	private String phoneNumber;
	private String bioIdentificationType;
	private String bioCIC;
	private String bioOCR;
	private String bioEmissionNumber;
	private String bioReaderKey;
	private String bioFingerprint;
	private String account;
	private String buc;
	private String idExpedient;
	private int mode;

	public Customer() {
	}

	public Customer(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getSecondLastname() {
		return secondLastname;
	}

	public void setSecondLastname(String secondLastname) {
		this.secondLastname = secondLastname;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getBirthplace() {
		return birthplace;
	}

	public void setBirthplace(String birthplace) {
		this.birthplace = birthplace;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
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

	public String getBioFingerprint() {
		return bioFingerprint;
	}

	public void setBioFingerprint(String bioFingerprint) {
		this.bioFingerprint = bioFingerprint;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public int getMode() {
		return mode;
	}

	public void setMode(int mode) {
		this.mode = mode;
	}

	public String getBuc() {
		return buc;
	}

	public void setBuc(String buc) {
		this.buc = buc;
	}

	public String getIdExpedient() {
		return idExpedient;
	}

	public void setIdExpedient(String idExpedient) {
		this.idExpedient = idExpedient;
	}

	@Override
	public String toString() {

		StringBuilder sb = new StringBuilder();
		sb.append("Customer [");
		sb.append("id=");
		sb.append(id);
		sb.append(", firstName=");
		sb.append(firstName == null ? "" : firstName);
		sb.append(", secondName=");
		sb.append(secondName == null ? "" : secondName);
		sb.append(", lastname=");
		sb.append(lastname == null ? "" : lastname);
		sb.append(", secondLastname=");
		sb.append(secondLastname == null ? "" : secondLastname);
		sb.append(", birthdate=");
		sb.append(birthdate == null ? "" : birthdate);
		sb.append(", birthplace=");
		sb.append(birthplace == null ? "" : birthplace);
		sb.append(", gender=");
		sb.append(gender == null ? "" : gender);
		sb.append(", curp=");
		sb.append(curp == null ? "" : curp);
		sb.append(", phoneNumber=");
		sb.append(phoneNumber == null ? "" : phoneNumber);
		sb.append(", bioIdentificationType=");
		sb.append(bioIdentificationType == null ? "" : bioIdentificationType);
		sb.append(", bioCIC=");
		sb.append(bioCIC == null ? "" : bioCIC);
		sb.append(", bioOCR=");
		sb.append(bioOCR == null ? "" : bioOCR);
		sb.append(", bioEmissionNumber=");
		sb.append(bioEmissionNumber == null ? "" : bioEmissionNumber);
		sb.append(", bioReaderKey=");
		sb.append(bioReaderKey == null ? "" : bioReaderKey);
		sb.append(", bioFingerprint=");
		sb.append(bioFingerprint == null ? "" : bioFingerprint);
		sb.append(", account=");
		sb.append(account == null ? "" : account);
		sb.append(", mode=");
		sb.append(mode);
		sb.append(", buc=");
		sb.append(buc);
		sb.append(", idExpedient=");
		sb.append(idExpedient);
		sb.append("]");
		return sb.toString();
	}

}
