package com.cobiscorp.cobis.loans.reports.dto;

public class BenefitsDeclareDTO {

	private String fullNameBenefits;
	private String relationshipBenefits;
	private String birthdateBenefits;
	private String percentageBenefits;
	private String totalPorcentage;

	/**
	 * Constructor class
	 */
	public BenefitsDeclareDTO() {
		super();
	}

	/**
	 * Constructor class
	 * 
	 * @param fullNameBenefits
	 * @param relationshipBenefits
	 * @param birthdateBenefits
	 * @param percentageBenefits
	 * @param totalPorcentage
	 */
	public BenefitsDeclareDTO(String fullNameBenefits, String relationshipBenefits, String birthdateBenefits,
			String percentageBenefits, String totalPorcentage) {
		super();
		this.fullNameBenefits = fullNameBenefits;
		this.relationshipBenefits = relationshipBenefits;
		this.birthdateBenefits = birthdateBenefits;
		this.percentageBenefits = percentageBenefits;
		this.totalPorcentage = totalPorcentage;
	}

	/**
	 * @return the fullNameBenefits
	 */
	public String getFullNameBenefits() {
		return fullNameBenefits;
	}

	/**
	 * @param fullNameBenefits
	 *            the fullNameBenefits to set
	 */
	public void setFullNameBenefits(String fullNameBenefits) {
		this.fullNameBenefits = fullNameBenefits;
	}

	/**
	 * @return the relationshipBenefits
	 */
	public String getRelationshipBenefits() {
		return relationshipBenefits;
	}

	/**
	 * @param relationshipBenefits
	 *            the relationshipBenefits to set
	 */
	public void setRelationshipBenefits(String relationshipBenefits) {
		this.relationshipBenefits = relationshipBenefits;
	}

	/**
	 * @return the birthdateBenefits
	 */
	public String getBirthdateBenefits() {
		return birthdateBenefits;
	}

	/**
	 * @param birthdateBenefits
	 *            the birthdateBenefits to set
	 */
	public void setBirthdateBenefits(String birthdateBenefits) {
		this.birthdateBenefits = birthdateBenefits;
	}

	/**
	 * @return the percentageBenefits
	 */
	public String getPercentageBenefits() {
		return percentageBenefits;
	}

	/**
	 * @param percentageBenefits
	 *            the percentageBenefits to set
	 */
	public void setPercentageBenefits(String percentageBenefits) {
		this.percentageBenefits = percentageBenefits;
	}

	/**
	 * @return the totalPorcentage
	 */
	public String getTotalPorcentage() {
		return totalPorcentage;
	}

	/**
	 * @param totalPorcentage
	 *            the totalPorcentage to set
	 */
	public void setTotalPorcentage(String totalPorcentage) {
		this.totalPorcentage = totalPorcentage;
	}

}
