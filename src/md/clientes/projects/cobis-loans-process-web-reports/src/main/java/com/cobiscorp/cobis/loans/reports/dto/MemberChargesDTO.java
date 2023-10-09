package com.cobiscorp.cobis.loans.reports.dto;

public class MemberChargesDTO {
	private String fechaProceso;
	private String periodicidadPago;
	private String numeroTarjetaCuenta;
	private String claveBancariaEst;
	private String montoMaximoFijo;
	private String fechaVencimiento;
	private String nombreCliente;
	private String numeroCredito;
	private String importeSemanaAPagar;

	public String getFechaProceso() {
		return fechaProceso;
	}

	public void setFechaProceso(String fechaProceso) {
		this.fechaProceso = fechaProceso;
	}

	public String getPeriodicidadPago() {
		return periodicidadPago;
	}

	public void setPeriodicidadPago(String periodicidadPago) {
		this.periodicidadPago = periodicidadPago;
	}

	public String getNumeroTarjetaCuenta() {
		return numeroTarjetaCuenta;
	}

	public void setNumeroTarjetaCuenta(String numeroTarjetaCuenta) {
		this.numeroTarjetaCuenta = numeroTarjetaCuenta;
	}

	public String getClaveBancariaEst() {
		return claveBancariaEst;
	}

	public void setClaveBancariaEst(String claveBancariaEst) {
		this.claveBancariaEst = claveBancariaEst;
	}

	public String getMontoMaximoFijo() {
		return montoMaximoFijo;
	}

	public void setMontoMaximoFijo(String montoMaximoFijo) {
		this.montoMaximoFijo = montoMaximoFijo;
	}

	public String getFechaVencimiento() {
		return fechaVencimiento;
	}

	public void setFechaVencimiento(String fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public String getNumeroCredito() {
		return numeroCredito;
	}

	public void setNumeroCredito(String numeroCredito) {
		this.numeroCredito = numeroCredito;
	}

	public String getImporteSemanaAPagar() {
		return importeSemanaAPagar;
	}

	public void setImporteSemanaAPagar(String importeSemanaAPagar) {
		this.importeSemanaAPagar = importeSemanaAPagar;
	}
	
}
