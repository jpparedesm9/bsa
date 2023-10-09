package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.BenefitsDeclareDTO;
import com.cobiscorp.cobis.loans.reports.dto.BenefitsInformationTableDTO;
import com.cobiscorp.cobis.loans.reports.dto.InformationHeadLineDTO;

public class ConsentOfSegurityMedicalDATABEAN {

	private List<InformationHeadLineDTO> listInformationHeadLineMedical;
	private List<BenefitsDeclareDTO> listBenefitsDeclareMedical;
	private List<BenefitsInformationTableDTO> listBenefitsInformationTableMedical;

	/**
	 * constructors
	 */
	public ConsentOfSegurityMedicalDATABEAN() {
		super();
	}

	/**
	 * constructors
	 * 
	 * @param listInformationHeadLineMedical
	 * @param listBenefitsDeclareMedical
	 * @param listBenefitsInformationTableMedical
	 */
	public ConsentOfSegurityMedicalDATABEAN(List<InformationHeadLineDTO> listInformationHeadLineMedical,
			List<BenefitsDeclareDTO> listBenefitsDeclareMedical,
			List<BenefitsInformationTableDTO> listBenefitsInformationTableMedical) {
		super();
		this.listInformationHeadLineMedical = listInformationHeadLineMedical;
		this.listBenefitsDeclareMedical = listBenefitsDeclareMedical;
		this.listBenefitsInformationTableMedical = listBenefitsInformationTableMedical;
	}

	/**
	 * @return the listInformationHeadLineMedical
	 */
	public List<InformationHeadLineDTO> getListInformationHeadLineMedical() {
		return listInformationHeadLineMedical;
	}

	/**
	 * @param listInformationHeadLineMedical
	 *            the listInformationHeadLineMedical to set
	 */
	public void setListInformationHeadLineMedical(List<InformationHeadLineDTO> listInformationHeadLineMedical) {
		this.listInformationHeadLineMedical = listInformationHeadLineMedical;
	}

	/**
	 * @return the listBenefitsDeclareMedical
	 */
	public List<BenefitsDeclareDTO> getListBenefitsDeclareMedical() {
		return listBenefitsDeclareMedical;
	}

	/**
	 * @param listBenefitsDeclareMedical
	 *            the listBenefitsDeclareMedical to set
	 */
	public void setListBenefitsDeclareMedical(List<BenefitsDeclareDTO> listBenefitsDeclareMedical) {
		this.listBenefitsDeclareMedical = listBenefitsDeclareMedical;
	}

	/**
	 * @return the listBenefitsInformationTableMedical
	 */
	public List<BenefitsInformationTableDTO> getListBenefitsInformationTableMedical() {
		return listBenefitsInformationTableMedical;
	}

	/**
	 * @param listBenefitsInformationTableMedical
	 *            the listBenefitsInformationTableMedical to set
	 */
	public void setListBenefitsInformationTableMedical(
			List<BenefitsInformationTableDTO> listBenefitsInformationTableMedical) {
		this.listBenefitsInformationTableMedical = listBenefitsInformationTableMedical;
	}

}
