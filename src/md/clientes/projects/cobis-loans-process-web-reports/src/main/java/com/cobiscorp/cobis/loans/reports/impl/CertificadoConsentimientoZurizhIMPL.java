package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.felix.scr.annotations.Reference;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.CertificadoConsentimientoZurizhDTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ReportZurichInformationResponse;

public class CertificadoConsentimientoZurizhIMPL {
	private static final ILogger logger = LogFactory.getLogger(CertificadoConsentimientoZurizhIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<CertificadoConsentimientoZurizhDTO> getDetalle(ReportZurichInformationResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<CertificadoConsentimientoZurizhDTO> dataBeanList = new ArrayList<CertificadoConsentimientoZurizhDTO>();
		logger.logError("*****>>Certificado - CertificadoConsentimientoZurizhIMPL - Inicia getDetalle");
		try {
			if (reportResponse != null) {
				if (reportResponse.length > 0) {
					for (ReportZurichInformationResponse report : reportResponse) {
						CertificadoConsentimientoZurizhDTO certificadoDetalleDTO = new CertificadoConsentimientoZurizhDTO();
						logger.logError("*****>>Certificado - CertificadoConsentimientoZurizhIMPL - Inicia getDetalle - report.getNombre(:" + report.getNombre() + ")");
						certificadoDetalleDTO.setNombre(report.getNombre());
						certificadoDetalleDTO.setRfc(report.getRfc());
						certificadoDetalleDTO.setFechanac(new Date(report.getFechanac().getTimeInMillis()));
						certificadoDetalleDTO.setDomicilio(report.getDomicilio());
						certificadoDetalleDTO.setColonia(report.getColonia());
						certificadoDetalleDTO.setCp(report.getCp());
						certificadoDetalleDTO.setEmail(report.getEmail());
						certificadoDetalleDTO.setCertificado(report.getCertificado());
						certificadoDetalleDTO.setFechaini(new Date(report.getFechainicio().getTimeInMillis()));
						certificadoDetalleDTO.setFechafin(new Date(report.getFechafin().getTimeInMillis()));
						certificadoDetalleDTO.setPoliza(report.getPoliza());
						certificadoDetalleDTO.setContratante(report.getContratante());
						certificadoDetalleDTO.setRfccontratante(report.getRfccontratante());
						certificadoDetalleDTO.setRazonsocial(report.getRazonsocial());
						certificadoDetalleDTO.setPrimaneta(report.getPrimaneta());
						certificadoDetalleDTO.setDerechopoliza(report.getDerechopoliza());
						certificadoDetalleDTO.setRecargopago(report.getRecargopago());
						certificadoDetalleDTO.setPrimatotal(report.getPrimatotal());
						certificadoDetalleDTO.setFechaemi(new Date(report.getFechaemi().getTimeInMillis()));
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

	private void initDetalle(List<CertificadoConsentimientoZurizhDTO> dataBeanList) {
		logger.logError("*****>>Certificado - CertificadoConsentimientoListIMPL - Inicia initDetalle");
		CertificadoConsentimientoZurizhDTO certificadoDetalleDTO = new CertificadoConsentimientoZurizhDTO();
		certificadoDetalleDTO.setNombre("");
		certificadoDetalleDTO.setRfc("");
		certificadoDetalleDTO.setFechanac(new Date());
		certificadoDetalleDTO.setDomicilio("");
		certificadoDetalleDTO.setColonia("");
		certificadoDetalleDTO.setCp("00000");
		certificadoDetalleDTO.setEmail("");
		certificadoDetalleDTO.setCertificado("");
		certificadoDetalleDTO.setFechaini(new Date());
		certificadoDetalleDTO.setFechafin(new Date());
		certificadoDetalleDTO.setPoliza("");
		certificadoDetalleDTO.setContratante("");
		certificadoDetalleDTO.setRfccontratante("");
		certificadoDetalleDTO.setRazonsocial("");
		certificadoDetalleDTO.setPrimaneta(0.0);
		certificadoDetalleDTO.setDerechopoliza(0.0);
		certificadoDetalleDTO.setRecargopago(0.0);
		certificadoDetalleDTO.setPrimatotal(0.0);
		certificadoDetalleDTO.setFechaemi(new Date());
		dataBeanList.add(certificadoDetalleDTO);
	}

}
