package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class ConsentOfSegurityDTO {

	private List<InformationHeadLineDTO> listInformationHeadLine;
	private List<BenefitsDeclareDTO> listBenefitsDeclare;
	private List<BenefitsInformationTableDTO> listBenefitsInformationTable;
	private String fullNameP;

	/**
	 * constructors
	 */
	public ConsentOfSegurityDTO() {
		super();
	}

	/**
	 * constructors
	 * 
	 * @param listInformationHeadLine
	 * @param listBenefitsDeclare
	 * @param listBenefitsInformationTable
	 */
	public ConsentOfSegurityDTO(List<InformationHeadLineDTO> listInformationHeadLine, List<BenefitsDeclareDTO> listBenefitsDeclare,
			List<BenefitsInformationTableDTO> listBenefitsInformationTable, String fullNameP) {
		super();
		this.listInformationHeadLine = listInformationHeadLine;
		this.listBenefitsDeclare = listBenefitsDeclare;
		this.listBenefitsInformationTable = listBenefitsInformationTable;
		this.fullNameP = fullNameP;
	}

	/**
	 * @return the listInformationHeadLine
	 */
	public List<InformationHeadLineDTO> getListInformationHeadLine() {
		return listInformationHeadLine;
	}

	/**
	 * @param listInformationHeadLine the listInformationHeadLine to set
	 */
	public void setListInformationHeadLine(List<InformationHeadLineDTO> listInformationHeadLine) {
		this.listInformationHeadLine = listInformationHeadLine;
	}

	/**
	 * @return the listBenefitsDeclare
	 */
	public List<BenefitsDeclareDTO> getListBenefitsDeclare() {
		return listBenefitsDeclare;
	}

	/**
	 * @param listBenefitsDeclare the listBenefitsDeclare to set
	 */
	public void setListBenefitsDeclare(List<BenefitsDeclareDTO> listBenefitsDeclare) {
		this.listBenefitsDeclare = listBenefitsDeclare;
	}

	/**
	 * @return the listBenefitsInformationTable
	 */
	public List<BenefitsInformationTableDTO> getListBenefitsInformationTable() {
		return listBenefitsInformationTable;
	}

	/**
	 * @param listBenefitsInformationTable the listBenefitsInformationTable to set
	 */
	public void setListBenefitsInformationTable(List<BenefitsInformationTableDTO> listBenefitsInformationTable) {
		this.listBenefitsInformationTable = listBenefitsInformationTable;
	}

	public String getFullNameP() {
		return fullNameP;
	}

	public void setFullNameP(String fullNameP) {
		this.fullNameP = fullNameP;
	}

}
