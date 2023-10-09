package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.util.List;

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
	
	//@JsonProperty("SecObjSel")
	//SecObjSelRequest SecObjSel;
	
	@JsonProperty("SecObjSel")
	private SecObjSel secObjSel;
	
	
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
	
//	@JsonProperty("SecObjSel")
//	public SecObjSelRequest getSecObjSel() {
//		return SecObjSel;
//	}
//	@JsonProperty("SecObjSel")
//	public void setSecObjSel(SecObjSelRequest SecObjSel) {
//		this.SecObjSel = SecObjSel;
//	}
	public SecObjSel getSecObjSel() {
		return secObjSel;
	}
	public void setSecObjSel(SecObjSel secObjSel) {
		this.secObjSel = secObjSel;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("OpaqueTokenRequest [rqUID=");
		builder.append(rqUID);
		builder.append(", secObjInfo=");
		builder.append(SecObjInfo);
		builder.append(", secObjSel=");
		builder.append(secObjSel);
		builder.append("]");
		return builder.toString();
	}

}
