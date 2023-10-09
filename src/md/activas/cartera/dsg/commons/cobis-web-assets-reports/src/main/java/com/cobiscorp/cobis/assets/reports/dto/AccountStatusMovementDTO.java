package com.cobiscorp.cobis.assets.reports.dto;

public class AccountStatusMovementDTO {

	private Integer numero;
	private String fechaOperacion;
	private String fechaPactada;
	private Integer numPago;
	private Integer diasAtraso;
	private String detalleMovimiento;
	private Double total;
	private Double capital;
	private Double interesOrdinario;
	private Double comisionGastoCobranza;
	private Double ivaInt;
	private Double ivaMora;
	private Double otros;
	private Double saldoInsoluto;

	public Integer getNumero() {
		return numero;
	}

	public void setNumero(Integer numero) {
		this.numero = numero;
	}

	public String getFechaOperacion() {
		return fechaOperacion;
	}

	public void setFechaOperacion(String fechaOperacion) {
		this.fechaOperacion = fechaOperacion;
	}

	public String getFechaPactada() {
		return fechaPactada;
	}

	public void setFechaPactada(String fechaPactada) {
		this.fechaPactada = fechaPactada;
	}

	public Integer getNumPago() {
		return numPago;
	}

	public void setNumPago(Integer numPago) {
		this.numPago = numPago;
	}

	public Integer getDiasAtraso() {
		return diasAtraso;
	}

	public void setDiasAtraso(Integer diasAtraso) {
		this.diasAtraso = diasAtraso;
	}

	public String getDetalleMovimiento() {
		return detalleMovimiento;
	}

	public void setDetalleMovimiento(String detalleMovimiento) {
		this.detalleMovimiento = detalleMovimiento;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public Double getCapital() {
		return capital;
	}

	public void setCapital(Double capital) {
		this.capital = capital;
	}

	public Double getInteresOrdinario() {
		return interesOrdinario;
	}

	public void setInteresOrdinario(Double interesOrdinario) {
		this.interesOrdinario = interesOrdinario;
	}

	public Double getComisionGastoCobranza() {
		return comisionGastoCobranza;
	}

	public void setComisionGastoCobranza(Double comisionGastoCobranza) {
		this.comisionGastoCobranza = comisionGastoCobranza;
	}

	public Double getIvaInt() {
		return ivaInt;
	}

	public void setIvaInt(Double ivaInt) {
		this.ivaInt = ivaInt;
	}

	public Double getIvaMora() {
		return ivaMora;
	}

	public void setIvaMora(Double ivaMora) {
		this.ivaMora = ivaMora;
	}

	public Double getOtros() {
		return otros;
	}

	public void setOtros(Double otros) {
		this.otros = otros;
	}

	public Double getSaldoInsoluto() {
		return saldoInsoluto;
	}

	public void setSaldoInsoluto(Double saldoInsoluto) {
		this.saldoInsoluto = saldoInsoluto;
	}

}
