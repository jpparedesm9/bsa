package com.cobiscorp.cloud.notificationservice.dto.report;

import java.math.BigDecimal;
import java.util.Date;

public class FichaDePagoMainPDTO {

	private Date FECINICIOCREDITO;
	private String NOMBRECLIENTE;
	private Date FECVIGENCIA;
	private BigDecimal MONTOPAGO;
	private String SUCURSAL;
	private Integer NOPAGO;
	private String PIEPAGINA;

	public Date getFECINICIOCREDITO() {
		return FECINICIOCREDITO;
	}

	public void setFECINICIOCREDITO(Date fECINICIOCREDITO) {
		FECINICIOCREDITO = fECINICIOCREDITO;
	}

	public String getNOMBRECLIENTE() {
		return NOMBRECLIENTE;
	}

	public void setNOMBRECLIENTE(String nOMBRECLIENTE) {
		NOMBRECLIENTE = nOMBRECLIENTE;
	}

	public Date getFECVIGENCIA() {
		return FECVIGENCIA;
	}

	public void setFECVIGENCIA(Date fECVIGENCIA) {
		FECVIGENCIA = fECVIGENCIA;
	}

	public BigDecimal getMONTOPAGO() {
		return MONTOPAGO;
	}

	public void setMONTOPAGO(BigDecimal mONTOPAGO) {
		MONTOPAGO = mONTOPAGO;
	}

	public String getSUCURSAL() {
		return SUCURSAL;
	}

	public void setSUCURSAL(String sUCURSAL) {
		SUCURSAL = sUCURSAL;
	}

	public Integer getNOPAGO() {
		return NOPAGO;
	}

	public void setNOPAGO(Integer nOPAGO) {
		NOPAGO = nOPAGO;
	}

	public String getPIEPAGINA() {
		return PIEPAGINA;
	}

	public void setPIEPAGINA(String pIEPAGINA) {
		PIEPAGINA = pIEPAGINA;
	}

	@Override
	public String toString() {
		return "FichaDePagoMainPDTO [FECINICIOCREDITO=" + FECINICIOCREDITO + ", NOMBRECLIENTE=" + NOMBRECLIENTE + ", FECVIGENCIA=" + FECVIGENCIA + ", MONTOPAGO=" + MONTOPAGO + ", SUCURSAL=" + SUCURSAL + ", NOPAGO=" + NOPAGO + ", PIEPAGINA=" + PIEPAGINA + "]";
	}

}
