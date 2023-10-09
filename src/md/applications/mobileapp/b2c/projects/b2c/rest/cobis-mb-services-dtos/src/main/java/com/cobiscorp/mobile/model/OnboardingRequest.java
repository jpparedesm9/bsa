package com.cobiscorp.mobile.model;

public class OnboardingRequest {

	private String cellphoneNumber;
	private String brandDevice;
	private String modelDevice;
	private String versionOS;
	private String carrier;
	private String device;
	private String culture;
	private String connectAddress;

	public OnboardingRequest() {

	}

	public OnboardingRequest(String cellphoneNumber) {
		super();
		this.cellphoneNumber = cellphoneNumber;
	}

	public String getCellphoneNumber() {
		return cellphoneNumber;
	}

	public void setCellphoneNumber(String cellphoneNumber) {
		this.cellphoneNumber = cellphoneNumber;
	}

	public String getCulture() {
		return culture;
	}

	public void setCulture(String culture) {
		this.culture = culture;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public String getConnectAddress() {
		return connectAddress;
	}

	public void setConnectAddress(String connectAddress) {
		this.connectAddress = connectAddress;
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

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("OnboardingRequest [");
		sb.append("cellphoneNumber");
		sb.append(cellphoneNumber == null ? "" : cellphoneNumber);
		sb.append(", brandDevice=");
		sb.append(brandDevice == null ? "" : brandDevice);
		sb.append("modelDevice=");
		sb.append(modelDevice == null ? "" : modelDevice);
		sb.append("versionOS=");
		sb.append(versionOS == null ? "" : versionOS);
		sb.append("carrier=");
		sb.append(carrier == null ? "" : carrier);
		sb.append("device=");
		sb.append(device == null ? "" : device);
		sb.append("culture=");
		sb.append(culture == null ? "" : culture);
		sb.append("connectAddress=");
		sb.append(connectAddress == null ? "" : connectAddress);
		sb.append("]");
		return sb.toString();
	}

	
}
