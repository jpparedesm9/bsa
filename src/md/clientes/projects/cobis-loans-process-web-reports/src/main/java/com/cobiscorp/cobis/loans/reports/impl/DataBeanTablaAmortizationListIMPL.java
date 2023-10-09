package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dataBean.TablaAmortizationDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.TablaAmortizacionDetalleDTO;

public class DataBeanTablaAmortizationListIMPL {
	private static final ILogger logger = LogFactory.getLogger(DataBeanTablaAmortizationListIMPL.class);
	@Reference
	private static ICTSServiceIntegration serviceIntegration;

	public static TablaAmortizationDATABEAN dataContenido() {
		TablaAmortizationDATABEAN tablaAmortizacionDetalleDTO = new TablaAmortizationDATABEAN();
		List<TablaAmortizacionDetalleDTO> tablaAmortizacionDTO = new ArrayList<TablaAmortizacionDetalleDTO>();
		tablaAmortizacionDetalleDTO.setTablaAmortizacion(tablaAmortizacionDTO);
		return tablaAmortizacionDetalleDTO;
	}

	public static List<TablaAmortizacionDetalleDTO> getDataBeanList(ReportResponse[] refTablaAmortizacionP) {
		List<TablaAmortizacionDetalleDTO> dataBeanList = new ArrayList<TablaAmortizacionDetalleDTO>();
		logger.logDebug("----->>>Inicio metodo --getDataBeanList -- refTablaAmortizacionP:" + refTablaAmortizacionP);
		if (refTablaAmortizacionP != null) {
			for (int i = 0; i < refTablaAmortizacionP.length; i++) {
				TablaAmortizacionDetalleDTO tablaAmortizacionDetalleDTO = new TablaAmortizacionDetalleDTO();
				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getDividend:" + refTablaAmortizacionP[i].getDividend());
				tablaAmortizacionDetalleDTO.setDividend(refTablaAmortizacionP[i].getDividend());
				tablaAmortizacionDetalleDTO.setExpirationDate(refTablaAmortizacionP[i].getExpirationDate());
				tablaAmortizacionDetalleDTO.setOrdinarInterest(refTablaAmortizacionP[i].getInterest());
				tablaAmortizacionDetalleDTO.setInterestIVA(refTablaAmortizacionP[i].getInterestIVA());
				tablaAmortizacionDetalleDTO.setAbonoPrincipal(refTablaAmortizacionP[i].getCapital());
				tablaAmortizacionDetalleDTO.setSaldoInsoCap(refTablaAmortizacionP[i].getCapitalBalance());
				tablaAmortizacionDetalleDTO.setMontoPago(refTablaAmortizacionP[i].getQuota());
				dataBeanList.add(tablaAmortizacionDetalleDTO);
			}
		}
		return dataBeanList;
	}

}
