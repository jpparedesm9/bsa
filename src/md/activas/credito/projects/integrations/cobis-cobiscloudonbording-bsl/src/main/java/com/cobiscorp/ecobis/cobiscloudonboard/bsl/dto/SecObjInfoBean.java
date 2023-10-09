package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "SecObjData" })
public class SecObjInfoBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@JsonProperty("SecObjData")
	List<SecObjData> secObjData;

	public List<SecObjData> getSecObjData() {
		return secObjData;
	}

	public void setSecObjData(List<SecObjData> secObjData) {
		this.secObjData = secObjData;
	}

}
