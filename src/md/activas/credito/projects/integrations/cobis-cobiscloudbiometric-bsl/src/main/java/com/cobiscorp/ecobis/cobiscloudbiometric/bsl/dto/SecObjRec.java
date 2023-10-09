package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "SecObjInfo"
})
public class SecObjRec implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@JsonProperty("SecObjInfo")
	SecObjInfo secObjInfo;
	
	@JsonProperty("SecObjInfo")
	public SecObjInfo getSecObjInfo() {
		return secObjInfo;
	}
	
	@JsonProperty("SecObjInfo")
	public void setSecObjInfo(SecObjInfo secObjInfo) {
		this.secObjInfo = secObjInfo;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SecObjRec [secObjInfo=");
		builder.append(secObjInfo);
		builder.append("]");
		return builder.toString();
	}
	

}
