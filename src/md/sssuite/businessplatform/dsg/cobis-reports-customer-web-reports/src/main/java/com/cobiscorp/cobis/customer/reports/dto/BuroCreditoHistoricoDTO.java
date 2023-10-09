package com.cobiscorp.cobis.customer.reports.dto;

import java.util.List;

public class BuroCreditoHistoricoDTO {

	private List<BuroCreditoHistoricoDTODom> domicilios;
	private List<BuroCreditoHistoricoDTOEmp> domicilioEmpleo;
	private List<BuroCreditoHistoricoDTODetCreditos> detCreditos;
	private List<BuroCreditoHistoricoDTOResumenCredito> resumenCredito;
	private List<BuroCreditoHistoricoDTODetConsultas> detConsultas;
	private List<BuroCreditoHistoricoDTOScoreBuro> scoreBuroCredito;

	public List<BuroCreditoHistoricoDTODom> getDomicilios() {
		return domicilios;
	}

	public void setDomicilios(List<BuroCreditoHistoricoDTODom> domicilios) {
		this.domicilios = domicilios;
	}

	public List<BuroCreditoHistoricoDTOEmp> getDomicilioEmpleo() {
		return domicilioEmpleo;
	}

	public void setDomicilioEmpleo(List<BuroCreditoHistoricoDTOEmp> domicilioEmpleo) {
		this.domicilioEmpleo = domicilioEmpleo;
	}

	public List<BuroCreditoHistoricoDTODetCreditos> getDetCreditos() {
		return detCreditos;
	}

	public void setDetCreditos(List<BuroCreditoHistoricoDTODetCreditos> detCreditos) {
		this.detCreditos = detCreditos;
	}

	public List<BuroCreditoHistoricoDTOResumenCredito> getResumenCredito() {
		return resumenCredito;
	}

	public void setResumenCredito(List<BuroCreditoHistoricoDTOResumenCredito> resumenCredito) {
		this.resumenCredito = resumenCredito;
	}

	public List<BuroCreditoHistoricoDTODetConsultas> getDetConsultas() {
		return detConsultas;
	}

	public void setDetConsultas(List<BuroCreditoHistoricoDTODetConsultas> detConsultas) {
		this.detConsultas = detConsultas;
	}

	public List<BuroCreditoHistoricoDTOScoreBuro> getScoreBuroCredito() {
		return scoreBuroCredito;
	}

	public void setScoreBuroCredito(List<BuroCreditoHistoricoDTOScoreBuro> scoreBuroCredito) {
		this.scoreBuroCredito = scoreBuroCredito;
	}

}
