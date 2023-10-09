package com.cobiscorp.ecobis.clientviewer.dto;

import java.util.List;

public class SummaryProductDTO {

	private List<ConsolidatePositionDTO> consolidatePosition;
	private int totalProduct;
	private double totalAmountProduct;

	public List<ConsolidatePositionDTO> getConsolidatePosition() {
		return consolidatePosition;
	}

	public void setConsolidatePosition(
			List<ConsolidatePositionDTO> consolidatePosition) {
		this.consolidatePosition = consolidatePosition;
	}

	public int getTotalProduct() {
		return totalProduct;
	}

	public void setTotalProduct(int totalProduct) {
		this.totalProduct = totalProduct;
	}

	public double getTotalAmountProduct() {
		return totalAmountProduct;
	}

	public void setTotalAmountProduct(double totalAmountProduct) {
		this.totalAmountProduct = totalAmountProduct;
	}

}
