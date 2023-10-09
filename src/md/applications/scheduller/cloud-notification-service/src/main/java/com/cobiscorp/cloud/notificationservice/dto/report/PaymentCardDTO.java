package com.cobiscorp.cloud.notificationservice.dto.report;


import java.util.List;

import com.cobiscorp.cloud.notificationservice.dto.FichasPagoLCR;

public class PaymentCardDTO {
	
	FichasPagoLCR.FichaPago fichaPago;
	List<FichasPagoLCR.FichaPago.Referencia> referencias;
	
	public PaymentCardDTO() {
	}
	public PaymentCardDTO(FichasPagoLCR.FichaPago fichaPago, List<FichasPagoLCR.FichaPago.Referencia> referencias) {
		super();
		this.fichaPago = fichaPago;
		this.referencias = referencias;
	}
	public FichasPagoLCR.FichaPago getFichaPago() {
		return fichaPago;
	}
	public void setFichaPago(FichasPagoLCR.FichaPago fichaPago) {
		this.fichaPago = fichaPago;
	}
	public List<FichasPagoLCR.FichaPago.Referencia> getReferencias() {
		return referencias;
	}
	public void setReferencias(List<FichasPagoLCR.FichaPago.Referencia> referencias) {
		this.referencias = referencias;
	}
	
	

}
