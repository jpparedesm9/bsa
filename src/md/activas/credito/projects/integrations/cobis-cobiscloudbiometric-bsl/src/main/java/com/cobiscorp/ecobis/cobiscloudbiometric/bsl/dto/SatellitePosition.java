package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

public class SatellitePosition {
	private String latitude;
	private String longitude;

	public SatellitePosition() {
	}

	public SatellitePosition(String latitude, String longitude) {
		super();
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

}
