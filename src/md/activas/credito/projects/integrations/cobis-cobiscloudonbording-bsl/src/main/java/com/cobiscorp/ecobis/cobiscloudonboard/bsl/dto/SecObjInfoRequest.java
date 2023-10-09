package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "secObjValue",
    "secObjPurpose",
    "SecObjData"
})
public class SecObjInfoRequest {
	@JsonProperty("secObjValue")
	String secObjValue;
	@JsonProperty("secObjPurpose")
	String secObjPurpose;
	@JsonProperty("SecObjData")
	List<SecObjData> secObjData;
	
	@JsonProperty("secObjValue")
	public String getSecObjValue() {
		return secObjValue;
	}
	@JsonProperty("secObjValue")
	public void setSecObjValue(String secObjValue) {
		this.secObjValue = secObjValue;
	}
	@JsonProperty("secObjPurpose")
	public String getSecObjPurpose() {
		return secObjPurpose;
	}
	@JsonProperty("secObjPurpose")
	public void setSecObjPurpose(String secObjPurpose) {
		this.secObjPurpose = secObjPurpose;
	}
	@JsonProperty("SecObjData")
	public List<SecObjData> getSecObjData() {
		return secObjData;
	}
	@JsonProperty("SecObjData")
	public void setSecObjData(List<SecObjData> secObjData) {
		this.secObjData = secObjData;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SecObjInfoRequest [secObjValue=");
		builder.append(secObjValue);
		builder.append(", secObjPurpose=");
		builder.append(secObjPurpose);
		builder.append(", secObjData=");
		builder.append(secObjData);
		builder.append("]");
		return builder.toString();
	}
	
}
