package com.cobiscorp.ecobis.busin.model;

public class RenapoRequest {

	private String birthDate;
	private String birthPlace;
	private String name;
	private String lastName;
	private String secondLastName;
	private String gender;

	private String channel;
	private String branch;
	private String transactionType;
	private String transactionId;
	private String curp;

	public RenapoRequest() {
	}

	public RenapoRequest(String birthDate, String birthPlace, String name, String lastName, String secondLastName,
			String gender) {
		super();
		this.birthDate = birthDate;
		this.birthPlace = birthPlace;
		this.name = name;
		this.lastName = lastName;
		this.secondLastName = secondLastName;
		this.gender = gender;
	}
	
	public RenapoRequest(String channel, String branch, String transactionType, String transactionId, String curp) {
		super();
		this.channel = channel;
		this.branch = branch;
		this.transactionType = transactionType;
		this.transactionId = transactionId;
		this.curp = curp;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getBirthPlace() {
		return birthPlace;
	}

	public void setBirthPlace(String birthPlace) {
		this.birthPlace = birthPlace;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getSecondLastName() {
		return secondLastName;
	}

	public void setSecondLastName(String secondLastName) {
		this.secondLastName = secondLastName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	@Override
	public String toString() {
		return "RenapoRequest [birthDate=" + birthDate + ", birthPlace=" + birthPlace + ", name=" + name + ", lastName="
				+ lastName + ", secondLastName=" + secondLastName + ", gender=" + gender + ", channel=" + channel
				+ ", branch=" + branch + ", transactionType=" + transactionType + ", transactionId=" + transactionId
				+ ", curp=" + curp + "]";
	}

}
