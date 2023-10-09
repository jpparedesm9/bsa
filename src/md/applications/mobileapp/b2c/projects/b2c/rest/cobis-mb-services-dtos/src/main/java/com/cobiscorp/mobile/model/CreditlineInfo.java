/*
 * Crédito en Línea
 * Servicios para aplicación de crédito en    
 *
 * OpenAPI spec version: 1.0.0
 * Contact: pablo.lopez@ndeveloper.com
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */

package com.cobiscorp.mobile.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * LoanDataCreditlineInfo
 */
public class CreditlineInfo {

	private BigDecimal lineaCredito = null;

	private BigDecimal utilizado = null;

	private BigDecimal pagoSinIntereses = null;

	private BigDecimal pagoMinimo = null;

	private String referenciaDePago = null;

	private String fechaPago = null;

	private String ultimoAcceso = null;
	
	private String convenio = null;
	
	private String prestamo = null;
	
	private int instanciaProceso = 0;
			
	private Double porcentajeCumpl = null;

	private BigDecimal disponible = null;
	
	
	private List<CreditlineDetail> details = new ArrayList<CreditlineDetail>();

	public CreditlineInfo lineaCredito(BigDecimal lineaCredito) {
		this.lineaCredito = lineaCredito;
		return this;
	}

	/**
	 * Get lineaCredito
	 * 
	 * @return lineaCredito
	 **/
	public BigDecimal getLineaCredito() {
		return lineaCredito;
	}

	public void setLineaCredito(BigDecimal lineaCredito) {
		this.lineaCredito = lineaCredito;
	}

	public CreditlineInfo utilizado(BigDecimal utilizado) {
		this.utilizado = utilizado;
		return this;
	}

	/**
	 * Get utilizado
	 * 
	 * @return utilizado
	 **/
	public BigDecimal getUtilizado() {
		return utilizado;
	}

	public void setUtilizado(BigDecimal utilizado) {
		this.utilizado = utilizado;
	}

	public CreditlineInfo pagoSinIntereses(BigDecimal pagoSinIntereses) {
		this.pagoSinIntereses = pagoSinIntereses;
		return this;
	}

	/**
	 * Get pagoSinIntereses
	 * 
	 * @return pagoSinIntereses
	 **/
	public BigDecimal getPagoSinIntereses() {
		return pagoSinIntereses;
	}

	public void setPagoSinIntereses(BigDecimal pagoSinIntereses) {
		this.pagoSinIntereses = pagoSinIntereses;
	}

	public CreditlineInfo pagoMinimo(BigDecimal pagoMinimo) {
		this.pagoMinimo = pagoMinimo;
		return this;
	}

	/**
	 * Get pagoMinimo
	 * 
	 * @return pagoMinimo
	 **/
	public BigDecimal getPagoMinimo() {
		return pagoMinimo;
	}

	public void setPagoMinimo(BigDecimal pagoMinimo) {
		this.pagoMinimo = pagoMinimo;
	}

	public CreditlineInfo referenciaDePago(String referenciaDePago) {
		this.referenciaDePago = referenciaDePago;
		return this;
	}

	/**
	 * Get referenciaDePago
	 * 
	 * @return referenciaDePago
	 **/
	public String getReferenciaDePago() {
		return referenciaDePago;
	}

	public void setReferenciaDePago(String referenciaDePago) {
		this.referenciaDePago = referenciaDePago;
	}

	/**
	 * Get ultimoAcceso
	 * 
	 * @return ultimoAcceso
	 **/
	public String getUltimoAcceso() {
		return ultimoAcceso;
	}

	public void setUltimoAcceso(String ultimoAcceso) {
		this.ultimoAcceso = ultimoAcceso;
	}

	public String getFechaPago() {
		return fechaPago;
	}

	public void setFechaPago(String fechaPago) {
		this.fechaPago = fechaPago;
	}
	
	public String getPrestamo() {
		return prestamo;
	}

	public void setPrestamo(String prestamo) {
		this.prestamo = prestamo;
	}

	public int getInstanciaProceso() {
		return instanciaProceso;
	}

	public void setInstanciaProceso(int instanciaProceso) {
		this.instanciaProceso = instanciaProceso;
	}

	public Double getPorcentajeCumpl() {
		return porcentajeCumpl;
	}

	public void setPorcentajeCumpl(Double porcentajeCumpl) {
		this.porcentajeCumpl = porcentajeCumpl;
	}

	public String getConvenio() {
		return convenio;
	}

	public void setConvenio(String convenio) {
		this.convenio = convenio;
	}

	public List<CreditlineDetail> getDetails() {
		return details;
	}

	public void setDetails(List<CreditlineDetail> details) {
		this.details = details;
	}

	public BigDecimal getDisponible() {
		return disponible;
	}

	public void setDisponible(BigDecimal disponible) {
		this.disponible = disponible;
	}	

	@Override
	public boolean equals(java.lang.Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		CreditlineInfo loanDataCreditlineInfo = (CreditlineInfo) o;
		return Objects.equals(this.lineaCredito, loanDataCreditlineInfo.lineaCredito) && Objects.equals(this.utilizado, loanDataCreditlineInfo.utilizado)
				&& Objects.equals(this.pagoSinIntereses, loanDataCreditlineInfo.pagoSinIntereses) && Objects.equals(this.pagoMinimo, loanDataCreditlineInfo.pagoMinimo)
				&& Objects.equals(this.referenciaDePago, loanDataCreditlineInfo.referenciaDePago) && Objects.equals(this.ultimoAcceso, loanDataCreditlineInfo.ultimoAcceso)
				&& Objects.equals(this.convenio, loanDataCreditlineInfo.convenio) && Objects.equals(this.prestamo, loanDataCreditlineInfo.prestamo)
				&& Objects.equals(this.instanciaProceso, loanDataCreditlineInfo.instanciaProceso)&& Objects.equals(this.porcentajeCumpl, loanDataCreditlineInfo.porcentajeCumpl)
				&& Objects.equals(this.disponible, loanDataCreditlineInfo.disponible);
	}

	@Override
	public int hashCode() {
		return Objects.hash(lineaCredito, utilizado, pagoSinIntereses, pagoMinimo, referenciaDePago, ultimoAcceso, convenio, prestamo, instanciaProceso, porcentajeCumpl, disponible);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class LoanDataCreditlineInfo {\n");

		sb.append("    lineaCredito: ").append(toIndentedString(lineaCredito)).append("\n");
		sb.append("    utilizado: ").append(toIndentedString(utilizado)).append("\n");
		sb.append("    pagoSinIntereses: ").append(toIndentedString(pagoSinIntereses)).append("\n");
		sb.append("    pagoMinimo: ").append(toIndentedString(pagoMinimo)).append("\n");
		sb.append("    referenciaDePago: ").append(toIndentedString(referenciaDePago)).append("\n");
		sb.append("    ultimoAcceso: ").append(toIndentedString(ultimoAcceso)).append("\n");
		sb.append("    convenio: ").append(toIndentedString(convenio)).append("\n");
		sb.append("    prestamo: ").append(toIndentedString(prestamo)).append("\n");
		sb.append("    instanciaProceso: ").append(toIndentedString(instanciaProceso)).append("\n");
		sb.append("    porcetajeCumpl: ").append(toIndentedString(porcentajeCumpl)).append("\n");
		sb.append("    disponible: ").append(toIndentedString(disponible)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}
	
	
}