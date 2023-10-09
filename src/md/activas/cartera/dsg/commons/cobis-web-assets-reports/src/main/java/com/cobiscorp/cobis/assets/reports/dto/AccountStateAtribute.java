package com.cobiscorp.cobis.assets.reports.dto;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Map;

public class AccountStateAtribute implements Serializable {

	private Integer sequentialIm;
	private String numBankm;
	private Calendar fechaDatem;

	public Integer getSequentialIm() {
		return sequentialIm;
	}

	public void setSequentialIm(Integer sequentialIm) {
		this.sequentialIm = sequentialIm;
	}

	public String getNumBankm() {
		return numBankm;
	}

	public void setNumBankm(String numBankm) {
		this.numBankm = numBankm;
	}

	public Calendar getFechaDatem() {
		return fechaDatem;
	}

	public void setFechaDatem(Calendar fechaDatem) {
		this.fechaDatem = fechaDatem;
	}

	@Override
	public String toString() {
		return "AccountStateAtribute [sequentialIm=" + sequentialIm
				+ ", numBankm=" + numBankm + ", fechaDatem=" + fechaDatem + "]";
	}

}
