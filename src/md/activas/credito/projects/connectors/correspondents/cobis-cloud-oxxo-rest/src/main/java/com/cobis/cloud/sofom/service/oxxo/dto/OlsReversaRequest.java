package com.cobis.cloud.sofom.service.oxxo.dto;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.cobis.cloud.sofom.service.oxxo.anotations.DataType;
import com.cobis.cloud.sofom.service.oxxo.anotations.OxxoValidation;

@XmlRootElement(name = "OLS")
@XmlType(propOrder = { "token", "folio", "auth" })
public class OlsReversaRequest {
	
	// Datos de entrada
	// Validaciones Requerido, tipo de dato, dimension 
	//@OxxoValidation(required=true,dataType=DataType.ALFANUMERICO_NUMERICO_ESPECIAL,maxlength=15)
	private String token;
	@OxxoValidation(required=true,dataType=DataType.ALFANUMERICO,maxlength=10)
	private String folio;
	@OxxoValidation(required=false,dataType=DataType.ALFANUMERICO,maxlength=10)
	private Integer auth;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getFolio() {
		return folio;
	}

	public void setFolio(String folio) {
		this.folio = folio;
	}

	public Integer getAuth() {
		return auth;
	}

	public void setAuth(Integer auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "OlsReversaRequest [token=" + token + ", folio=" + folio
				+ ", auth=" + auth + "]";
	}
	
	
	

}
