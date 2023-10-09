package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ConsentCertificateResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.CertificadoConsentimientoDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.CertificadoConsentimientoDetalleDTO;
import com.cobiscorp.cobis.loans.reports.impl.CertificadoConsentimientoListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "certificadoConsentimiento") })
public class CertificadoConsentimiento implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(CertificadoConsentimiento.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logInfo("*****>>Inicia - Reporte - CertificadoConsentimiento Detalle");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String reportNemonic = (String) params.get(ConstantValue.Params.REPORTNEMONIC);

		Integer applicationIn = 0;
		Collection<CertificadoConsentimientoDATABEAN> collection = new ArrayList<CertificadoConsentimientoDATABEAN>();
		Services services = new Services();
		applicationIn = Integer.parseInt(application);
		try {
			logger.logError("*****>>Reporte - CertificadoConsentimiento idTramite:" + applicationIn);

			// Contiene la Lista
			CertificadoConsentimientoDATABEAN certificadoConsentimientoDATABEAN = new CertificadoConsentimientoDATABEAN();
			CertificadoConsentimientoListIMPL certificadoListIMPL = new CertificadoConsentimientoListIMPL();

			// Contiene la Lista de detalle
			List<CertificadoConsentimientoDetalleDTO> certificadoConsentimientoDetalleDTO = new ArrayList<CertificadoConsentimientoDetalleDTO>();

			ConsentCertificateResponse[] reportResponseCertificadoo = services.getCertificado(applicationIn, reportNemonic, null, sessionId, serviceIntegration);
			certificadoConsentimientoDetalleDTO = certificadoListIMPL.getDetalle(reportResponseCertificadoo, sessionId, serviceIntegration);

			// Envio al reporte
			certificadoConsentimientoDATABEAN.setCertificadoConsentimientoDetalle(certificadoConsentimientoDetalleDTO);

			// Se anade al jaspers
			collection.add(certificadoConsentimientoDATABEAN);
		} catch (Exception e) {
			logger.logError("*****>>Error - Reporte - CertificadoConsentimiento Detalle", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - CertificadoConsentimiento");
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG_CERTIF);
		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.CERTIFICADO);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.CERTIFICADO;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		return REPORTING_NAME_FILTER;
	}

	// Seguridad para presentar el reporte
	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}
}
