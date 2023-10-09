package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.EstadoCuentaConsolidadoDTO;

public class EstadoCuentaConsolidadoDATABEAN {

	private List<EstadoCuentaConsolidadoDTO> detalle;

	public List<EstadoCuentaConsolidadoDTO> getDetalle() {
		return detalle;
	}

	public void setDetalle(List<EstadoCuentaConsolidadoDTO> detalle) {
		this.detalle = detalle;
	}

}
