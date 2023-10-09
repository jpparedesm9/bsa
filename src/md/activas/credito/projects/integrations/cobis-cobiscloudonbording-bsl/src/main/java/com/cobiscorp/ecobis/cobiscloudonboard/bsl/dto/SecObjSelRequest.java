package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "rqUID",
    "SecObjSel"
})
public class SecObjSelRequest {
	@JsonProperty("rqUID")
	String rqUID;
	
	@JsonProperty("SecObjSel")
	List<SecObjSel> secObjSel;
	
	
	@JsonProperty("rqUID")
	public String getRqUID() {
		return rqUID;
	}
	@JsonProperty("rqUID")
	public void setRqUID(String rqUID) {
		this.rqUID = rqUID;
	}

	@JsonProperty("SecObjSel")
	public List<SecObjSel> getSecObjSel() {
		return secObjSel;
	}
	@JsonProperty("SecObjSel")
	public void setSecObjSel(List<SecObjSel> secObjSel) {
		this.secObjSel = secObjSel;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("SecObjInfoRequest [rqUID=");
		builder.append(rqUID);
		builder.append(", secObjSel=");
		builder.append(secObjSel);
		builder.append("]");
		return builder.toString();
	}
	
}
