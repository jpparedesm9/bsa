package com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto;

public class DisbursementRequest {
	private String detail;

	public DisbursementRequest() {
		super();
	}

	public DisbursementRequest(String detail) {
		super();
		this.detail = detail;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	@Override
	public String toString() {
		return "DisbursementRequest{" +
				"detail='" + detail + '\'' +
				'}';
	}
}