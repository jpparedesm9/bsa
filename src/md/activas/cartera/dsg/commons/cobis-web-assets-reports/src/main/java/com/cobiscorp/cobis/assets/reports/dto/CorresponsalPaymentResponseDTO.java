package com.cobiscorp.cobis.assets.reports.dto;

import java.util.Arrays;

import cobiscorp.ecobis.assets.cloud.dto.CorresponsalPaymentResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;

public class CorresponsalPaymentResponseDTO {

	private CorresponsalPaymentResponse corresponsalPaymentResponse;
	private ReferenceResponse[] references;

	public CorresponsalPaymentResponseDTO() {

	}

	public CorresponsalPaymentResponseDTO(CorresponsalPaymentResponse corresponsalPaymentResponse, ReferenceResponse[] references) {
		this.corresponsalPaymentResponse = corresponsalPaymentResponse;
		this.references = references;
	}

	public CorresponsalPaymentResponse getCorresponsalPaymentResponse() {
		return corresponsalPaymentResponse;
	}

	public void setCorresponsalPaymentResponse(CorresponsalPaymentResponse corresponsalPaymentResponse) {
		this.corresponsalPaymentResponse = corresponsalPaymentResponse;
	}

	public ReferenceResponse[] getReferences() {
		return references;
	}

	public void setReferences(ReferenceResponse[] references) {
		this.references = references;
	}

	@Override
	public String toString() {
		String cadena="";
		if(corresponsalPaymentResponse !=null){
			cadena=corresponsalPaymentResponse.getClientName()+" "+
					corresponsalPaymentResponse.getEffectiveDate()+" "+
					corresponsalPaymentResponse.getFeeNumber()+" "+
					corresponsalPaymentResponse.getOffice()+" ";
		}
		if(references!=null){
			cadena=cadena+" size "+references.length+" ";
			for(ReferenceResponse ref:references){
				cadena=cadena+ref.getAgreement()+" "+ref.getInstitution();
			}
		}
		return cadena;
	}
	
	

}
