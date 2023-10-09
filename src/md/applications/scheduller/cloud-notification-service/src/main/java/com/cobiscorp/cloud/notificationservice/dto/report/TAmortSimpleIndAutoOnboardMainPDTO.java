package com.cobiscorp.cloud.notificationservice.dto.report;

public class TAmortSimpleIndAutoOnboardMainPDTO {

	private String clienteNombre;
	private String fechaDesembolso;
	private String fechaLiquidacion;
	private String periodicidad;
	private String numeroTramite;
	private String condusef;
	private String footParam;

	public String getClienteNombre() {
		return clienteNombre;
	}

	public void setClienteNombre(String clienteNombre) {
		this.clienteNombre = clienteNombre;
	}

	public String getFechaDesembolso() {
		return fechaDesembolso;
	}

	public void setFechaDesembolso(String fechaDesembolso) {
		this.fechaDesembolso = fechaDesembolso;
	}

	public String getFechaLiquidacion() {
		return fechaLiquidacion;
	}

	public void setFechaLiquidacion(String fechaLiquidacion) {
		this.fechaLiquidacion = fechaLiquidacion;
	}

	public String getPeriodicidad() {
		return periodicidad;
	}

	public void setPeriodicidad(String periodicidad) {
		this.periodicidad = periodicidad;
	}

	public String getNumeroTramite() {
		return numeroTramite;
	}

	public void setNumeroTramite(String numeroTramite) {
		this.numeroTramite = numeroTramite;
	}

	public String getCondusef() {
		return condusef;
	}

	public void setCondusef(String condusef) {
		this.condusef = condusef;
	}

	public String getFootParam() {
		return footParam;
	}

	public void setFootParam(String footParam) {
		this.footParam = footParam;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TAmortSimpleIndAutoOnboardMainPDTO [clienteNombre=");
		builder.append(clienteNombre);
		builder.append(", fechaDesembolso=");
		builder.append(fechaDesembolso);
		builder.append(", fechaLiquidacion=");
		builder.append(fechaLiquidacion);
		builder.append(", periodicidad=");
		builder.append(periodicidad);
		builder.append(", numeroTramite=");
		builder.append(numeroTramite);
		builder.append(", condusef=");
		builder.append(condusef);
		builder.append(", footParam=");
		builder.append(footParam);
		builder.append("]");
		return builder.toString();
	}

}
