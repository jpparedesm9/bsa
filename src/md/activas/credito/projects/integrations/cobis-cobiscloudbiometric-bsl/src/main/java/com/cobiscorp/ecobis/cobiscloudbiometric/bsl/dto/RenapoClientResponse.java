package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import java.io.Serializable;
import java.util.Arrays;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "code", "message", "curp", "name", "lastName", "secondLastName", "sex", "birthDate", "birthPlace", "nationality" })
@JsonIgnoreProperties(ignoreUnknown = true)
public class RenapoClientResponse implements Serializable {
	private static final long serialVersionUID = 1L;
	@JsonProperty("code")
	private String code;
	@JsonProperty("message")
	private String message;
	@JsonProperty("curp")
	private String curp;
	@JsonProperty("name")
	private String name;
	@JsonProperty("lastName")
	private String lastName;
	@JsonProperty("secondLastName")
	private String secondLastName;
	@JsonProperty("sex")
	private String sex;
	@JsonProperty("birthDate")
	private String birthDate;
	@JsonProperty("birthPlace")
	private String birthPlace;
	@JsonProperty("nationality")
	private String nationality;
	@JsonProperty("errorMessage")
	private ErrorMessage errorMessage;
	@JsonProperty("errores")
	private ErrorResponse[] errores;

	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
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

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getSecondLastName() {
		return secondLastName;
	}

	public void setSecondLastName(String secondLastName) {
		this.secondLastName = secondLastName;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public ErrorResponse[] getErrores() {
		return errores;
	}

	public void setErrores(ErrorResponse[] errores) {
		this.errores = errores;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getBirthPlace() {
		return birthPlace;
	}

	public void setBirthPlace(String birthPlace) {
		this.birthPlace = birthPlace;
	}

	@Override
	public String toString() {
		return "RenapoClientResponse [code=" + code + ", message=" + message + ", curp=" + curp + ", name=" + name + ", lastName=" + lastName + ", secondLastName=" + secondLastName
				+ ", sex=" + sex + ", birthDate=" + birthDate + ", birthPlace=" + birthPlace + ", nationality=" + nationality + ", errorMessage=" + errorMessage + ", errores="
				+ Arrays.toString(errores) + "]";
	}
	
	

}
