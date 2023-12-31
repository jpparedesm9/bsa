package com.cobiscorp.notification.client.dtos;

public class TokenResponse {
	private String token_type;
	private String access_token;
	private String expires_in;
	private String scope;

	public String getToken_type() {
		return token_type;
	}

	public void setToken_type(String token_type) {
		this.token_type = token_type;
	}

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public String getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(String expires_in) {
		this.expires_in = expires_in;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TokenResponse [token_type=");
		builder.append(token_type);
		builder.append(", access_token=");
		builder.append(access_token);
		builder.append(", expires_in=");
		builder.append(expires_in);
		builder.append(", scope=");
		builder.append(scope);
		builder.append("]");
		return builder.toString();
	}

}
