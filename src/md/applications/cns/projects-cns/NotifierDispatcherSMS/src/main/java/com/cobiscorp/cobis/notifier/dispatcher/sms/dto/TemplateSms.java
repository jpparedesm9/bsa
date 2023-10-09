package com.cobiscorp.cobis.notifier.dispatcher.sms.dto;

public class TemplateSms {

	private String plantilla;
	private int vendor;
	private int evento;
	private int notificacion;
	private String buc;

	public String getPlantilla() {
		return plantilla;
	}

	public void setPlantilla(String plantilla) {
		this.plantilla = plantilla;
	}

	public int getVendor() {
		return vendor;
	}

	public void setVendor(int vendor) {
		this.vendor = vendor;
	}

	public int getEvento() {
		return evento;
	}

	public void setEvento(int evento) {
		this.evento = evento;
	}

	public int getNotificacion() {
		return notificacion;
	}

	public void setNotificacion(int notificacion) {
		this.notificacion = notificacion;
	}

	public String getBuc() {
		return buc;
	}

	public void setBuc(String buc) {
		this.buc = buc;
	}

	@Override
	public String toString() {
		return "TemplateSms [plantilla=" + plantilla + ", vendor=" + vendor + ", evento=" + evento + ", notificacion=" + notificacion + ", buc=" + buc + "]";
	}

}
