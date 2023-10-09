package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class FichaDePagoDTO {

	private FichaDePagoMainPDTO mainParameters;
	private List<FichaDePagoSubDTO> referencias;
	
	public FichaDePagoMainPDTO getMainParameters() {
		return mainParameters;
	}
	
	public void setMainParameters(FichaDePagoMainPDTO mainParameters) {
		this.mainParameters = mainParameters;
	}
	
	public List<FichaDePagoSubDTO> getReferencias() {
		return referencias;
	}
	
	public void setReferencias(List<FichaDePagoSubDTO> referencias) {
		this.referencias = referencias;
	}
	
	@Override
	public String toString() {
		return "FichaDePagoDTO [mainParameters=" + mainParameters + ", referencias=" + referencias + "]";
	}

	
}
