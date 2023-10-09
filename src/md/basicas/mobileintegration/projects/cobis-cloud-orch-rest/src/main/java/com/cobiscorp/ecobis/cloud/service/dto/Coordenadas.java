package com.cobiscorp.ecobis.cloud.service.dto;

public class Coordenadas {
	private int idAddress;
	private double latitude;
	private double logitude;
	
	public Coordenadas() {

	}
	
	public Coordenadas(double latitude, double logitude) {
		super();
		this.latitude = latitude;
		this.logitude = logitude;
	}

	public Coordenadas(int idAddress, double latitude, double logitude) {
		super();
		this.idAddress = idAddress;
		this.latitude = latitude;
		this.logitude = logitude;
	}
	
	public int getIdAddress() {
		return idAddress;
	}

	public void setIdAddress(int idAddress) {
		this.idAddress = idAddress;
	}

	public double getLatitude() {
		return latitude;
	}



	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}



	public double getLogitude() {
		return logitude;
	}



	public void setLogitude(double logitude) {
		this.logitude = logitude;
	}

}
