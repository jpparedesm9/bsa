package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dataBean.TablaSimulacionDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.TablaSimulacionDetalleDTO;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovatioResponse;

public class DataBeanTablaSimulacionListIMPL {
	private static final ILogger logger = LogFactory.getLogger(DataBeanTablaSimulacionListIMPL.class);
	@Reference
	private static ICTSServiceIntegration serviceIntegration;

	public static TablaSimulacionDATABEAN dataContenido() {
		TablaSimulacionDATABEAN tablaSimulacionDatabean = new TablaSimulacionDATABEAN();
		List<TablaSimulacionDetalleDTO> tablaSimualcionDTO = new ArrayList<TablaSimulacionDetalleDTO>();
		tablaSimulacionDatabean.setTablaSimulacion(tablaSimualcionDTO);
		return tablaSimulacionDatabean;
	}

	public static List<TablaSimulacionDetalleDTO> getDataBeanList(SimulationCreditRenovatioResponse[] refTablaSimulacion) {
		List<TablaSimulacionDetalleDTO> dataBeanList = new ArrayList<TablaSimulacionDetalleDTO>();
		logger.logDebug("----->>>Inicio metodo --getDataBeanList -- refTablaAmortizacionP:" + refTablaSimulacion);
		if (refTablaSimulacion != null) {
			for (int i = 0; i < refTablaSimulacion.length; i++) {
				TablaSimulacionDetalleDTO tablaSimulacionDetalleDTO = new TablaSimulacionDetalleDTO();
				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getDividend:" + refTablaSimulacion[i].getDividendo());
				tablaSimulacionDetalleDTO.setDividend(refTablaSimulacion[i].getDividendo());
				tablaSimulacionDetalleDTO.setExpirationDate(refTablaSimulacion[i].getFecha());
				tablaSimulacionDetalleDTO.setCreditCapital(refTablaSimulacion[i].getCapital());
				tablaSimulacionDetalleDTO.setOrdinarInterest(refTablaSimulacion[i].getInteres());
				tablaSimulacionDetalleDTO.setIvaInterest(refTablaSimulacion[i].getIva());
				tablaSimulacionDetalleDTO.setSaldoInsoCap(refTablaSimulacion[i].getSaldo());
				tablaSimulacionDetalleDTO.setMontoPago(refTablaSimulacion[i].getTotal());
				dataBeanList.add(tablaSimulacionDetalleDTO);
			}
		}
		return dataBeanList;
	}

}
