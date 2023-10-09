package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

import com.cobiscorp.cloud.notificationservice.dto.VencimientosProxCuota;
import com.cobiscorp.cloud.notificationservice.dto.VencimientosProxCuota.Prestamos;
import com.cobiscorp.cloud.notificationservice.dto.VencimientosProxCuota.Prestamos.Referencia;

public class VencimientosProxCuotaDTO {
	private VencimientosProxCuota.Prestamos prestamo;
	private List<VencimientosProxCuota.Prestamos.Referencia> referencias;

	public VencimientosProxCuotaDTO() {

	}

	public VencimientosProxCuotaDTO(Prestamos prestamo, List<Referencia> referencias) {
		super();
		this.prestamo = prestamo;
		this.referencias = referencias;
	}

	public VencimientosProxCuota.Prestamos getPrestamo() {
		return prestamo;
	}

	public void setPrestamo(VencimientosProxCuota.Prestamos prestamo) {
		this.prestamo = prestamo;
	}

	public List<VencimientosProxCuota.Prestamos.Referencia> getReferencias() {
		return referencias;
	}

	public void setReferencias(List<VencimientosProxCuota.Prestamos.Referencia> referencias) {
		this.referencias = referencias;
	}

}
