package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoRevolventeDTO;

public class SolicitudCreditoRevolventeDATABEAN {
	private List<SolicitudCreditoRevolventeDTO> contenido;

	public List<SolicitudCreditoRevolventeDTO> getContenido() {
		return contenido;
	}

	public void setContenido(List<SolicitudCreditoRevolventeDTO> contenido) {
		this.contenido = contenido;
	}
}
