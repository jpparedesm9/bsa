package com.cobiscorp.cobis.notifier.dispatcher.sms.settings;

public class MobileGatewaySettings {

	private String serviceUrl;
	private String scope;
	private String grantType;
	private String clientId;
	private String clientSecret;
	private String userName;
	private String password;
	private String token;
	private String urlNotification;
	private String xibmClientId;
	private String channel;
	private String clientIp;
	private String provider;

	public String getServiceUrl() {
		return serviceUrl;
	}

	public void setServiceUrl(String serviceUrl) {
		this.serviceUrl = serviceUrl;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getGrantType() {
		return grantType;
	}

	public void setGrantType(String grantType) {
		this.grantType = grantType;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientSecret() {
		return clientSecret;
	}

	public void setClientSecret(String clientSecret) {
		this.clientSecret = clientSecret;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getUrlNotification() {
		return urlNotification;
	}

	public void setUrlNotification(String urlNotification) {
		this.urlNotification = urlNotification;
	}

	public String getXibmClientId() {
		return xibmClientId;
	}

	public void setXibmClientId(String xibmClientId) {
		this.xibmClientId = xibmClientId;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getClientIp() {
		return clientIp;
	}

	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MobileGatewaySettings [serviceUrl=");
		builder.append(serviceUrl);
		builder.append(", scope=");
		builder.append(scope);
		builder.append(", grantType=");
		builder.append(grantType);
		builder.append(", clientId=");
		builder.append(clientId);
		builder.append(", clientSecret=");
		builder.append(clientSecret);
		builder.append(", userName=");
		builder.append(userName);
		builder.append(", password=");
		builder.append(password);
		builder.append(", token=");
		builder.append(token);
		builder.append(", urlNotification=");
		builder.append(urlNotification);
		builder.append(", xibmClientId=");
		builder.append(xibmClientId);
		builder.append(", channel=");
		builder.append(channel);
		builder.append(", clientIp=");
		builder.append(clientIp);
		builder.append(", provider=");
		builder.append(provider);
		builder.append("]");
		return builder.toString();
	}

}
