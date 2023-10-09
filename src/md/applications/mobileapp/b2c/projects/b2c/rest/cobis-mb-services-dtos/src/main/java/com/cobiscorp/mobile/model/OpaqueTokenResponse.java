package com.cobiscorp.mobile.model;

public class OpaqueTokenResponse {
	private String urlWeb;
	private String idCliente;
	private String idExpediente;
	private String code;
	private String message;
	private String opakeToken;
	private String evaluation;
	public String getUrlWeb() {
		return urlWeb;
	}
	public void setUrlWeb(String urlWeb) {
		this.urlWeb = urlWeb;
	}
	public String getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}
	public String getIdExpediente() {
		return idExpediente;
	}
	public void setIdExpediente(String idExpediente) {
		this.idExpediente = idExpediente;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getOpakeToken() {
		return opakeToken;
	}
	public void setOpakeToken(String opakeToken) {
		this.opakeToken = opakeToken;
	}
	public String getEvaluation() {
		return evaluation;
	}
	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}
	@Override
	public String toString() {
		return "OpaqueTokenResponse [urlWeb=" + urlWeb + ", idCliente=" + idCliente + ", idExpediente=" + idExpediente
				+ ", code=" + code + ", message=" + message + ", opakeToken=" + opakeToken + ", evaluation="
				+ evaluation + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((evaluation == null) ? 0 : evaluation.hashCode());
		result = prime * result + ((idCliente == null) ? 0 : idCliente.hashCode());
		result = prime * result + ((idExpediente == null) ? 0 : idExpediente.hashCode());
		result = prime * result + ((message == null) ? 0 : message.hashCode());
		result = prime * result + ((opakeToken == null) ? 0 : opakeToken.hashCode());
		result = prime * result + ((urlWeb == null) ? 0 : urlWeb.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OpaqueTokenResponse other = (OpaqueTokenResponse) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (evaluation == null) {
			if (other.evaluation != null)
				return false;
		} else if (!evaluation.equals(other.evaluation))
			return false;
		if (idCliente == null) {
			if (other.idCliente != null)
				return false;
		} else if (!idCliente.equals(other.idCliente))
			return false;
		if (idExpediente == null) {
			if (other.idExpediente != null)
				return false;
		} else if (!idExpediente.equals(other.idExpediente))
			return false;
		if (message == null) {
			if (other.message != null)
				return false;
		} else if (!message.equals(other.message))
			return false;
		if (opakeToken == null) {
			if (other.opakeToken != null)
				return false;
		} else if (!opakeToken.equals(other.opakeToken))
			return false;
		if (urlWeb == null) {
			if (other.urlWeb != null)
				return false;
		} else if (!urlWeb.equals(other.urlWeb))
			return false;
		return true;
	}

}
