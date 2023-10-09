package com.cobiscorp.mobile.model;

public class OperationCreateResponse {

	private String bank;
	private int error;
	private int operation;
	private String fechaIni;
	private String fechaFin;

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public int getError() {
		return error;
	}

	public void setError(int error) {
		this.error = error;
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public String getFechaIni() {
		return fechaIni;
	}

	public void setFechaIni(String fechaIni) {
		this.fechaIni = fechaIni;
	}

	public String getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(String fechaFin) {
		this.fechaFin = fechaFin;
	}

	@Override
	public String toString() {
		return "OperationCreateResponse{" + "bank='" + bank + '\'' + ", error=" + error + "," + " operation=" + operation + ", fechaIni=" + fechaIni + ", fechaFin=" + fechaFin + '}';
	}
}
