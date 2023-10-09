package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.TablaAmortizacionDetalleDTO;

public class TablaAmortizationDATABEAN {

	private List<TablaAmortizacionDetalleDTO> tablaAmortizacion;

	public List<TablaAmortizacionDetalleDTO> getTablaAmortizacion() {
		return tablaAmortizacion;
	}

	public void setTablaAmortizacion(List<TablaAmortizacionDetalleDTO> tablaAmortizacion) {
		this.tablaAmortizacion = tablaAmortizacion;
	}

}