package com.cobiscorp.airmovil.client.dtos;

public class NotificationHeaderAirmovil {

	private String accesToken;
	private String clientIPAdress;

	public String getAccesToken() {
		return accesToken;
	}

	public void setAccesToken(String accesToken) {
		this.accesToken = accesToken;
	}

	public String getClientIPAdress() {
		return clientIPAdress;
	}

	public void setClientIPAdress(String clientIPAdress) {
		this.clientIPAdress = clientIPAdress;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("NotificationHeaderAirmovil [accesToken=");
		builder.append(accesToken);
		builder.append(", clientIPAdress=");
		builder.append(clientIPAdress);
		builder.append("]");
		return builder.toString();
	}

}
