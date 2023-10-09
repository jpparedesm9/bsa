package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.SolicitudIndividualDTO;

public class SolicitudCreditoIndividualDATABEAN {
	private SolicitudIndividualDTO solicitudIndividual;
	private List<SolicitudIndividualDTO> contenido;

	public SolicitudIndividualDTO getSolicitudIndividual() {
		return solicitudIndividual;
	}

	public void setSolicitudIndividual(SolicitudIndividualDTO solicitudIndividual) {
		this.solicitudIndividual = solicitudIndividual;
	}

	public List<SolicitudIndividualDTO> getContenido() {
		return contenido;
	}

	public void setContenido(List<SolicitudIndividualDTO> contenido) {
		this.contenido = contenido;
	}
}
