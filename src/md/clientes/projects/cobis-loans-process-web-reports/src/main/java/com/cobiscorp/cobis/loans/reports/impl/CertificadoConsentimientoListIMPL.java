package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ConsentCertificateResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.CertificadoConsentimientoDetalleDTO;

public class CertificadoConsentimientoListIMPL {
	private static final ILogger logger = LogFactory.getLogger(CertificadoConsentimientoListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<CertificadoConsentimientoDetalleDTO> getDetalle(ConsentCertificateResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<CertificadoConsentimientoDetalleDTO> dataBeanList = new ArrayList<CertificadoConsentimientoDetalleDTO>();
		logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia getDetalle");

		try {
			if (reportResponse != null) {
				if (reportResponse.length > 0) {
					for (ConsentCertificateResponse report : reportResponse) {
						CertificadoConsentimientoDetalleDTO certificadoDetalleDTO = new CertificadoConsentimientoDetalleDTO();
						logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia getDetalle - report.getName(:" + report.getName());
						certificadoDetalleDTO.setPolicy(report.getPolicy());
						certificadoDetalleDTO.setCertificateNumber(report.getCertificateNumber());
						certificadoDetalleDTO.setName(report.getName());
						certificadoDetalleDTO.setBirthdate(report.getBirthdate());
						certificadoDetalleDTO.setAddress(report.getAddress());
						certificadoDetalleDTO.setRfc(report.getRfc());
						certificadoDetalleDTO.setStartDay(report.getStartDay());
						certificadoDetalleDTO.setStartMonth(report.getStartMonth());
						certificadoDetalleDTO.setStartYear(report.getStartYear());
						certificadoDetalleDTO.setFinishDay(report.getFinishDay());
						certificadoDetalleDTO.setFinishMonth(report.getFinishMonth());
						certificadoDetalleDTO.setFinishYear(report.getFinishYear());
						certificadoDetalleDTO.setDay(report.getDay());
						certificadoDetalleDTO.setMonth(report.getMonth());
						certificadoDetalleDTO.setYear(report.getYear());
						certificadoDetalleDTO.setStartValidity(report.getStartValidity());
						certificadoDetalleDTO.setTermValidity(report.getTermValidity());
						certificadoDetalleDTO.setInsuranceCost(report.getInsuranceCost());
						certificadoDetalleDTO.setAccount(report.getAccount());
						certificadoDetalleDTO.setTemporality(report.getTemporality());
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

	private void initDetalle(List<CertificadoConsentimientoDetalleDTO> dataBeanList) {
		logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia initDetalle");
		CertificadoConsentimientoDetalleDTO certificadoDetalleDTO = new CertificadoConsentimientoDetalleDTO();
		certificadoDetalleDTO.setPolicy("");
		certificadoDetalleDTO.setCertificateNumber("");
		certificadoDetalleDTO.setName("");
		certificadoDetalleDTO.setBirthdate("");
		certificadoDetalleDTO.setAddress("");
		certificadoDetalleDTO.setRfc("");
		certificadoDetalleDTO.setStartDay("");
		certificadoDetalleDTO.setStartMonth("");
		certificadoDetalleDTO.setStartYear("");
		certificadoDetalleDTO.setFinishDay("");
		certificadoDetalleDTO.setFinishMonth("");
		certificadoDetalleDTO.setFinishYear("");
		certificadoDetalleDTO.setDay("");
		certificadoDetalleDTO.setMonth("");
		certificadoDetalleDTO.setYear("");
		certificadoDetalleDTO.setStartValidity("");
		certificadoDetalleDTO.setTermValidity("");
		certificadoDetalleDTO.setInsuranceCost("");
		certificadoDetalleDTO.setAccount("");
		certificadoDetalleDTO.setTemporality("");
		
		dataBeanList.add(certificadoDetalleDTO);
	}

}
