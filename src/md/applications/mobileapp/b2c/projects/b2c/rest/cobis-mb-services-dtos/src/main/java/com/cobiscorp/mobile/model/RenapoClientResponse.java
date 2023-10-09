package com.cobiscorp.mobile.model;

import java.io.Serializable;
import java.util.Arrays;

public class RenapoClientResponse implements Serializable {
	private static final long serialVersionUID = 1L;

	private String code;
	private String message;
	private String curp;
	private String name;
	private String lastName;
	private String secondLastName;
	private String sex;
	private String birthDate;
	private String birthPlace;
	private String nationality;
	private ErrorMessage errorMessage;
	private ErrorResponse[] errores;

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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RenapoClientResponse [code=");
		builder.append(code);
		builder.append(", message=");
		builder.append(message);
		builder.append(", curp=");
		builder.append(curp);
		builder.append(", name=");
		builder.append(name);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", secondLastName=");
		builder.append(secondLastName);
		builder.append(", sex=");
		builder.append(sex);
		builder.append(", birthDate=");
		builder.append(birthDate);
		builder.append(", birthPlace=");
		builder.append(birthPlace);
		builder.append(", nationality=");
		builder.append(nationality);
		builder.append(", errorMessage=");
		builder.append(errorMessage);
		builder.append(", errores=");
		builder.append(Arrays.toString(errores));
		builder.append("]");
		return builder.toString();
	}

}
