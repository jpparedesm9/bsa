package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "stokenGeneratorResponse"
})
@JsonIgnoreProperties(ignoreUnknown = true)
public class StokenGeneratorRespMain {

	@JsonProperty("stokenGeneratorResponse")
	StokenGeneratorResponse stokenGeneratorResponse;
	
	ErrorMessage errorMessage;
	
	@JsonProperty("stokenGeneratorResponse")
	public StokenGeneratorResponse getStokenGeneratorResponse() {
		return stokenGeneratorResponse;
	}
	@JsonProperty("stokenGeneratorResponse")
	public void setStokenGeneratorResponse(StokenGeneratorResponse stokenGeneratorResponse) {
		this.stokenGeneratorResponse = stokenGeneratorResponse;
	}
	
	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}
}
