package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class TAmortSimpleIndAutoOnboardDTO {

	private TAmortSimpleIndAutoOnboardMainPDTO mainParameters;
	private List<TAmortSimpleIndAutoOnboardSubDTO> tablaAmortizacion;

	public TAmortSimpleIndAutoOnboardMainPDTO getMainParameters() {
		return mainParameters;
	}

	public void setMainParameters(TAmortSimpleIndAutoOnboardMainPDTO mainParameters) {
		this.mainParameters = mainParameters;
	}

	public List<TAmortSimpleIndAutoOnboardSubDTO> getTablaAmortizacion() {
		return tablaAmortizacion;
	}

	public void setTablaAmortizacion(List<TAmortSimpleIndAutoOnboardSubDTO> tablaAmortizacion) {
		this.tablaAmortizacion = tablaAmortizacion;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TAmortSimpleIndAutoOnboardDTO [mainParameters=");
		builder.append(mainParameters);
		builder.append(", tablaAmortizacion=");
		builder.append(tablaAmortizacion);
		builder.append("]");
		return builder.toString();
	}

}
