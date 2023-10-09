package com.cobiscorp.cobis.assets.reports.dto;

import cobiscorp.ecobis.assets.cloud.dto.PreCancellationResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;

public class PrecancellationResponseDTO {

	private PreCancellationResponse precancellation;
	private ReferenceResponse[] references;

	public PrecancellationResponseDTO() {

	}

	public PrecancellationResponseDTO(PreCancellationResponse precancellation, ReferenceResponse[] references) {
		this.precancellation = precancellation;
		this.references = references;
	}

	public PreCancellationResponse getPrecancellation() {
		return precancellation;
	}

	public void setPrecancellation(PreCancellationResponse precancellation) {
		this.precancellation = precancellation;
	}

	public ReferenceResponse[] getReferences() {
		return references;
	}

	public void setReferences(ReferenceResponse[] references) {
		this.references = references;
	}

}
