/*
 * Crédito en Línea
 * Servicios para aplicación de crédito en    
 *
 * OpenAPI spec version: 1.0.0
 * Contact: pablo.lopez@ndeveloper.com
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */

package com.cobiscorp.mobile.model;

import java.util.Objects;

/**
 * ChangePasswordRequest
 */
public class ChangePasswordRequest {
	private String oldPassword = null;

	private String newPassword = null;

	public ChangePasswordRequest oldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
		return this;
	}

	/**
	 * Get oldPassword
	 * 
	 * @return oldPassword
	 **/
	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public ChangePasswordRequest newPassword(String newPassword) {
		this.newPassword = newPassword;
		return this;
	}

	/**
	 * Get newPassword
	 * 
	 * @return newPassword
	 **/
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	@Override
	public boolean equals(java.lang.Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		ChangePasswordRequest changePasswordRequest = (ChangePasswordRequest) o;
		return Objects.equals(this.oldPassword, changePasswordRequest.oldPassword)
				&& Objects.equals(this.newPassword, changePasswordRequest.newPassword);
	}

	@Override
	public int hashCode() {
		return Objects.hash(oldPassword, newPassword);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class ChangePasswordRequest {\n");

		sb.append("    oldPassword: ").append(toIndentedString(oldPassword)).append("\n");
		sb.append("    newPassword: ").append(toIndentedString(newPassword)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces
	 * (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}
}
