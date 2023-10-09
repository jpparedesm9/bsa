package com.cobiscorp.cobis.loans.reports.dto;

public class BenefitsInformationTableDTO {

	private String coverageBenefitstable;
	private String titleBenefitstable;
	private String pairBenefitstable;
	private String sonBenefitstable;
	private boolean colorBenefitsTable;

	/**
	 * constructor class
	 */
	public BenefitsInformationTableDTO() {
		super();
	}

	/**
	 * constructor class
	 * 
	 * @param coverageBenefitstable
	 * @param titleBenefitstable
	 * @param pairBenefitstable
	 * @param sonBenefitstable
	 * @param colorBenefitsTable
	 */
	public BenefitsInformationTableDTO(String coverageBenefitstable, String titleBenefitstable,
			String pairBenefitstable, String sonBenefitstable, boolean colorBenefitsTable) {
		super();
		this.coverageBenefitstable = coverageBenefitstable;
		this.titleBenefitstable = titleBenefitstable;
		this.pairBenefitstable = pairBenefitstable;
		this.sonBenefitstable = sonBenefitstable;
		this.colorBenefitsTable = colorBenefitsTable;
	}

	/**
	 * @return the coverageBenefitstable
	 */
	public String getCoverageBenefitstable() {
		return coverageBenefitstable;
	}

	/**
	 * @param coverageBenefitstable
	 *            the coverageBenefitstable to set
	 */
	public void setCoverageBenefitstable(String coverageBenefitstable) {
		this.coverageBenefitstable = coverageBenefitstable;
	}

	/**
	 * @return the titleBenefitstable
	 */
	public String getTitleBenefitstable() {
		return titleBenefitstable;
	}

	/**
	 * @param titleBenefitstable
	 *            the titleBenefitstable to set
	 */
	public void setTitleBenefitstable(String titleBenefitstable) {
		this.titleBenefitstable = titleBenefitstable;
	}

	/**
	 * @return the pairBenefitstable
	 */
	public String getPairBenefitstable() {
		return pairBenefitstable;
	}

	/**
	 * @param pairBenefitstable
	 *            the pairBenefitstable to set
	 */
	public void setPairBenefitstable(String pairBenefitstable) {
		this.pairBenefitstable = pairBenefitstable;
	}

	/**
	 * @return the sonBenefitstable
	 */
	public String getSonBenefitstable() {
		return sonBenefitstable;
	}

	/**
	 * @param sonBenefitstable
	 *            the sonBenefitstable to set
	 */
	public void setSonBenefitstable(String sonBenefitstable) {
		this.sonBenefitstable = sonBenefitstable;
	}

	/**
	 * @return the colorBenefitsTable
	 */
	public boolean isColorBenefitsTable() {
		return colorBenefitsTable;
	}

	/**
	 * @param colorBenefitsTable
	 *            the colorBenefitsTable to set
	 */
	public void setColorBenefitsTable(boolean colorBenefitsTable) {
		this.colorBenefitsTable = colorBenefitsTable;
	}

}
