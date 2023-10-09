package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ConsentCertificateResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.AutorizacionCargoDetalleDTO;

public class AutorizacionCargoListIMPL {
	private static final ILogger logger = LogFactory.getLogger(AutorizacionCargoListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<AutorizacionCargoDetalleDTO> getDetalle(ConsentCertificateResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<AutorizacionCargoDetalleDTO> dataBeanList = new ArrayList<AutorizacionCargoDetalleDTO>();
		logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia getDetalle");

		try {
			if (reportResponse != null) {
				if (reportResponse.length > 0) {
					for (ConsentCertificateResponse report : reportResponse) {
						AutorizacionCargoDetalleDTO autorizacionDetalleDTO = new AutorizacionCargoDetalleDTO();
						logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia getDetalle - report.getName(:" + report.getName());
						autorizacionDetalleDTO.setPolicy(report.getPolicy());
						autorizacionDetalleDTO.setCertificateNumber(report.getCertificateNumber());
						autorizacionDetalleDTO.setName(report.getName());
						autorizacionDetalleDTO.setBirthdate(report.getBirthdate());
						autorizacionDetalleDTO.setAddress(report.getAddress());
						autorizacionDetalleDTO.setRfc(report.getRfc());
						autorizacionDetalleDTO.setStartValidity(report.getStartValidity());
						autorizacionDetalleDTO.setTermValidity(report.getTermValidity());
						autorizacionDetalleDTO.setInsuranceCost(report.getInsuranceCost());
						autorizacionDetalleDTO.setAccount(report.getAccount());

						dataBeanList.add(autorizacionDetalleDTO);
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

	private void initDetalle(List<AutorizacionCargoDetalleDTO> dataBeanList) {
		logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia initDetalle");
		AutorizacionCargoDetalleDTO autorizacionDetalleDTO = new AutorizacionCargoDetalleDTO();
		autorizacionDetalleDTO.setPolicy("");
		autorizacionDetalleDTO.setCertificateNumber("");
		autorizacionDetalleDTO.setName("");
		autorizacionDetalleDTO.setBirthdate("");
		autorizacionDetalleDTO.setAddress("");
		autorizacionDetalleDTO.setRfc("");
		autorizacionDetalleDTO.setStartValidity("");
		autorizacionDetalleDTO.setTermValidity("");
		autorizacionDetalleDTO.setInsuranceCost("");
		autorizacionDetalleDTO.setAccount("");

		dataBeanList.add(autorizacionDetalleDTO);
	}

}
