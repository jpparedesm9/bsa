package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.BenefitsDeclareDTO;
import com.cobiscorp.cobis.loans.reports.dto.BenefitsInformationTableDTO;
import com.cobiscorp.cobis.loans.reports.dto.InformationHeadLineDTO;

public class ConsentOfSegurityDATABEAN {

	private List<InformationHeadLineDTO> listInformationHeadLine;
	private List<BenefitsDeclareDTO> listBenefitsDeclare;
	private List<BenefitsInformationTableDTO> listBenefitsInformationTable;
	private String fullNameP;
	private String eventoMedEsp;
	private String eventoCheckUps;
	private String eventoServDent;
	private String lineaEmbarazo;
	private String lineaDiabetes;
	private String lineaViolencia;
	private String cobertura;
	private String fechaContraAsis;
	private String fechaFinVig;

	/**
	 * constructors
	 */
	public ConsentOfSegurityDATABEAN() {
		super();
	}

	/**
	 * constructors
	 * 
	 * @param listInformationHeadLine
	 * @param listBenefitsDeclare
	 * @param listBenefitsInformationTable
	 */
	public ConsentOfSegurityDATABEAN(List<InformationHeadLineDTO> listInformationHeadLine, List<BenefitsDeclareDTO> listBenefitsDeclare,
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

	public String getEventoMedEsp() {
		return eventoMedEsp;
	}

	public void setEventoMedEsp(String eventoMedEsp) {
		this.eventoMedEsp = eventoMedEsp;
	}

	public String getEventoCheckUps() {
		return eventoCheckUps;
	}

	public void setEventoCheckUps(String eventoCheckUps) {
		this.eventoCheckUps = eventoCheckUps;
	}

	public String getEventoServDent() {
		return eventoServDent;
	}

	public void setEventoServDent(String eventoServDent) {
		this.eventoServDent = eventoServDent;
	}

	public String getLineaEmbarazo() {
		return lineaEmbarazo;
	}

	public void setLineaEmbarazo(String lineaEmbarazo) {
		this.lineaEmbarazo = lineaEmbarazo;
	}

	public String getLineaDiabetes() {
		return lineaDiabetes;
	}

	public void setLineaDiabetes(String lineaDiabetes) {
		this.lineaDiabetes = lineaDiabetes;
	}

	public String getLineaViolencia() {
		return lineaViolencia;
	}

	public void setLineaViolencia(String lineaViolencia) {
		this.lineaViolencia = lineaViolencia;
	}

	public String getCobertura() {
		return cobertura;
	}

	public void setCobertura(String cobertura) {
		this.cobertura = cobertura;
	}

	public String getFechaContraAsis() {
		return fechaContraAsis;
	}

	public void setFechaContraAsis(String fechaContraAsis) {
		this.fechaContraAsis = fechaContraAsis;
	}

	public String getFechaFinVig() {
		return fechaFinVig;
	}

	public void setFechaFinVig(String fechaFinVig) {
		this.fechaFinVig = fechaFinVig;
	}
}
