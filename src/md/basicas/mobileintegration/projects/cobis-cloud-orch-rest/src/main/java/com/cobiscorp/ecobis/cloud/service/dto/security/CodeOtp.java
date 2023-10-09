package com.cobiscorp.ecobis.cloud.service.dto.security;

public class CodeOtp {

	private String tipo;
	private String canal;
	private String phoneMail;
	private String code;
	private int codEnte;
	
	public int getCodEnte() {
		return codEnte;
	}

	public void setCodEnte(int codEnte) {
		this.codEnte = codEnte;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getCanal() {
		return canal;
	}

	public void setCanal(String canal) {
		this.canal = canal;
	}

	public String getPhoneMail() {
		return phoneMail;
	}

	public void setPhoneMail(String phoneMail) {
		this.phoneMail = phoneMail;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class CodeOtp {\n");
		sb.append("    tipo: ").append(toIndentedString(tipo)).append("\n");
		sb.append("    canal: ").append(toIndentedString(canal)).append("\n");
		sb.append("    phoneMail: ").append(toIndentedString(phoneMail)).append("\n");
		sb.append("    code: ").append(toIndentedString(code)).append("\n");
		sb.append("    codEnte: ").append(toIndentedString(codEnte)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}

}
