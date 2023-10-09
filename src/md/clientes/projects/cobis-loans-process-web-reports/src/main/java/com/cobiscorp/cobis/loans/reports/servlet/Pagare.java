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
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.PagareDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.PagareDTO;
import com.cobiscorp.cobis.loans.reports.impl.PagareListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "pagare") })
public class Pagare implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(Pagare.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****>>Sub Reporte - Pagare");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);

		Services services = new Services();
		List<PagareDTO> pagare = new ArrayList<PagareDTO>();
		ReportResponse[] reportResponsePrincipal;
		PagareListIMPL pagareListIMPL = new PagareListIMPL();
		PagareDATABEAN pagareDATABEAN = new PagareDATABEAN();

		Collection<PagareDATABEAN> collection = new ArrayList<PagareDATABEAN>();

		try {
			LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
			logger.logError("*****>>Sub Reporte - Pagare - loanData:" + loanData);
			if (loanData != null) {
				logger.logDebug("*****>>Sub Reporte - Pagare - loanData.getOperationId():" + loanData.getOperationId());
				reportResponsePrincipal = services.getDisbursementOrderDetail(sessionId, loanData.getOperationId(), "2", 2, serviceIntegration);
				// Para individual
				logger.logDebug("*****>>Sub Reporte - Pagare - Respuesta reportResponsePrincipal:" + reportResponsePrincipal);				
				pagare = pagareListIMPL.getPagarePrincipal(reportResponsePrincipal, sessionId, serviceIntegration);
				
			} else {
				pagare = pagareListIMPL.initListPagareDetail();
			}
			pagareDATABEAN.setPagareDetalle(pagare);
			collection.add(pagareDATABEAN); // XB..

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - Reporte Pagare:", e);
			throw new RuntimeException("*****>>Error Lista - Reporte Pagare:", e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("*****>>Reporte - Pagare");
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.PAGARE);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.PAGARE;
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
