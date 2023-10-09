package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "SecObjDataKey",
    "SecObjDataType",
    "SecObjDataValue"
})
public class SecObjData {
	@JsonProperty("SecObjDataKey")
	String SecObjDataKey;
	@JsonProperty("SecObjDataType")
	String SecObjDataType;
	@JsonProperty("SecObjDataValue")
	Object SecObjDataValue;
	
	@JsonProperty("SecObjDataKey")
	public String getSecObjDataKey() {
		return SecObjDataKey;
	}
	@JsonProperty("SecObjDataKey")
	public void setSecObjDataKey(String SecObjDataKey) {
		this.SecObjDataKey = SecObjDataKey;
	}
	@JsonProperty("SecObjDataType")
	public String getSecObjDataType() {
		return SecObjDataType;
	}
	@JsonProperty("SecObjDataType")
	public void setSecObjDataType(String SecObjDataType) {
		this.SecObjDataType = SecObjDataType;
	}
	@JsonProperty("SecObjDataValue")
	public Object getSecObjDataValue() {
		return SecObjDataValue;
	}
	@JsonProperty("SecObjDataValue")
	public void setSecObjDataValue(Object SecObjDataValue) {
		this.SecObjDataValue = SecObjDataValue;
	}
	
	@Override
	public String toString() {
		return "SecObjData [SecObjDataKey=" + SecObjDataKey + ", SecObjDataType=" + SecObjDataType
				+ ", SecObjDataValue=" + SecObjDataValue + "]";
	}
	
	
}
