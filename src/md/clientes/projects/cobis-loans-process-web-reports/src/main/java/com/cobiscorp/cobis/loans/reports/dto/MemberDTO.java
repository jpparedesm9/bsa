package com.cobiscorp.cobis.loans.reports.dto;

import java.util.List;

public class MemberDTO {
	private String nombresMiembro;
	private String porcentajeAnual;
	private String monto;
	private String montoLetras;
	private String fechaLetras;
	private String direccion;
	private List<CreditPaymentsDTO> listaPagos;
	public String getNombresMiembro() {
		return nombresMiembro;
	}
	public void setNombresMiembro(String nombresMiembro) {
		this.nombresMiembro = nombresMiembro;
	}
	public String getPorcentajeAnual() {
		return porcentajeAnual;
	}
	public void setPorcentajeAnual(String porcentajeAnual) {
		this.porcentajeAnual = porcentajeAnual;
	}
	public String getMonto() {
		return monto;
	}
	public void setMonto(String monto) {
		this.monto = monto;
	}
	public String getMontoLetras() {
		return montoLetras;
	}
	public void setMontoLetras(String montoLetras) {
		this.montoLetras = montoLetras;
	}
	public String getFechaLetras() {
		return fechaLetras;
	}
	public void setFechaLetras(String fechaLetras) {
		this.fechaLetras = fechaLetras;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public List<CreditPaymentsDTO> getListaPagos() {
		return listaPagos;
	}
	public void setListaPagos(List<CreditPaymentsDTO> listaPagos) {
		this.listaPagos = listaPagos;
	}
	
}
