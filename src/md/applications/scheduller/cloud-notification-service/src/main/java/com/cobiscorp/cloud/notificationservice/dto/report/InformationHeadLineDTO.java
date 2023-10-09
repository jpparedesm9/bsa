package com.cobiscorp.cloud.notificationservice.dto.report;

public class InformationHeadLineDTO {

	private String fullName;
	private String birthDate;

	/**
	 * Constructor class
	 */
	public InformationHeadLineDTO() {
		super();
	}

	/**
	 * Constructor class
	 * 
	 * @param fullName
	 * @param birthDate
	 */
	public InformationHeadLineDTO(String fullName, String birthDate) {
		super();
		this.fullName = fullName;
		this.birthDate = birthDate;
	}

	/**
	 * @return the fullName
	 */
	public String getFullName() {
		return fullName;
	}

	/**
	 * @param fullName
	 *            the fullName to set
	 */
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	/**
	 * @return the birthDate
	 */
	public String getBirthDate() {
		return birthDate;
	}

	/**
	 * @param birthDate
	 *            the birthDate to set
	 */
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

}
