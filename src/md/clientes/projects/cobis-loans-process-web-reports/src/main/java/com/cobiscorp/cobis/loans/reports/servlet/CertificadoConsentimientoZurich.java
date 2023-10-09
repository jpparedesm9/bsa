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
import cobiscorp.ecobis.sales.cloud.dto.ReportZurichInformationResponse;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.dataBean.CertificadoConsentimientoZurizhDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.CertificadoConsentimientoZurizhDTO;
import com.cobiscorp.cobis.loans.reports.impl.CertificadoConsentimientoZurizhIMPL;
import com.cobiscorp.cobis.loans.reports.services.SecureConsentMedicalService;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "certificadoConsentimientoZurich") })
public class CertificadoConsentimientoZurich implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(CertificadoConsentimientoZurich.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logInfo("*****>>Inicia - Reporte - CertificadoConsentimientoZurich Detalle");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String client = (String) params.get(ConstantValue.Params.CUSTOMER);
		int operationId = Integer.parseInt((String) params.get(ConstantValue.Params.APPLICATION));
		
		String reportNemonic = (String) params.get(ConstantValue.Params.REPORTNEMONIC);
		String operation = ConstantValue.valueConstant.CERCONIND.equals(reportNemonic) ? "R" : "Q";
		if (logger.isDebugEnabled()) {
			logger.logDebug("CertificadoConsentimientoZurich-getDatasourceReport>>>>>reportNemonic:" + reportNemonic);
			logger.logDebug("CertificadoConsentimientoZurich-getDatasourceReport>>>>>operation:" + operation);
		}
		
		Integer applicationIn = 0;
		Collection<CertificadoConsentimientoZurizhDATABEAN> collection = new ArrayList<CertificadoConsentimientoZurizhDATABEAN>();
		try {
			logger.logError("*****>>Reporte - CertificadoConsentimientoZurich idTramite:" + applicationIn);

			// Contiene la Lista
			CertificadoConsentimientoZurizhDATABEAN certificadoConsentimientoZurizhDATABEAN = new CertificadoConsentimientoZurizhDATABEAN();
			CertificadoConsentimientoZurizhIMPL certificadoConsentimientoZurizhIMPL = new CertificadoConsentimientoZurizhIMPL();

			// Contiene la Lista de detalle
			List<CertificadoConsentimientoZurizhDTO> certificadoConsentimientoZurizhDTO = new ArrayList<CertificadoConsentimientoZurizhDTO>();

			ReportZurichInformationResponse[] reportResponseCertificadoo = new SecureConsentMedicalService().reportZurichInformation(client, operationId, operation, sessionId, serviceIntegration);
			certificadoConsentimientoZurizhDTO = certificadoConsentimientoZurizhIMPL.getDetalle(reportResponseCertificadoo, sessionId, serviceIntegration);

			// Envio al reporte
			certificadoConsentimientoZurizhDATABEAN.setListaZurich(certificadoConsentimientoZurizhDTO);

			// Se anade al jaspers
			collection.add(certificadoConsentimientoZurizhDATABEAN);
			
			if (logger.isDebugEnabled()) {
				CertificadoConsentimientoZurizhDTO dto = certificadoConsentimientoZurizhDTO.get(0);
				logger.logDebug("Certificado:" + dto.getCertificado());
				logger.logDebug(dto.getColonia());
				logger.logDebug(dto.getContratante());
				logger.logDebug(dto.getCp());
				logger.logDebug(dto.getDerechopoliza());
				logger.logDebug(dto.getDomicilio());
				logger.logDebug(dto.getEmail());
				logger.logDebug(dto.getFechaemi());
				logger.logDebug(dto.getFechafin());
				logger.logDebug(dto.getFechaini());
				logger.logDebug(dto.getFechanac());
				logger.logDebug(dto.getNombre());
				logger.logDebug(dto.getPoliza());
				logger.logDebug(dto.getPrimaneta());
				logger.logDebug(dto.getPrimatotal());
				logger.logDebug(dto.getRazonsocial());
				logger.logDebug(dto.getRecargopago());
				logger.logDebug(dto.getRfc());
				logger.logDebug(dto.getRfccontratante());				
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - Reporte - CertificadoConsentimientoZurich Detalle", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - CertificadoConsentimientoZurich");
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG_CERTIF);
		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.CERTIFICADOZURICH);
	}

	private String getFileLocationReport(String reportJasper) {
		return ConstantValue.JasperPath.CERTIFICADOZURICH;
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
