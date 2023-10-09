package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

public class PAdicional {
	String userId;
	String buc;
	String numSuc;
	String numTerm;
	String canal;
	String appId;
	String transacionId;
	String estPers;
	String tipoOperacion;
	String tipoOpeApp;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBuc() {
		return buc;
	}
	public void setBuc(String buc) {
		this.buc = buc;
	}
	public String getNumSuc() {
		return numSuc;
	}
	public void setNumSuc(String numSuc) {
		this.numSuc = numSuc;
	}
	public String getNumTerm() {
		return numTerm;
	}
	public void setNumTerm(String numTerm) {
		this.numTerm = numTerm;
	}
	public String getCanal() {
		return canal;
	}
	public void setCanal(String canal) {
		this.canal = canal;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getTransacionId() {
		return transacionId;
	}
	public void setTransacionId(String transacionId) {
		this.transacionId = transacionId;
	}
	public String getEstPers() {
		return estPers;
	}
	public void setEstPers(String estPers) {
		this.estPers = estPers;
	}
	public String getTipoOperacion() {
		return tipoOperacion;
	}
	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}
	public String getTipoOpeApp() {
		return tipoOpeApp;
	}
	public void setTipoOpeApp(String tipoOpeApp) {
		this.tipoOpeApp = tipoOpeApp;
	}
	@Override
	public String toString() {
		return "PAdicional [userId=" + userId + ", buc=" + buc + ", numSuc=" + numSuc + ", numTerm=" + numTerm
				+ ", canal=" + canal + ", appId=" + appId + ", transacionId=" + transacionId + ", estPers=" + estPers
				+ ", tipoOperacion=" + tipoOperacion + ", tipoOpeApp=" + tipoOpeApp + "]";
	}

	

}
