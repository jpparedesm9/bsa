package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

import com.cobiscorp.cloud.notificationservice.dto.PagoCorresponsal;

public class PagoCorresponsalGrupalDTO {

	private PagoCorresponsal.Grupo grupo;
	private List<PagoCorresponsal.Grupo.Referencia> referencias;
	private List<PagoCorresponsal.Grupo.DetallePagos> detallePagos;

	public PagoCorresponsalGrupalDTO() {
	}

	public PagoCorresponsalGrupalDTO(PagoCorresponsal.Grupo grupo, List<PagoCorresponsal.Grupo.Referencia> referencias) {
		this.grupo = grupo;
		this.referencias = referencias;
	}
	
	public PagoCorresponsalGrupalDTO(PagoCorresponsal.Grupo grupo,List<PagoCorresponsal.Grupo.DetallePagos> detallePagos, List<PagoCorresponsal.Grupo.Referencia> referencias) {
		this.grupo = grupo;
		this.referencias = referencias;
		this.detallePagos=detallePagos;
	}


	public PagoCorresponsal.Grupo getGrupo() {
		return grupo;
	}

	public void setGrupo(PagoCorresponsal.Grupo grupo) {
		this.grupo = grupo;
	}

	public List<PagoCorresponsal.Grupo.Referencia> getReferencias() {
		return referencias;
	}

	public void setReferencias(List<PagoCorresponsal.Grupo.Referencia> referencias) {
		this.referencias = referencias;
	}

	public List<PagoCorresponsal.Grupo.DetallePagos> getDetallePagos() {
		return detallePagos;
	}

	public void setDetallePagos(List<PagoCorresponsal.Grupo.DetallePagos> detallePagos) {
		this.detallePagos = detallePagos;
	}

	

	

	

}
