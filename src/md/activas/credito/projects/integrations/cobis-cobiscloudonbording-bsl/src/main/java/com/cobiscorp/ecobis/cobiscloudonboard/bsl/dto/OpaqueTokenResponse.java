package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

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
	
	private String urlWeb;
	private String userId;
	private String sequential;
	private String fileId;
	private String evaluation;
	private ErrorMessage errorMessage;

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
	
	public String getUrlWeb() {
		return urlWeb;
	}

	public void setUrlWeb(String urlWeb) {
		this.urlWeb = urlWeb;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
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

	public String getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}

	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	@Override
	public String toString() {
		return "OpaqueTokenResponse [status=" + status + ", secObjRec=" + secObjRec + ", urlWeb=" + urlWeb + ", userId="
				+ userId + ", sequential=" + sequential + ", fileId=" + fileId + ", evaluation=" + evaluation
				+ ", errorMessage=" + errorMessage + "]";
	}
}
