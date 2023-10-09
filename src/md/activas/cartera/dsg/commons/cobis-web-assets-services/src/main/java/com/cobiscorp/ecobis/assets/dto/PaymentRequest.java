package com.cobiscorp.ecobis.assets.dto;

import java.util.List;
import java.util.Map;

public class PaymentRequest {

	private List<PaymentDTO> payments;
	private List<Map<String, StructureDTO>> structures;

	public List<PaymentDTO> getPayments() {
		return payments;
	}

	public void setPayments(List<PaymentDTO> payments) {
		this.payments = payments;

	}

	public List<Map<String, StructureDTO>> getStructures() {
		return structures;
	}

	public void setStructures(List<Map<String, StructureDTO>> structures) {
		this.structures = structures;
	}
}