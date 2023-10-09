package com.cobiscorp.ecobis.cloud.service.dto;

import java.util.List;

import cobiscorp.ecobis.businesstobusiness.dto.OperationResponse;

public class OperationDataResponse {
	private List<OperationResponseDTO> operations;

	public List<OperationResponseDTO> getOperations() {
		return operations;
	}

	public void setOperations(List<OperationResponseDTO> operations) {
		this.operations = operations;
	}

}