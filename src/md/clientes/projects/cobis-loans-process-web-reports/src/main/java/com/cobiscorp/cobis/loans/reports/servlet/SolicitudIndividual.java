package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.SolicitudCreditoIndividualDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudIndividualDTO;
import com.cobiscorp.cobis.loans.reports.impl.SolicitudCreditoIndividualIMPL;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "solicitudCreditoIndividual") })
public class SolicitudIndividual implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(SolicitudIndividual.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logInfo("Inicia generacion de DataSource para Solicitud de Credito Individual");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		//Collection<SolicitudIndividualDTO> collection = new ArrayList<SolicitudIndividualDTO>();
		SolicitudIndividualDTO solicitudData = new SolicitudIndividualDTO();
		Services services = new Services();
		List<SolicitudIndividualDTO> contenido = new ArrayList<SolicitudIndividualDTO>();
		Collection<SolicitudCreditoIndividualDATABEAN> collection = new ArrayList<SolicitudCreditoIndividualDATABEAN>();

		try {
			SolicitudCreditoIndividualDATABEAN solicitudCreditoIndividual = new SolicitudCreditoIndividualDATABEAN();
			Map<String, Object> responseDebtor = services.getCustomerData(sessionId, application, ConstantValue.DebtorType.DEBTOR, serviceIntegration);
			Map<String, Object> responseEndorsement = services.getCustomerData(sessionId, application, ConstantValue.DebtorType.ENDORSEMENT, serviceIntegration);

			LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
			// SolicitudIndividualDTO solicitudData =
			// SolicitudCreditoIndividualIMPL.getCreditRequestData(loanData, responseDebtor,
			// responseEndorsement);
			// solicitudCreditoIndividual.setSolicitudIndividual(solicitudData);

			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setDateFormat(ConstantValue.Params.FORMAT_DATE);
			logger.logDebug("----->>>> Reporte Solicitud Credito Revolvente reportResponsePrincipal.getCustomerId():" + loanData.getIdDebtor());
			reportRequest.setCustomerId(loanData.getIdDebtor());
			reportRequest.setTramite(Integer.parseInt(application));
			solicitudData = SolicitudCreditoIndividualIMPL.getContenido(reportRequest, sessionId, serviceIntegration);

			ParameterResponse param = services.getParameter(4, "RPSCRI", "CRE", serviceIntegration, sessionId);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Parametro pie solicitud: " + param.getParameterValue());
			}
			ParameterResponse paramCondusef = services.getParameter(4, "RDRECA", "CRE", serviceIntegration, sessionId);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Parametro condusef solicitud: " + paramCondusef.getParameterValue());
			}

			solicitudData.setFootParam(param.getParameterValue());
			solicitudData.setCondusef(paramCondusef.getParameterValue());
			solicitudData.setAsesor(loanData.getResponsibleAdvisor());
			solicitudData.setGerente(loanData.getManagerOfice());
			solicitudData.setAnalista(loanData.getAnalista());

			logger.logDebug("Antes de añadir contenido");
			contenido.add(solicitudData);
			logger.logDebug("Despues de añadir contenido");

			solicitudCreditoIndividual.setContenido(contenido);

			collection.add(solicitudCreditoIndividual);
			if (logger.isDebugEnabled()) {
				logger.logDebug("-> collection: " + collection);
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud getDataSource Credito Individual:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return ConstantValue.JasperPath.SOLICTUD_CREDITO_INDIVIDUAL;
	}

}
