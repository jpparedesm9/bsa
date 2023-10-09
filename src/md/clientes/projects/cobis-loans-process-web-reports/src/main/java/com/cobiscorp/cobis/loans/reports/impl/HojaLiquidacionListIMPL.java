package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.HojaLiquidacionDTO;

public class HojaLiquidacionListIMPL {
	private static final ILogger logger = LogFactory.getLogger(HojaLiquidacionListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<HojaLiquidacionDTO> getClearanceSheetDetail(ReportResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		ArrayList<HojaLiquidacionDTO> dataBeanList = new ArrayList<HojaLiquidacionDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getClearanceSheetDetail");

			if (reportResponse != null) {
				logger.logDebug("*****>>getClearanceSheetDetail - size:" + reportResponse.length);

				if (reportResponse.length > 0) {
					for (int i = 0; i < reportResponse.length; i++) {
						HojaLiquidacionDTO hojaLiquidacionDTO = new HojaLiquidacionDTO();
						hojaLiquidacionDTO.setNumero(i + 1);
						if (reportResponse[i].getLoan() != null) {
							hojaLiquidacionDTO.setNumPrestamo(reportResponse[i].getLoan());
						} else {
							hojaLiquidacionDTO.setNumPrestamo("");
						}
						if (reportResponse[i].getClient() != null) {
							hojaLiquidacionDTO.setNombreCliente(reportResponse[i].getClient());
						} else {
							hojaLiquidacionDTO.setNombreCliente("");
						}
						if (reportResponse[i].getAmountApproved() != null) {
							hojaLiquidacionDTO.setMontoAprobado(reportResponse[i].getAmountApproved());
						} else {
							hojaLiquidacionDTO.setMontoAprobado(0.0);
						}
						if (reportResponse[i].getValuesDiscounting() != null) {
							hojaLiquidacionDTO.setValoresDescontar(reportResponse[i].getValuesDiscounting());
						} else {
							hojaLiquidacionDTO.setValoresDescontar(0.0);
						}
						if (reportResponse[i].getSaving() != null) {
							hojaLiquidacionDTO.setAhorro(reportResponse[i].getSaving());
						} else {
							hojaLiquidacionDTO.setAhorro(0.0);
						}
						if (reportResponse[i].getIncentive() != null) {
							hojaLiquidacionDTO.setIncentivo(reportResponse[i].getIncentive());
						} else {
							hojaLiquidacionDTO.setIncentivo(0.0);
						}
						if (reportResponse[i].getNetToDeliver() != null) {
							hojaLiquidacionDTO.setNetoEntregar(reportResponse[i].getNetToDeliver());
						} else {
							hojaLiquidacionDTO.setNetoEntregar(0.0);
						}
						if (reportResponse[i].getCheck() != null) {
							hojaLiquidacionDTO.setCheque(reportResponse[i].getCheck());
						} else {
							hojaLiquidacionDTO.setCheque("");
						}

						dataBeanList.add(hojaLiquidacionDTO);
					}
				} else {
					initListgetClearanceSheetDetail(dataBeanList);
				}
			} else {
				logger.logDebug("*****>>getClearanceSheetDetail - lista Vacia");
				initListgetClearanceSheetDetail(dataBeanList);
			}
		}
		return dataBeanList;
	}

	private void initListgetClearanceSheetDetail(ArrayList<HojaLiquidacionDTO> dataBeanList) {
		HojaLiquidacionDTO hojaLiquidacionDTO = new HojaLiquidacionDTO();
		hojaLiquidacionDTO.setNumero(0);
		hojaLiquidacionDTO.setNumPrestamo("");
		hojaLiquidacionDTO.setNombreCliente("");
		hojaLiquidacionDTO.setMontoAprobado(0.0);
		hojaLiquidacionDTO.setValoresDescontar(0.0);
		hojaLiquidacionDTO.setAhorro(0.0);
		hojaLiquidacionDTO.setIncentivo(0.0);
		hojaLiquidacionDTO.setNetoEntregar(0.0);
		hojaLiquidacionDTO.setCheque("");
		dataBeanList.add(hojaLiquidacionDTO);
	}

}
