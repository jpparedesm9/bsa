package com.cobiscorp.cloud.notificationservice.dto.report;

public class TraspasoReport {
	
	public TraspasoReport(String nombre, String entes, String esgrupo, String razon_rechazo, String oficial_niega, String fecha) {
		this.nombre = nombre;
		this.entes = entes;
		this.esgrupo = esgrupo;
		this.razon_rechazo = razon_rechazo;
		this.oficial_niega = oficial_niega;
		this.fecha = fecha;
	}
	
	public String nombre;
	public String entes;
	public String esgrupo;
	public String razon_rechazo;
	public String oficial_niega;
	public String fecha;

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getEntes() {
		return entes;
	}

	public void setEntes(String entes) {
		this.entes = entes;
	}

	public String getEsgrupo() {
		return esgrupo;
	}

	public void setEsgrupo(String esgrupo) {
		this.esgrupo = esgrupo;
	}

	public String getRazon_rechazo() {
		return razon_rechazo;
	}

	public void setRazon_rechazo(String razon_rechazo) {
		this.razon_rechazo = razon_rechazo;
	}

	public String getOficial_niega() {
		return oficial_niega;
	}

	public void setOficial_niega(String oficial_niega) {
		this.oficial_niega = oficial_niega;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
}
