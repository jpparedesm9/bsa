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
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.KYCSimplificadoPrincipalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.KYCSimplificadoDetalleDTO;
import com.cobiscorp.cobis.loans.reports.impl.KYCSimplificadoListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "kYCAutoOnboard") })
public class KYCSimplificadoIndividual implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	 //porCaso#185412 igual al de onbarding
	private static final ILogger logger = LogFactory.getLogger(KYCSimplificadoIndividual.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - KYCSimplificado Detalle");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Integer applicationIn = 0;
		Collection<KYCSimplificadoPrincipalDATABEAN> collection = new ArrayList<KYCSimplificadoPrincipalDATABEAN>();
		Services services = new Services();
		applicationIn = Integer.parseInt(application);
		try {
			logger.logError("*****>>Reporte - KYCSimplificado idTramite:" + applicationIn);

			// Contiene la Lista
			KYCSimplificadoPrincipalDATABEAN kYCSimplificadoPrincipalDATABEAN = new KYCSimplificadoPrincipalDATABEAN();
			KYCSimplificadoListIMPL kYCSimplificadoListIMPL = new KYCSimplificadoListIMPL();

			// Contiene la Lista de detalle
			List<KYCSimplificadoDetalleDTO> kYCSimplificadoDetalleDTO = new ArrayList<KYCSimplificadoDetalleDTO>();

			ReportResponse[] reportResponseKYCSimplificado = services.getKYCSimplificado(applicationIn, sessionId, serviceIntegration);
			kYCSimplificadoDetalleDTO = kYCSimplificadoListIMPL.getDetalle(reportResponseKYCSimplificado, sessionId, serviceIntegration);

			// Envio al reporte
			kYCSimplificadoPrincipalDATABEAN.setKycSimplificadoDetalle(kYCSimplificadoDetalleDTO);

			// Se anade al jaspers
			collection.add(kYCSimplificadoPrincipalDATABEAN);
		} catch (Exception e) {
			logger.logError("*****>>Error - Reporte - KYCSimplificado Detalle", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - KYCSimplificado");
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG2);
		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.KYC_SIMP_IND_ONB);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.KYC_SIMP_IND_ONB;
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
