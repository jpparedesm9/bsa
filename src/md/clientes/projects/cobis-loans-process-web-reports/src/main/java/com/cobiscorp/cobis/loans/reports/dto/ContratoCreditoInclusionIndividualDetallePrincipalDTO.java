package com.cobiscorp.cobis.loans.reports.dto;

import java.util.List;

public class ContratoCreditoInclusionIndividualDetallePrincipalDTO {
	private String ciudadOfi;
	private String dia;
	private String mes;
	private String anio;
	private String nombreCliente;
	private List<ContratoCreditoInclusionIndividualDeclaracionDTO> contratoCreditoInclusionDeclaracion;
	private List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionClausula;
	private List<FirmasDTO> cciDetalleFirmaUno;
	private List<FirmasDTO> cciDetalleFirmaDos;
	private String nombreInclusionRepUno;
	private String nombreInclusionRepDos;
	private String nombreBancoRepUno;
	private String nombreBancoRepDos;

	public String getCiudadOfi() {
		return ciudadOfi;
	}

	public void setCiudadOfi(String ciudadOfi) {
		this.ciudadOfi = ciudadOfi;
	}

	public String getDia() {
		return dia;
	}

	public void setDia(String dia) {
		this.dia = dia;
	}

	public String getMes() {
		return mes;
	}

	public void setMes(String mes) {
		this.mes = mes;
	}

	public String getAnio() {
		return anio;
	}

	public void setAnio(String anio) {
		this.anio = anio;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public List<ContratoCreditoInclusionIndividualDeclaracionDTO> getContratoCreditoInclusionDeclaracion() {
		return contratoCreditoInclusionDeclaracion;
	}

	public void setContratoCreditoInclusionDeclaracion(List<ContratoCreditoInclusionIndividualDeclaracionDTO> contratoCreditoInclusionDeclaracion) {
		this.contratoCreditoInclusionDeclaracion = contratoCreditoInclusionDeclaracion;
	}

	public List<ContratoCreditoInclusionClausulaDTO> getContratoCreditoInclusionClausula() {
		return contratoCreditoInclusionClausula;
	}

	public void setContratoCreditoInclusionClausula(List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionClausula) {
		this.contratoCreditoInclusionClausula = contratoCreditoInclusionClausula;
	}

	public List<FirmasDTO> getCciDetalleFirmaUno() {
		return cciDetalleFirmaUno;
	}

	public void setCciDetalleFirmaUno(List<FirmasDTO> cciDetalleFirmaUno) {
		this.cciDetalleFirmaUno = cciDetalleFirmaUno;
	}

	public List<FirmasDTO> getCciDetalleFirmaDos() {
		return cciDetalleFirmaDos;
	}

	public void setCciDetalleFirmaDos(List<FirmasDTO> cciDetalleFirmaDos) {
		this.cciDetalleFirmaDos = cciDetalleFirmaDos;
	}

	public String getNombreInclusionRepUno() {
		return nombreInclusionRepUno;
	}

	public void setNombreInclusionRepUno(String nombreInclusionRepUno) {
		this.nombreInclusionRepUno = nombreInclusionRepUno;
	}

	public String getNombreInclusionRepDos() {
		return nombreInclusionRepDos;
	}

	public void setNombreInclusionRepDos(String nombreInclusionRepDos) {
		this.nombreInclusionRepDos = nombreInclusionRepDos;
	}

	public String getNombreBancoRepUno() {
		return nombreBancoRepUno;
	}

	public void setNombreBancoRepUno(String nombreBancoRepUno) {
		this.nombreBancoRepUno = nombreBancoRepUno;
	}

	public String getNombreBancoRepDos() {
		return nombreBancoRepDos;
	}

	public void setNombreBancoRepDos(String nombreBancoRepDos) {
		this.nombreBancoRepDos = nombreBancoRepDos;
	}

}