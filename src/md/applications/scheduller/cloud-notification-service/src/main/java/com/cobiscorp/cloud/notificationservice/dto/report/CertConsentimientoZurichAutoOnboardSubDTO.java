package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class CertConsentimientoZurichAutoOnboardSubDTO {

	private String nombre;
	private String rfc;
	private String fechanac;
	private String domicilio;
	private String colonia;
	private String cp;
	private String email;
	private String certificado;
	private String fechaini;
	private String fechafin;
	private String poliza;
	private String contratante;
	private String rfccontratante;
	private String razonsocial;
	private Double primaneta;
	private Double derechopoliza;
	private Double recargopago;
	private Double primatotal;
	private String fechaemi;
	private Integer cliente;
	private List<CertConsentimientoZurichAutoOnboardSubBeneficiary> beneficiaryList;

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public String getFechanac() {
		return fechanac;
	}

	public void setFechanac(String fechanac) {
		this.fechanac = fechanac;
	}

	public String getDomicilio() {
		return domicilio;
	}

	public void setDomicilio(String domicilio) {
		this.domicilio = domicilio;
	}

	public String getColonia() {
		return colonia;
	}

	public void setColonia(String colonia) {
		this.colonia = colonia;
	}

	public String getCp() {
		return cp;
	}

	public void setCp(String cp) {
		this.cp = cp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCertificado() {
		return certificado;
	}

	public void setCertificado(String certificado) {
		this.certificado = certificado;
	}

	public String getFechaini() {
		return fechaini;
	}

	public void setFechaini(String fechaini) {
		this.fechaini = fechaini;
	}

	public String getFechafin() {
		return fechafin;
	}

	public void setFechafin(String fechafin) {
		this.fechafin = fechafin;
	}

	public String getPoliza() {
		return poliza;
	}

	public void setPoliza(String poliza) {
		this.poliza = poliza;
	}

	public String getContratante() {
		return contratante;
	}

	public void setContratante(String contratante) {
		this.contratante = contratante;
	}

	public String getRfccontratante() {
		return rfccontratante;
	}

	public void setRfccontratante(String rfccontratante) {
		this.rfccontratante = rfccontratante;
	}

	public String getRazonsocial() {
		return razonsocial;
	}

	public void setRazonsocial(String razonsocial) {
		this.razonsocial = razonsocial;
	}

	public Double getPrimaneta() {
		return primaneta;
	}

	public void setPrimaneta(Double primaneta) {
		this.primaneta = primaneta;
	}

	public Double getDerechopoliza() {
		return derechopoliza;
	}

	public void setDerechopoliza(Double derechopoliza) {
		this.derechopoliza = derechopoliza;
	}

	public Double getRecargopago() {
		return recargopago;
	}

	public void setRecargopago(Double recargopago) {
		this.recargopago = recargopago;
	}

	public Double getPrimatotal() {
		return primatotal;
	}

	public void setPrimatotal(Double primatotal) {
		this.primatotal = primatotal;
	}

	public String getFechaemi() {
		return fechaemi;
	}

	public void setFechaemi(String fechaemi) {
		this.fechaemi = fechaemi;
	}

	public Integer getCliente() {
		return cliente;
	}

	public void setCliente(Integer cliente) {
		this.cliente = cliente;
	}

	public List<CertConsentimientoZurichAutoOnboardSubBeneficiary> getBeneficiaryList() {
		return beneficiaryList;
	}

	public void setBeneficiaryList(List<CertConsentimientoZurichAutoOnboardSubBeneficiary> beneficiaryList) {
		this.beneficiaryList = beneficiaryList;
	}

	@Override
	public String toString() {
		return "CertConsentimientoZurichAutoOnboardSubDTO [nombre=" + nombre + ", rfc=" + rfc + ", fechanac=" + fechanac
				+ ", domicilio=" + domicilio + ", colonia=" + colonia + ", cp=" + cp + ", email=" + email
				+ ", certificado=" + certificado + ", fechaini=" + fechaini + ", fechafin=" + fechafin + ", poliza="
				+ poliza + ", contratante=" + contratante + ", rfccontratante=" + rfccontratante + ", razonsocial="
				+ razonsocial + ", primaneta=" + primaneta + ", derechopoliza=" + derechopoliza + ", recargopago="
				+ recargopago + ", primatotal=" + primatotal + ", fechaemi=" + fechaemi + ", cliente=" + cliente
				+ ", beneficiaryList=" + beneficiaryList + ", getNombre()=" + getNombre() + ", getRfc()=" + getRfc()
				+ ", getFechanac()=" + getFechanac() + ", getDomicilio()=" + getDomicilio() + ", getColonia()="
				+ getColonia() + ", getCp()=" + getCp() + ", getEmail()=" + getEmail() + ", getCertificado()="
				+ getCertificado() + ", getFechaini()=" + getFechaini() + ", getFechafin()=" + getFechafin()
				+ ", getPoliza()=" + getPoliza() + ", getContratante()=" + getContratante() + ", getRfccontratante()="
				+ getRfccontratante() + ", getRazonsocial()=" + getRazonsocial() + ", getPrimaneta()=" + getPrimaneta()
				+ ", getDerechopoliza()=" + getDerechopoliza() + ", getRecargopago()=" + getRecargopago()
				+ ", getPrimatotal()=" + getPrimatotal() + ", getFechaemi()=" + getFechaemi() + ", getCliente()="
				+ getCliente() + ", getBeneficiaryList()=" + getBeneficiaryList() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

}
