package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

import com.cobiscorp.cloud.notificationservice.dto.VencimientosCuotas;

public class PagoCorresponsalIndividualDTO {
	private VencimientosCuotas.Prestamos prestamo;
	private List<VencimientosCuotas.Prestamos.Referencia> referencias;

	public PagoCorresponsalIndividualDTO() {

	}

	public PagoCorresponsalIndividualDTO(VencimientosCuotas.Prestamos prestamo,
			List<VencimientosCuotas.Prestamos.Referencia> referencias) {
		this.prestamo = prestamo;
		this.referencias = referencias;
	}

	public VencimientosCuotas.Prestamos getPrestamo() {
		return prestamo;
	}

	public void setPrestamo(VencimientosCuotas.Prestamos prestamo) {
		this.prestamo = prestamo;
	}

	public List<VencimientosCuotas.Prestamos.Referencia> getReferencias() {
		return referencias;
	}

	public void setReferencias(List<VencimientosCuotas.Prestamos.Referencia> referencias) {
		this.referencias = referencias;
	}

}
