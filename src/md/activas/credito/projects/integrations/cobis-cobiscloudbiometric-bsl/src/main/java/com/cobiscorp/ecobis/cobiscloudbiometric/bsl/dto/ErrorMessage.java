package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ErrorMessage implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JsonProperty("httpCode")
	String httpCode;
	@JsonProperty("httpMessage")
	String httpMessage;
	@JsonProperty("moreInformation")
	String moreInformation;
	@JsonProperty("Status")
	Status status;
	@JsonProperty("error")
	String error;
	@JsonProperty("error_description")
	String errorDescription;
	
	@JsonProperty("httpCode")
	public String getHttpCode() {
		return httpCode;
	}
	@JsonProperty("httpCode")
	public void setHttpCode(String httpCode) {
		this.httpCode = httpCode;
	}
	@JsonProperty("httpMessage")
	public String getHttpMessage() {
		return httpMessage;
	}
	@JsonProperty("httpMessage")
	public void setHttpMessage(String httpMessage) {
		this.httpMessage = httpMessage;
	}
	@JsonProperty("moreInformation")
	public String getMoreInformation() {
		return moreInformation;
	}
	@JsonProperty("moreInformation")
	public void setMoreInformation(String moreInformation) {
		this.moreInformation = moreInformation;
	}
	@JsonProperty("Status")
	public Status getStatus() {
		return status;
	}
	@JsonProperty("Status")
	public void setStatus(Status status) {
		this.status = status;
	}
	@JsonProperty("error")
	public String getError() {
		return error;
	}
	@JsonProperty("error")
	public void setError(String error) {
		this.error = error;
	}
	@JsonProperty("error_description")
	public String getErrorDescription() {
		return errorDescription;
	}
	@JsonProperty("error_description")
	public void setErrorDescription(String errorDescription) {
		this.errorDescription = errorDescription;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ErrorMessage [httpCode=");
		builder.append(httpCode);
		builder.append(", httpMessage=");
		builder.append(httpMessage);
		builder.append(", moreInformation=");
		builder.append(moreInformation);
		builder.append(", status=");
		builder.append(status);
		builder.append(", error=");
		builder.append(error);
		builder.append(", errorDescription=");
		builder.append(errorDescription);
		builder.append("]");
		return builder.toString();
	}
	
}
