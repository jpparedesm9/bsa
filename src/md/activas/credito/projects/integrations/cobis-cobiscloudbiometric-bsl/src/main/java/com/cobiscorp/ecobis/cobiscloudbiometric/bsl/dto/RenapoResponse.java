package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import java.util.Arrays;
import java.util.List;

public class RenapoResponse {

	private String curp;
	private String status;
	private List<RenapoMessage> messages;
	
	//Nueva consulta
	private String code;
	private String message;
	private String name;
	private String secondName;
	private String lastName;
	private String secondLastName;
	private String sex;
	private String birthDate;
	private String birthPlace;
	private String nationality;
	private ErrorMessage errorMessage;
	private ErrorResponse[] errores;
	
	public RenapoResponse() {
		super();
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<RenapoMessage> getMessages() {
		return messages;
	}

	public void setMessages(List<RenapoMessage> messages) {
		this.messages = messages;
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

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}

	public ErrorResponse[] getErrores() {
		return errores;
	}

	public void setErrores(ErrorResponse[] errores) {
		this.errores = errores;
	}

	public String getSecondName() {
		return secondName;
	}

	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}

	@Override
	public String toString() {
		return "RenapoResponse [curp=" + curp + ", status=" + status + ", messages=" + messages + ", code=" + code
				+ ", message=" + message + ", name=" + name + ", secondName=" + secondName + ", lastName=" + lastName
				+ ", secondLastName=" + secondLastName + ", sex=" + sex + ", birthDate=" + birthDate + ", birthPlace="
				+ birthPlace + ", nationality=" + nationality + ", errorMessage=" + errorMessage + ", errores="
				+ Arrays.toString(errores) + "]";
	}

}
