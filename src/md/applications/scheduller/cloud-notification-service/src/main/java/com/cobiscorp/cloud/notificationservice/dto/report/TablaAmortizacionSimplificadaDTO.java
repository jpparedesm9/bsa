package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class TablaAmortizacionSimplificadaDTO {

	private TablaAmortizacionMainPDTO mainParameters;
	private List<TablaAmortizacionDetalleDTO> tablaAmortizacion;

	public TablaAmortizacionMainPDTO getMainParameters() {
		return mainParameters;
	}

	public void setMainParameters(TablaAmortizacionMainPDTO mainParameters) {
		this.mainParameters = mainParameters;
	}

	public List<TablaAmortizacionDetalleDTO> getTablaAmortizacion() {
		return tablaAmortizacion;
	}

	public void setTablaAmortizacion(List<TablaAmortizacionDetalleDTO> tablaAmortizacion) {
		this.tablaAmortizacion = tablaAmortizacion;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TablaAmortizacionSimplificadaDTO [mainParameters=");
		builder.append(mainParameters);
		builder.append(", tablaAmortizacion=");
		builder.append(tablaAmortizacion);
		builder.append("]");
		return builder.toString();
	}
}