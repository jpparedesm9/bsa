package com.cobiscorp.mobile.request;

public class FingerprintBiometricRequest {
	private String token;
	private String ipLocal;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getIpLocal() {
		return ipLocal;
	}

	public void setIpLocal(String ipLocal) {
		this.ipLocal = ipLocal;
	}

	@Override
	public String toString() {
		return "FingerprintBiometricRequest [token=" + token + ", ipLocal=" + ipLocal + "]";
	}

}
