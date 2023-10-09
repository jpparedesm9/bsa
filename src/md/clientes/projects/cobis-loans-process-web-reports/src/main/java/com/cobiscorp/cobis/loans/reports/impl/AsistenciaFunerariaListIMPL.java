package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ConsentCertificateResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.AsistenciaFunerariaDetalleDTO;

public class AsistenciaFunerariaListIMPL {
	private static final ILogger logger = LogFactory.getLogger(AsistenciaFunerariaListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<AsistenciaFunerariaDetalleDTO> getDetalle(ConsentCertificateResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<AsistenciaFunerariaDetalleDTO> dataBeanList = new ArrayList<AsistenciaFunerariaDetalleDTO>();
		logger.logError("*****>>Certificado - AsistenciaFunerariaListIMPL - Inicia getDetalle");

		try {
			if (reportResponse != null) {
				if (reportResponse.length > 0) {
					for (ConsentCertificateResponse report : reportResponse) {
						AsistenciaFunerariaDetalleDTO certificadoDetalleDTO = new AsistenciaFunerariaDetalleDTO();
						logger.logError("*****>>Certificado - AsistenciaFunerariaListIMPL - Inicia getDetalle - report.getName(:" + report.getName());
						certificadoDetalleDTO.setCertificateNumber(report.getCertificateNumber());
						certificadoDetalleDTO.setName(report.getName());
						certificadoDetalleDTO.setRfc(report.getRfc());

						dataBeanList.add(certificadoDetalleDTO);
					}
				} else {
					this.initDetalle(dataBeanList);
				}
			} else {
				this.initDetalle(dataBeanList);
			}

		} catch (Exception e) {
			logger.logError("*****>>Certificado - Error getDetalle", e);
		}
		return dataBeanList;
	}

	private void initDetalle(List<AsistenciaFunerariaDetalleDTO> dataBeanList) {
		logger.logError("*****>>Certificado - AsistenciaFunerariaListIMPL - Inicia initDetalle");
		AsistenciaFunerariaDetalleDTO certificadoDetalleDTO = new AsistenciaFunerariaDetalleDTO();
		certificadoDetalleDTO.setCertificateNumber("");
		certificadoDetalleDTO.setName("");
		certificadoDetalleDTO.setRfc("");

		dataBeanList.add(certificadoDetalleDTO);
	}

}
