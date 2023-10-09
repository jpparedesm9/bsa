package com.cobiscorp.mobile.request;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ClientInformation {
	
	//Informacion Adicional
	String ipLocal;
	String idUsuario;
	String idSesionCliente;
	String idCliente;
	
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
