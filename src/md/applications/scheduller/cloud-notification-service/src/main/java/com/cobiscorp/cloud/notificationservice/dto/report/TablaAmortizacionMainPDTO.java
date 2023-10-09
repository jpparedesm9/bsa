package com.cobiscorp.cloud.notificationservice.dto.report;

public class TablaAmortizacionMainPDTO {

	private String nombreGrupo;
	private String fechaDesembolso;
	private String fechaLiquidacion;
	private String fechaContrato;
	private String condusef;
	private String pieAnio;

	private String numContrato;

	public String getNumContrato() {
		return numContrato;
	}

	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}

	public String getNombreGrupo() {
		return nombreGrupo;
	}

	public void setNombreGrupo(String nombreGrupo) {
		this.nombreGrupo = nombreGrupo;
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

	public String getFechaContrato() {
		return fechaContrato;
	}

	public void setFechaContrato(String fechaContrato) {
		this.fechaContrato = fechaContrato;
	}

	public String getCondusef() {
		return condusef;
	}

	public void setCondusef(String condusef) {
		this.condusef = condusef;
	}

	public String getPieAnio() {
		return pieAnio;
	}

	public void setPieAnio(String pieAnio) {
		this.pieAnio = pieAnio;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TablaAmortizacionMainPDTO [nombreGrupo=");
		builder.append(getNombreGrupo());
		builder.append(", fechaDesembolso=");
		builder.append(getFechaDesembolso());
		builder.append(", fechaLiquidacion=");
		builder.append(getFechaLiquidacion());
		builder.append(", fechaContrato=");
		builder.append(getFechaContrato());
		builder.append(", condusef=");
		builder.append(getCondusef());
		builder.append(", pieAnio=");
		builder.append(getPieAnio());
		builder.append("]");
		return builder.toString();
	}

}
