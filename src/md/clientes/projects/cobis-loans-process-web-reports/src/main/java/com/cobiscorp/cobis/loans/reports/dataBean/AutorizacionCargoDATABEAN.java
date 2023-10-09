package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.AutorizacionCargoDetalleDTO;

public class AutorizacionCargoDATABEAN {

	private List<AutorizacionCargoDetalleDTO> autorizacionCargoDetalle;

	public List<AutorizacionCargoDetalleDTO> getAutorizacionCargoDetalle() {
		return autorizacionCargoDetalle;
	}

	public void setAutorizacionCargoDetalle(List<AutorizacionCargoDetalleDTO> autorizacionCargoDetalle) {
		this.autorizacionCargoDetalle = autorizacionCargoDetalle;
	}

}