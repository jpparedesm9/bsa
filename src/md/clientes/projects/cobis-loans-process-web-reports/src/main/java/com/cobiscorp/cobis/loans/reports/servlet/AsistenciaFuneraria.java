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
import com.cobiscorp.cobis.loans.reports.dataBean.AsistenciaFunerariaDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.AsistenciaFunerariaDetalleDTO;
import com.cobiscorp.cobis.loans.reports.impl.AsistenciaFunerariaListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "asistenciaFuneraria") })
public class AsistenciaFuneraria implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(AsistenciaFuneraria.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - AsistenciaFuneraria Detalle");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String reportNemonic = (String) params.get(ConstantValue.Params.REPORTNEMONIC);
		Integer applicationIn = 0;
				
		String operation = ConstantValue.valueConstant.CEASFUIND.equals(reportNemonic) ? "Q" : "S";
		if (logger.isDebugEnabled()) {
			logger.logDebug("AsistenciaFuneraria-getDatasourceReport>>>>>reportNemonic:" + reportNemonic);
			logger.logDebug("AsistenciaFuneraria-getDatasourceReport>>>>>operation:" + operation);
		}
		
		Collection<AsistenciaFunerariaDATABEAN> collection = new ArrayList<AsistenciaFunerariaDATABEAN>();
		Services services = new Services();
		applicationIn = Integer.parseInt(application);
		try {
			logger.logError("*****>>Reporte - AsistenciaFuneraria idTramite:" + applicationIn);

			// Contiene la Lista
			AsistenciaFunerariaDATABEAN asistenciaFunerariaDATABEAN = new AsistenciaFunerariaDATABEAN();
			AsistenciaFunerariaListIMPL asistenciaListIMPL = new AsistenciaFunerariaListIMPL();

			// Contiene la Lista de detalle
			List<AsistenciaFunerariaDetalleDTO> asistenciaFunerariaDetalleDTO = new ArrayList<AsistenciaFunerariaDetalleDTO>();

			ConsentCertificateResponse[] reportResponseAsistencia = services.getCertificado(applicationIn, reportNemonic, operation, sessionId, serviceIntegration);
			asistenciaFunerariaDetalleDTO = asistenciaListIMPL.getDetalle(reportResponseAsistencia, sessionId, serviceIntegration);

			// Envio al reporte
			asistenciaFunerariaDATABEAN.setAsistenciaFunerariaDetalle(asistenciaFunerariaDetalleDTO);

			// Se anade al jaspers
			collection.add(asistenciaFunerariaDATABEAN);
		} catch (Exception e) {
			logger.logError("*****>>Error - Reporte - AsistenciaFuneraria Detalle", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - AsistenciaFuneraria");
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG_FUNERARIA);
		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.FUNERARIA);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.FUNERARIA;
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
