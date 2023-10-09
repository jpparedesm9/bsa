package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

/**
 * @author 
 * @date 24/05/2018
 */
public class Encabezado {
	private String numeroReferenciaOperador;
	private String clavePais;
	private String identificadorBuro;
	private String claveOtorgante;
	private String claveRetornoConsumidorPrincipal;
	private String claveRetornoConsumidorSecundario;
	private String numeroControlConsulta;

	public Encabezado() {

	}

	public String getNumeroReferenciaOperador() {
		return numeroReferenciaOperador;
	}

	@XmlElement(name = "NumeroReferenciaOperador")
	public void setNumeroReferenciaOperador(String numeroReferenciaOperador) {
		this.numeroReferenciaOperador = numeroReferenciaOperador;
	}

	public String getClavePais() {
		return clavePais;
	}

	@XmlElement(name = "ClavePais")
	public void setClavePais(String clavePais) {
		this.clavePais = clavePais;
	}

	public String getIdentificadorBuro() {
		return identificadorBuro;
	}

	@XmlElement(name = "IdentificadorBuro")
	public void setIdentificadorBuro(String identificadorBuro) {
		this.identificadorBuro = identificadorBuro;
	}

	public String getClaveOtorgante() {
		return claveOtorgante;
	}

	@XmlElement(name = "ClaveOtorgante")
	public void setClaveOtorgante(String claveOtorgante) {
		this.claveOtorgante = claveOtorgante;
	}

	public String getClaveRetornoConsumidorPrincipal() {
		return claveRetornoConsumidorPrincipal;
	}

	@XmlElement(name = "ClaveRetornoConsumidorPrincipal")
	public void setClaveRetornoConsumidorPrincipal(
			String claveRetornoConsumidorPrincipal) {
		this.claveRetornoConsumidorPrincipal = claveRetornoConsumidorPrincipal;
	}

	public String getClaveRetornoConsumidorSecundario() {
		return claveRetornoConsumidorSecundario;
	}

	@XmlElement(name = "ClaveRetornoConsumidorSecundario")
	public void setClaveRetornoConsumidorSecundario(
			String claveRetornoConsumidorSecundario) {
		this.claveRetornoConsumidorSecundario = claveRetornoConsumidorSecundario;
	}

	public String getNumeroControlConsulta() {
		return numeroControlConsulta;
	}

	@XmlElement(name = "NumeroControlConsulta")
	public void setNumeroControlConsulta(String numeroControlConsulta) {
		this.numeroControlConsulta = numeroControlConsulta;
	}

	@Override
	public String toString() {
		return "Encabezado{" 
	            + "numeroReferenciaOperador='"
				+ numeroReferenciaOperador + '\'' + "clavePais='" + clavePais
				+ '\'' + "identificadorBuro='" + identificadorBuro + '\''
				+ "claveOtorgante='" + claveOtorgante + '\''
				+ "claveRetornoConsumidorPrincipal='"
				+ claveRetornoConsumidorPrincipal + '\''
				+ "claveRetornoConsumidorSecundario='"
				+ claveRetornoConsumidorSecundario + '\''
				+ ", numeroControlConsulta='" + numeroControlConsulta + '\''
				+ '}';
	}
}
