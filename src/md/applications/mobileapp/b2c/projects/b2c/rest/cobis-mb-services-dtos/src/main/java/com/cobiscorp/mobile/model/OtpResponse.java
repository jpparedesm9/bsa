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

/**
 * OtpResponse
 */
public class OtpResponse {

	private Long otp = null;

	public OtpResponse otp(Long otp) {
		this.otp = otp;
		return this;
	}

	/**
	 * Get otp
	 * 
	 * @return otp
	 **/
	public Long getOtp() {
		return otp;
	}

	public void setOtp(Long otp) {
		this.otp = otp;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((otp == null) ? 0 : otp.hashCode());
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
		OtpResponse other = (OtpResponse) obj;
		if (otp == null) {
			if (other.otp != null)
				return false;
		} else if (!otp.equals(other.otp))
			return false;
		return true;
	}

}
