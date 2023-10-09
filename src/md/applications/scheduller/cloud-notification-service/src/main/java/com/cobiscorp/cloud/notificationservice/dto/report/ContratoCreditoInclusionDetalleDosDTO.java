package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class ContratoCreditoInclusionDetalleDosDTO {

	private List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion;
	private List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacionMontos;
	private String lugarPago;
	private String documento;

	public List<ContratoCreditoInclusionDetalleDosDatosOpDTO> getDatosOperacion() {
		return datosOperacion;
	}

	public void setDatosOperacion(List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion) {
		this.datosOperacion = datosOperacion;
	}

	public String getLugarPago() {
		return lugarPago;
	}

	public void setLugarPago(String lugarPago) {
		this.lugarPago = lugarPago;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public List<ContratoCreditoInclusionDetalleDosDatosOpDTO> getDatosOperacionMontos() {
		return datosOperacionMontos;
	}

	public void setDatosOperacionMontos(List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacionMontos) {
		this.datosOperacionMontos = datosOperacionMontos;
	}

}