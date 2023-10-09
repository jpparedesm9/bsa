package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "SecObjInfo", "SecObjInfoBean" })
public class SecObjRec implements Serializable {
	private static final long serialVersionUID = 1L;

	@JsonProperty("SecObjInfo")
	SecObjInfo secObjInfo;

	@JsonProperty("SecObjInfoBean")
	SecObjInfoBean secObjInfoBean;

	@JsonProperty("SecObjInfo")
	public SecObjInfo getSecObjInfo() {
		return secObjInfo;
	}

	@JsonProperty("SecObjInfo")
	public void setSecObjInfo(SecObjInfo secObjInfo) {
		this.secObjInfo = secObjInfo;
	}

	@JsonProperty("SecObjInfoBean")
	public SecObjInfoBean getSecObjInfoBean() {
		return secObjInfoBean;
	}

	@JsonProperty("SecObjInfoBean")
	public void setSecObjInfoBean(SecObjInfoBean secObjInfoBean) {
		this.secObjInfoBean = secObjInfoBean;
	}

	@Override
	public String toString() {
		return "SecObjRec [secObjInfo=" + secObjInfo + ", secObjInfoBean=" + secObjInfoBean + "]";
	}

}
