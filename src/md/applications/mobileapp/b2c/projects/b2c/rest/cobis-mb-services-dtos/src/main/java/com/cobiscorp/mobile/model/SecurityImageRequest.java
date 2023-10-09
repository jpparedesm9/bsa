package com.cobiscorp.mobile.model;

public class SecurityImageRequest extends BaseRequest {

	private int firsTime;
	private String alias;
	private String imageId;
	private String entityType;
	private String otp; 
	private String mode;

	public int getFirsTime() {
		return firsTime;
	}

	public void setFirsTime(int firsTime) {
		this.firsTime = firsTime;
	}

	public String getAlias() {
		return alias;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public String getOtp() {
		return otp;
	}

	public void setOtp(String otp) {
		this.otp = otp;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	
	
	
}
