package com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.dto;

public class DirectDebitMandateRequest {
	private String detail;

	public DirectDebitMandateRequest() {
		super();
	}

	public DirectDebitMandateRequest(String detail) {
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
		return "DirectDebitMandateRequest{" +
				"detail='" + detail + '\'' +
				'}';
	}
}