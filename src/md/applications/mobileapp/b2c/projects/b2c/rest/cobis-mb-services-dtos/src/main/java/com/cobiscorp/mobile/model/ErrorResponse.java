package com.cobiscorp.mobile.model;

import java.io.Serializable;

public class ErrorResponse implements Serializable {

	private static final long serialVersionUID = 1L;

	private String code;

	private String message;

	private String level;

	private String description;

	private String moreInfo;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMoreInfo() {
		return moreInfo;
	}

	public void setMoreInfo(String moreInfo) {
		this.moreInfo = moreInfo;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ErrorResponse [code=");
		builder.append(code);
		builder.append(", message=");
		builder.append(message);
		builder.append(", level=");
		builder.append(level);
		builder.append(", description=");
		builder.append(description);
		builder.append(", moreInfo=");
		builder.append(moreInfo);
		builder.append("]");
		return builder.toString();
	}
}
