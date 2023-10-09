package com.cobiscorp.notification.client.dtos;

public class NotificationHeader {
	private String XIbmClientId;
	private String accesToken;
	private String channelId;
	private String clientIPAdress;
	public String getXIbmClientId() {
		return XIbmClientId;
	}
	public void setXIbmClientId(String xIbmClientId) {
		XIbmClientId = xIbmClientId;
	}
	public String getAccesToken() {
		return accesToken;
	}
	public void setAccesToken(String accesToken) {
		this.accesToken = accesToken;
	}
	public String getChannelId() {
		return channelId;
	}
	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}
	public String getClientIPAdress() {
		return clientIPAdress;
	}
	public void setClientIPAdress(String clientIPAdress) {
		this.clientIPAdress = clientIPAdress;
	}
	
	
}
