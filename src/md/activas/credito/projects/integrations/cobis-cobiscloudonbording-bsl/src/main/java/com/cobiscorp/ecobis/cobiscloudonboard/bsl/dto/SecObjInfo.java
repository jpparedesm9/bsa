package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "SecObjValue",
    "SecObjPurpose"
})
public class SecObjInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JsonProperty("SecObjValue")
	String secObjValue;
	@JsonProperty("SecObjPurpose")
	String secObjPurpose;
	
	@JsonProperty("SecObjValue")
	public String getSecObjValue() {
		return secObjValue;
	}
	
	@JsonProperty("SecObjValue")
	public void setSecObjValue(String secObjValue) {
		this.secObjValue = secObjValue;
	}
	
	@JsonProperty("SecObjPurpose")
	public String getSecObjPurpose() {
		return secObjPurpose;
	}
	
	@JsonProperty("SecObjPurpose")
	public void setSecObjPurpose(String secObjPurpose) {
		this.secObjPurpose = secObjPurpose;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SecObjInfo [secObjValue=");
		builder.append(secObjValue);
		builder.append(", secObjPurpose=");
		builder.append(secObjPurpose);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
	
	
	
}
