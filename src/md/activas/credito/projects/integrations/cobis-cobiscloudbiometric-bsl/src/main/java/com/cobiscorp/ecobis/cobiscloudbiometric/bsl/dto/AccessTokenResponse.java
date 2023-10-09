package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "scope",
    "access_token",
    "token_type",
    "expires_in",
    "consented_on"
})
@JsonIgnoreProperties(ignoreUnknown = true)
public class AccessTokenResponse {
	@JsonProperty("scope")
	String scope;
	@JsonProperty("access_token")
	String accessToken;
	@JsonProperty("token_type")
	String tokenType;
	@JsonProperty("expires_in")
	int expiresIn;
	@JsonProperty("consented_on")
	int consented_on;
	
	ErrorMessage errorMessage;
	
	@JsonProperty("scope")
	public String getScope() {
		return scope;
	}
	@JsonProperty("scope")
	public void setScope(String scope) {
		this.scope = scope;
	}
	@JsonProperty("access_token")
	public String getAccessToken() {
		return accessToken;
	}
	@JsonProperty("access_token")
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	@JsonProperty("token_type")
	public String getTokenType() {
		return tokenType;
	}
	@JsonProperty("token_type")
	public void setTokenType(String tokenType) {
		this.tokenType = tokenType;
	}
	@JsonProperty("expires_in")
	public int getExpiresIn() {
		return expiresIn;
	}
	@JsonProperty("expires_in")
	public void setExpiresIn(int expiresIn) {
		this.expiresIn = expiresIn;
	}
	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}	
	@JsonProperty("consented_on")
	public int getConsented_on() {
		return consented_on;
	}
	@JsonProperty("consented_on")
	public void setConsented_on(int consented_on) {
		this.consented_on = consented_on;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AccessTokenResponse [scope=");
		builder.append(scope);
		builder.append(", accessToken=");
		builder.append(accessToken);
		builder.append(", tokenType=");
		builder.append(tokenType);
		builder.append(", expiresIn=");
		builder.append(expiresIn);
		builder.append(", consented_on=");
		builder.append(consented_on);
		builder.append(", errorMessage=");
		builder.append(errorMessage);
		builder.append("]");
		return builder.toString();
	}	
}
