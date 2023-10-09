package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ClientInformation {

	// Informacion Adicional
	String ipLocal;
	String idUsuario;
	String idSesionCliente;
	String idCliente;

	String channelId;
	String originId;
	String countryId;
	String redirectURL;
	String fileId;
	String flow;

	public String getIpLocal() {
		return ipLocal;
	}

	public void setIpLocal(String ipLocal) {
		this.ipLocal = ipLocal;
	}

	public String getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(String idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getIdSesionCliente() {
		return idSesionCliente;
	}

	public void setIdSesionCliente(String idSesionCliente) {
		this.idSesionCliente = idSesionCliente;
	}

	public String getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}

	public String getChannelId() {
		return channelId;
	}

	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	public String getOriginId() {
		return originId;
	}

	public void setOriginId(String originId) {
		this.originId = originId;
	}

	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}

	
	public String getRedirectURL() {
		return redirectURL;
	}

	public void setRedirectURL(String redirectURL) {
		this.redirectURL = redirectURL;
	}

	public String getFlow() {
		return flow;
	}

	public void setFlow(String flow) {
		this.flow = flow;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String toString2() {
		return "ClientInformation [idCliente=" + idCliente + ", channelId=" + channelId + ", originId=" + originId
				+ ", fileId=" + fileId + ", countryId=" + countryId + ", redirectURL=" + redirectURL+ ", flow=" + flow + "]";
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ClientInformation [ipLocal=");
		builder.append(ipLocal);
		builder.append(", idUsuario=");
		builder.append(idUsuario);
		builder.append(", idSesionCliente=");
		builder.append(idSesionCliente);
		builder.append(", idCliente=");
		builder.append(idCliente);
		builder.append("]");
		return builder.toString();
	}

}
