package com.cobiscorp.ecobis.customer.services.dtos;
/**
* Class to represent the table cl_segmento_neg
* @author 
**/

public class BusinessSegmentResponse {
	private String code;
	private String description;
	private String line;
	private String status;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public BusinessSegmentResponse(String code, String description,
			String line, String status) {
		super();
		this.code = code;
		this.description = description;
		this.line = line;
		this.status = status;
	}
	public BusinessSegmentResponse() {
		super();
	}

}
