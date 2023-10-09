package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class AsistenciaFunerariaDTO {
	private List<AsistenciaFunerariaDetalleDTO> asistenciaFunerariaDetalle;

	public List<AsistenciaFunerariaDetalleDTO> getAsistenciaFunerariaDetalle() {
		return asistenciaFunerariaDetalle;
	}

	public void setAsistenciaFunerariaDetalle(List<AsistenciaFunerariaDetalleDTO> asistenciaFunerariaDetalle) {
		this.asistenciaFunerariaDetalle = asistenciaFunerariaDetalle;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AsistenciaFunerariaDTO [asistenciaFunerariaDetalle=");
		builder.append(asistenciaFunerariaDetalle);
		builder.append("]");
		return builder.toString();
	}

}