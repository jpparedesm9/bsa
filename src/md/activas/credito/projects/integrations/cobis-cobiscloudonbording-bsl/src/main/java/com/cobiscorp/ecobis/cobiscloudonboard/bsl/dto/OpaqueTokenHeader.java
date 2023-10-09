package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class OpaqueTokenHeader {
	@JsonProperty("UserId")
	String UserId;
	@JsonProperty("ClientIPAddress")
	String ClientIPAddress;
	@JsonProperty("ClientSessionId")
	String ClientSessionId;
	@JsonProperty("ClientId")
	String ClientId;
	
	@JsonProperty("UserId")
	public String getUserId() {
		return UserId;
	}
	@JsonProperty("UserId")
	public void setUserId(String userId) {
		UserId = userId;
	}
	@JsonProperty("ClientIPAddress")
	public String getClientIPAddress() {
		return ClientIPAddress;
	}
	@JsonProperty("ClientIPAddress")
	public void setClientIPAddress(String clientIPAddress) {
		ClientIPAddress = clientIPAddress;
	}
	@JsonProperty("ClientSessionId")
	public String getClientSessionId() {
		return ClientSessionId;
	}
	@JsonProperty("ClientSessionId")
	public void setClientSessionId(String clientSessionId) {
		ClientSessionId = clientSessionId;
	}
	@JsonProperty("ClientId")
	public String getClientId() {
		return ClientId;
	}
	@JsonProperty("ClientId")
	public void setClientId(String clientId) {
		ClientId = clientId;
	}
	
	@Override
	public String toString() {
		return "OpaqueTokenHeader [UserId=" + UserId + ", ClientIPAddress=" + ClientIPAddress + ", ClientSessionId="
				+ ClientSessionId + ", ClientId=" + ClientId + "]";
	}
	
	
}
