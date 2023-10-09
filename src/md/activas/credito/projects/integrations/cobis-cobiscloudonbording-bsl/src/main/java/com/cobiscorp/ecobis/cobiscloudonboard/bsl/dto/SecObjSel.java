package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "SecObjValue", "SecObjPurpose" })
public class SecObjSel {
	@JsonProperty("SecObjValue")
	String SecObjValue;
	@JsonProperty("SecObjPurpose")
	String SecObjPurpose;

	@JsonProperty("SecObjValue")
	public String getSecObjValue() {
		return SecObjValue;
	}

	@JsonProperty("SecObjValue")
	public void setSecObjValue(String SecObjValue) {
		this.SecObjValue = SecObjValue;
	}

	@JsonProperty("SecObjPurpose")
	public String getSecObjPurpose() {
		return SecObjPurpose;
	}

	@JsonProperty("SecObjPurpose")
	public void setSecObjPurpose(String SecObjPurpose) {
		this.SecObjPurpose = SecObjPurpose;
	}

	@Override
	public String toString() {
		return "SecObjSel [SecObjValue=" + SecObjValue + ", SecObjPurpose=" + SecObjPurpose + "]";
	}

}
