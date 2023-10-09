package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.EstadoCuentaConsolidadoDTO;

public class EstadoCuentaConsolidadoListIMPL {
	private static final ILogger logger = LogFactory.getLogger(EstadoCuentaConsolidadoListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<EstadoCuentaConsolidadoDTO> getDetail(ReportResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		ArrayList<EstadoCuentaConsolidadoDTO> dataBeanList = new ArrayList<EstadoCuentaConsolidadoDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getDetail");

			if (reportResponse != null) {
				logger.logDebug("*****>>getDetail - size:" + reportResponse.length);

				if (reportResponse.length > 0) {
					for (int i = 0; i < reportResponse.length; i++) {
						EstadoCuentaConsolidadoDTO estadoCuentaConsolidadoDTO = new EstadoCuentaConsolidadoDTO();
						if (reportResponse[i].getDate() != null) {
							estadoCuentaConsolidadoDTO.setFecha(reportResponse[i].getDate());
						} else {
							estadoCuentaConsolidadoDTO.setFecha("");
						}

						if (reportResponse[i].getClient() != null) {
							estadoCuentaConsolidadoDTO.setCliente(reportResponse[i].getClient());
						} else {
							estadoCuentaConsolidadoDTO.setCliente("");
						}

						estadoCuentaConsolidadoDTO.setIdCliente(reportResponse[i].getCustomerId());
						if (reportResponse[i].getAmountAwarded() != null) {
							estadoCuentaConsolidadoDTO.setOtorgado(reportResponse[i].getAmountAwarded());
						} else {
							estadoCuentaConsolidadoDTO.setOtorgado(0.0);
						}
						if (reportResponse[i].getBalance() != null) {
							estadoCuentaConsolidadoDTO.setSaldoCapital(reportResponse[i].getBalance());
						} else {
							estadoCuentaConsolidadoDTO.setSaldoCapital(0.0);
						}

						if (reportResponse[i].getSaving() != null) {
							estadoCuentaConsolidadoDTO.setAhorros(reportResponse[i].getSaving());
						} else {
							estadoCuentaConsolidadoDTO.setAhorros(0.0);
						}
						if (reportResponse[i].getCapital() != null) {
							estadoCuentaConsolidadoDTO.setCapital(reportResponse[i].getCapital());
						} else {
							estadoCuentaConsolidadoDTO.setCapital(0.0);
						}
						if (reportResponse[i].getOthers() != null) {
							estadoCuentaConsolidadoDTO.setIntOtros(reportResponse[i].getOthers());
						} else {
							estadoCuentaConsolidadoDTO.setIntOtros(0.0);
						}
						if (reportResponse[i].getAmountTotal() != null) {
							estadoCuentaConsolidadoDTO.setTotal(reportResponse[i].getAmountTotal());
						} else {
							estadoCuentaConsolidadoDTO.setTotal(0.0);
						}
						if (reportResponse[i].getCustomerDocumentNumber() != null) {
							estadoCuentaConsolidadoDTO.setNumeroDocCli(reportResponse[i].getCustomerDocumentNumber());
						} else {
							estadoCuentaConsolidadoDTO.setNumeroDocCli("");
						}
						dataBeanList.add(estadoCuentaConsolidadoDTO);
					}
				} else {
					initListDetail(dataBeanList);
				}
			} else {
				logger.logDebug("*****>>getDetail - lista Vacia");
				initListDetail(dataBeanList);
			}
		}
		return dataBeanList;
	}

	private void initListDetail(ArrayList<EstadoCuentaConsolidadoDTO> dataBeanList) {
		EstadoCuentaConsolidadoDTO estadoCuentaConsolidadoDTO = new EstadoCuentaConsolidadoDTO();
		estadoCuentaConsolidadoDTO.setFecha("");
		estadoCuentaConsolidadoDTO.setCliente("");
		estadoCuentaConsolidadoDTO.setIdCliente(0);
		estadoCuentaConsolidadoDTO.setOtorgado(0.0);
		estadoCuentaConsolidadoDTO.setSaldoCapital(0.0);
		estadoCuentaConsolidadoDTO.setAhorros(0.0);
		estadoCuentaConsolidadoDTO.setCapital(0.0);
		estadoCuentaConsolidadoDTO.setIntOtros(0.0);
		estadoCuentaConsolidadoDTO.setTotal(0.0);
		estadoCuentaConsolidadoDTO.setNumeroDocCli("");
		dataBeanList.add(estadoCuentaConsolidadoDTO);
	}

}
