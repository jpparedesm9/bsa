package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "Status",
    "SecObjRec"
})
@JsonIgnoreProperties(ignoreUnknown = true)
public class OpaqueTokenResponse implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@JsonProperty("Status")
	Status status;
	@JsonProperty("SecObjRec")
	SecObjRec secObjRec;
	String userId;
	String sequential;
	ErrorMessage errorMessage;
	StokenGeneratorResponse stokenGeneratorResponse;

	@JsonProperty("Status")
	public Status getStatus() {
		return status;
	}

	@JsonProperty("Status")
	public void setStatus(Status status) {
		this.status = status;
	}

	@JsonProperty("SecObjRec")
	public SecObjRec getSecObjRec() {
		return secObjRec;
	}

	@JsonProperty("SecObjRec")
	public void setSecObjRec(SecObjRec secObjRec) {
		this.secObjRec = secObjRec;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSequential() {
		return sequential;
	}
	public void setSequential(String sequential) {
		this.sequential = sequential;
	}

	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}

	public StokenGeneratorResponse getStokenGeneratorResponse() {
		return stokenGeneratorResponse;
	}

	public void setStokenGeneratorResponse(StokenGeneratorResponse stokenGeneratorResponse) {
		this.stokenGeneratorResponse = stokenGeneratorResponse;
	}
	
}
