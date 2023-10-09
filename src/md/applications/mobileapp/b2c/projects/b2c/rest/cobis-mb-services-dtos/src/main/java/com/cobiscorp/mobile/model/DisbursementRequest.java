package com.cobiscorp.mobile.model;

public class DisbursementRequest extends BaseRequest {

	private int idTramit;

	public int getIdTramit() {
		return idTramit;
	}

	public void setIdTramit(int idTramit) {
		this.idTramit = idTramit;
	}

	@Override
	public String toString() {
		return "DisbursementRequest [idTramit=" + idTramit + "]";
	}

}
