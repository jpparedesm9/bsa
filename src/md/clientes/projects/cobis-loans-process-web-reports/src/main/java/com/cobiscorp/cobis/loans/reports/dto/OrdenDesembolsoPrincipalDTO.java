package com.cobiscorp.cobis.loans.reports.dto;

import java.util.List;

public class OrdenDesembolsoPrincipalDTO {

	private String numRuc;
	private String sucursal;
	private String fechaSistema;
	private String recibo;
	private String numOperacion;
	private String deudorPrincipal;
	private String grupo;
	private String identificacion;
	private String fechaLiquidacion;
	private String fechaDesembolso;
	private String telefonoOD;
	private String fechaOD;

	private List<OrdenDesembolsoDTO> moneyDescription;

	public String getNumRuc() {
		return numRuc;
	}

	public void setNumRuc(String numRuc) {
		this.numRuc = numRuc;
	}

	public String getSucursal() {
		return sucursal;
	}

	public void setSucursal(String sucursal) {
		this.sucursal = sucursal;
	}

	public String getFechaSistema() {
		return fechaSistema;
	}

	public void setFechaSistema(String fechaSistema) {
		this.fechaSistema = fechaSistema;
	}

	public String getRecibo() {
		return recibo;
	}

	public void setRecibo(String recibo) {
		this.recibo = recibo;
	}

	public String getNumOperacion() {
		return numOperacion;
	}

	public void setNumOperacion(String numOperacion) {
		this.numOperacion = numOperacion;
	}

	public String getDeudorPrincipal() {
		return deudorPrincipal;
	}

	public void setDeudorPrincipal(String deudorPrincipal) {
		this.deudorPrincipal = deudorPrincipal;
	}

	public String getGrupo() {
		return grupo;
	}

	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}

	public String getIdentificacion() {
		return identificacion;
	}

	public void setIdentificacion(String identificacion) {
		this.identificacion = identificacion;
	}

	public String getFechaLiquidacion() {
		return fechaLiquidacion;
	}

	public void setFechaLiquidacion(String fechaLiquidacion) {
		this.fechaLiquidacion = fechaLiquidacion;
	}

	public String getFechaDesembolso() {
		return fechaDesembolso;
	}

	public void setFechaDesembolso(String fechaDesembolso) {
		this.fechaDesembolso = fechaDesembolso;
	}

	public String getTelefonoOD() {
		return telefonoOD;
	}

	public void setTelefonoOD(String telefonoOD) {
		this.telefonoOD = telefonoOD;
	}

	public String getFechaOD() {
		return fechaOD;
	}

	public void setFechaOD(String fechaOD) {
		this.fechaOD = fechaOD;
	}

	public List<OrdenDesembolsoDTO> getMoneyDescription() {
		return moneyDescription;
	}

	public void setMoneyDescription(List<OrdenDesembolsoDTO> moneyDescription) {
		this.moneyDescription = moneyDescription;
	}

}