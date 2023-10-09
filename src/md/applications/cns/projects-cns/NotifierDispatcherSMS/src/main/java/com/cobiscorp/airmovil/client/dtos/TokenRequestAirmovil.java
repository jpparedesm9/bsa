package com.cobiscorp.airmovil.client.dtos;

public class TokenRequestAirmovil {

	private String grantType;
	private String username;
	private String password;
	private String usernameAi;
	private String passwordAi;

	public String getUsernameAi() {
		return usernameAi;
	}

	public void setUsernameAi(String usernameAi) {
		this.usernameAi = usernameAi;
	}

	public String getPasswordAi() {
		return passwordAi;
	}

	public void setPasswordAi(String passwordAi) {
		this.passwordAi = passwordAi;
	}

	public String getGrantType() {
		return grantType;
	}

	public void setGrantType(String grantType) {
		this.grantType = grantType;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TokenRequestAirmovil [grantType=");
		builder.append(grantType);
		builder.append(", username=");
		builder.append(username);
		builder.append(", password=");
		builder.append(password);
		builder.append(", usernameAi=");
		builder.append(usernameAi);
		builder.append(", passwordAi=");
		builder.append(passwordAi);
		builder.append("]");
		return builder.toString();
	}

}
