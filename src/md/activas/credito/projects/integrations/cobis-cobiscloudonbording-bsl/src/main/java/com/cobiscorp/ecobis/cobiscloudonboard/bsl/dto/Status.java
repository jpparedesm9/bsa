package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "StatusCode",
    "StatusDesc"
})
@JsonIgnoreProperties(ignoreUnknown = true)
public class Status implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@JsonProperty("StatusCode")
	int statusCode;
	@JsonProperty("StatusDesc")
	String statusDesc;
	
	
	@JsonProperty("StatusCode")
	public int getStatusCode() {
		return statusCode;
	}


	@JsonProperty("StatusCode")
	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}


	@JsonProperty("StatusDesc")
	public String getStatusDesc() {
		return statusDesc;
	}


	@JsonProperty("StatusDesc")
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}



	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Status [statusCode=");
		builder.append(statusCode);
		builder.append(", statusDesc=");
		builder.append(statusDesc);
		builder.append("]");
		return builder.toString();
	}



	

}
