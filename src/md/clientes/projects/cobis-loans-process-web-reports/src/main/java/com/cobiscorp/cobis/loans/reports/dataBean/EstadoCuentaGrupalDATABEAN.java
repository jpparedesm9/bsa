package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.EstadoCuentaGrupalDTO;


public class EstadoCuentaGrupalDATABEAN {

	private List<EstadoCuentaGrupalDTO> resumenCredito;
	private List<EstadoCuentaGrupalDTO> planPagos;

	public List<EstadoCuentaGrupalDTO> getResumenCredito() {
		return resumenCredito;
	}

	public void setResumenCredito(List<EstadoCuentaGrupalDTO> resumenCredito) {
		this.resumenCredito = resumenCredito;
	}

	public List<EstadoCuentaGrupalDTO> getPlanPagos() {
		return planPagos;
	}

	public void setPlanPagos(List<EstadoCuentaGrupalDTO> planPagos) {
		this.planPagos = planPagos;
	}

}
