package com.cobiscorp.cloud.notificationservice.dto.report;

import java.math.BigDecimal;

public class AccountStatusMovementTotalDTO {

	private Double capital;
	private Double interes;
	private Double iva;
	private Double pagos;
	private Double importeTotal;
	private String tipoComision;
	private String fechaComision;
	private Double gastosCobranza;
	private Double ivaGastosCobranza;
	private int    numeroDisposiciones;
	private Double importeDisposiciones;
	private Double importeToComCobranza;
	private String fechaUlCobroCobranza;
	private Double comisionCobranza;
	private Double importeToComDisposicion;
	private String fechaUlCobroDisposicion;
	private Double comisionDisposicion;
	
	
	
	public Double getCapital() {
		return capital;
	}
	public void setCapital(Double capital) {
		this.capital = capital;
	}
	public Double getInteres() {
		return interes;
	}
	public void setInteres(Double interes) {
		this.interes = interes;
	}
	public Double getIva() {
		return iva;
	}
	public void setIva(Double iva) {
		this.iva = iva;
	}
	public Double getPagos() {
		return pagos;
	}
	public void setPagos(Double pagos) {
		this.pagos = pagos;
	}
	public Double getImporteTotal() {
		return importeTotal;
	}
	public void setImporteTotal(Double importeTotal) {
		this.importeTotal = importeTotal;
	}
	public String getTipoComision() {
		return tipoComision;
	}
	public void setTipoComision(String tipoComision) {
		this.tipoComision = tipoComision;
	}
	public String getFechaComision() {
		return fechaComision;
	}
	public void setFechaComision(String fechaComision) {
		this.fechaComision = fechaComision;
	}
	public Double getGastosCobranza() {
		return gastosCobranza;
	}
	public void setGastosCobranza(Double gastosCobranza) {
		this.gastosCobranza = gastosCobranza;
	}
	public Double getIvaGastosCobranza() {
		return ivaGastosCobranza;
	}
	public void setIvaGastosCobranza(Double ivaGastosCobranza) {
		this.ivaGastosCobranza = ivaGastosCobranza;
	}
	public int getNumeroDisposiciones() {
		return numeroDisposiciones;
	}
	public void setNumeroDisposiciones(int numeroDisposiciones) {
		this.numeroDisposiciones = numeroDisposiciones;
	}
	public Double getImporteDisposiciones() {
		return importeDisposiciones;
	}
	public void setImporteDisposiciones(Double importeDisposiciones) {
		this.importeDisposiciones = importeDisposiciones;
	}
	public Double getImporteToComCobranza() {
		return importeToComCobranza;
	}
	public void setImporteToComCobranza(Double importeToComCobranza) {
		this.importeToComCobranza = importeToComCobranza;
	}
	public String getFechaUlCobroCobranza() {
		return fechaUlCobroCobranza;
	}
	public void setFechaUlCobroCobranza(String fechaUlCobroCobranza) {
		this.fechaUlCobroCobranza = fechaUlCobroCobranza;
	}
	public Double getComisionCobranza() {
		return comisionCobranza;
	}
	public void setComisionCobranza(Double comisionCobranza) {
		this.comisionCobranza = comisionCobranza;
	}
	public Double getImporteToComDisposicion() {
		return importeToComDisposicion;
	}
	public void setImporteToComDisposicion(Double importeToComDisposicion) {
		this.importeToComDisposicion = importeToComDisposicion;
	}
	public String getFechaUlCobroDisposicion() {
		return fechaUlCobroDisposicion;
	}
	public void setFechaUlCobroDisposicion(String fechaUlCobroDisposicion) {
		this.fechaUlCobroDisposicion = fechaUlCobroDisposicion;
	}
	public Double getComisionDisposicion() {
		return comisionDisposicion;
	}
	public void setComisionDisposicion(Double comisionDisposicion) {
		this.comisionDisposicion = comisionDisposicion;
	}
	
	

}
