package com.cobiscorp.mobile.model;

public class RenapoClientRequest {
	private String curp;
	private Integer clientId;

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RenapoClientRequest [curp=");
		builder.append(curp);
		builder.append(", clientId=");
		builder.append(clientId);
		builder.append("]");
		return builder.toString();
	}

}
