package com.cobiscorp.mobile.model;

import org.codehaus.jackson.annotate.JsonIgnore;

public class EnrollDevicelClient {

	private String phoneNumber;
	private String password;
	private int channel;
	private Integer clientId;
	private String oldPhoneNumber;
	private String brandDevice;
	private String modelDevice;
	private String versionOS;
	private String carrier;
	private String connectAddress;

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getChannel() {
		return channel;
	}

	public void setChannel(int channel) {
		this.channel = channel;
	}

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	public String getOldPhoneNumber() {
		return oldPhoneNumber;
	}

	public void setOldPhoneNumber(String oldPhoneNumber) {
		this.oldPhoneNumber = oldPhoneNumber;
	}

	public String getBrandDevice() {
		return brandDevice;
	}

	public void setBrandDevice(String brandDevice) {
		this.brandDevice = brandDevice;
	}

	public String getModelDevice() {
		return modelDevice;
	}

	public void setModelDevice(String modelDevice) {
		this.modelDevice = modelDevice;
	}

	public String getVersionOS() {
		return versionOS;
	}

	public void setVersionOS(String versionOS) {
		this.versionOS = versionOS;
	}

	public String getCarrier() {
		return carrier;
	}

	public void setCarrier(String carrier) {
		this.carrier = carrier;
	}

	public String getConnectAddress() {
		return connectAddress;
	}

	public void setConnectAddress(String connectAddress) {
		this.connectAddress = connectAddress;
	}

}
