package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "rqUID",
    "SecObjInfo"
})
public class OpaqueTokenRequest {
	@JsonProperty("rqUID")
	String rqUID;
	@JsonProperty("SecObjInfo")
	SecObjInfoRequest SecObjInfo;
	
	@JsonProperty("rqUID")
	public String getRqUID() {
		return rqUID;
	}
	@JsonProperty("rqUID")
	public void setRqUID(String rqUID) {
		this.rqUID = rqUID;
	}
	@JsonProperty("SecObjInfo")
	public SecObjInfoRequest getSecObjInfo() {
		return SecObjInfo;
	}
	@JsonProperty("SecObjInfo")
	public void setSecObjInfo(SecObjInfoRequest SecObjInfo) {
		this.SecObjInfo = SecObjInfo;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("OpaqueTokenRequest [rqUID=");
		builder.append(rqUID);
		builder.append(", secObjInfo=");
		builder.append(SecObjInfo);
		builder.append("]");
		return builder.toString();
	}
	
	
}
