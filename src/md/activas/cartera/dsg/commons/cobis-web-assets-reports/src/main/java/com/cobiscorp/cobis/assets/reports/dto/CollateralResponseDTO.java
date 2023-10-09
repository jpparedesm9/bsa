package com.cobiscorp.cobis.assets.reports.dto;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.GroupInfoResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentDetGarResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;

public class CollateralResponseDTO {
	private GroupInfoResponse groupInfoResponse;
	private List<ReferenceResponse> references;
	private List<PaymentDetGarResponse> detallePagos;

	public CollateralResponseDTO() {

	}

	public CollateralResponseDTO(GroupInfoResponse groupInfoResponse, List<ReferenceResponse> references) {
		this.groupInfoResponse = groupInfoResponse;
		this.references = references;
	}
	
	public CollateralResponseDTO(GroupInfoResponse groupInfoResponse, List<ReferenceResponse> references, List<PaymentDetGarResponse> detallePagos) {
		this.groupInfoResponse = groupInfoResponse;
		this.references = references;
		this.detallePagos=detallePagos;
	}

	public GroupInfoResponse getGroupInfoResponse() {
		return groupInfoResponse;
	}

	public void setGroupInfoResponse(GroupInfoResponse groupInfoResponse) {
		this.groupInfoResponse = groupInfoResponse;
	}

	public List<ReferenceResponse> getReferences() {
		return references;
	}

	public void setReferences(List<ReferenceResponse> references) {
		this.references = references;
	}

	public List<PaymentDetGarResponse> getDetallePagos() {
		return detallePagos;
	}

	public void setDetallePagos(List<PaymentDetGarResponse> detallePagos) {
		this.detallePagos = detallePagos;
	}
	
	

}
