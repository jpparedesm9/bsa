package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

import com.cobiscorp.cloud.notificationservice.dto.ReferenciasPreCancelaciones;

public class PrecancelacionDTO {
	ReferenciasPreCancelaciones.PreCancelacion precancelacion;
	List<ReferenciasPreCancelaciones.PreCancelacion.Referencia> referencias;

	
	public PrecancelacionDTO() {
		
	}
	
	public PrecancelacionDTO(ReferenciasPreCancelaciones.PreCancelacion precancelacion, List<ReferenciasPreCancelaciones.PreCancelacion.Referencia> referencias) {
		this.precancelacion = precancelacion;
		this.referencias = referencias;
	}
	public ReferenciasPreCancelaciones.PreCancelacion getPrecancelacion() {
		return precancelacion;
	}

	public void setPrecancelacion(ReferenciasPreCancelaciones.PreCancelacion precancelacion) {
		this.precancelacion = precancelacion;
	}

	public List<ReferenciasPreCancelaciones.PreCancelacion.Referencia> getReferencias() {
		return referencias;
	}

	public void setReferencias(List<ReferenciasPreCancelaciones.PreCancelacion.Referencia> referencias) {
		this.referencias = referencias;
	}

}
