package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.SolicitudCreditoRevolventeDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.LoanGroupDetail;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoRevolventeDTO;
import com.cobiscorp.cobis.loans.reports.impl.SolicitudCreditoGrupalIMPL;
import com.cobiscorp.cobis.loans.reports.impl.SolicitudCreditoRevolventeIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "solicitudCreditoGrupalRenov") })
public class SolicitudCreditoGrupalRenov implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoGrupalRenov.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;
	Services service = new Services();

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("----->>>> Reporte Solicitud Credito Grupal Renovacion Inicio Sub");
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		List<LoanGroupDetail> loanGroupDetail = null;

		logger.logError("----->>>> AAA Reporte Solicitud Credito Grupal Renovacion - Principal Sub - application:-"
				+ application + "--");
		params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
		logger.logError("--> Reporte Solicitud Credito Grupal Renovacion - Buscar membersAmount");

		try {
			MemberResponse[] membersAmount = service.getLoanGroupAmounts(sessionId, application, serviceIntegration);
			loanGroupDetail = SolicitudCreditoGrupalIMPL.getDetailList(membersAmount);
		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud getDataSource Credito Grupal:", e);
			throw new RuntimeException(e);
		}
		logger.logError("--> Reporte Solicitud Credito Grupal Renovacion - Buscar membersAmount finaliza.");

		Collection<SolicitudCreditoRevolventeDATABEAN> collection = new ArrayList<SolicitudCreditoRevolventeDATABEAN>();
		SolicitudCreditoRevolventeDATABEAN solicitudCreditoRevolventeDATABEAN = new SolicitudCreditoRevolventeDATABEAN();
		SolicitudCreditoRevolventeIMPL solicitudCreditoIndividualImpl = new SolicitudCreditoRevolventeIMPL();
		List<SolicitudCreditoRevolventeDTO> contenido = new ArrayList<SolicitudCreditoRevolventeDTO>();

		try {
			LoanInfResponse loanData = service.getLoanData(sessionId, application, serviceIntegration);
			logger.logError("----->>>> Reporte Solicitud Credito Grupal Renovacion loanData:" + loanData);
			logger.logDebug("----->>>> Reporte Solicitud Credito Grupal Renovacion loanData.getOperationId():"
					+ loanData.getOperationId());
			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setDateFormat(ConstantValue.Params.FORMAT_DATE);
			logger.logDebug(
					"----->>>> Reporte Solicitud Credito Grupal Renovacion getCustomerId():" + loanData.getIdDebtor());
			ParameterResponse param = service.getParameter(4, "PSOLCR", "CRE", serviceIntegration, sessionId);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Parametro pie: " + param.getParameterValue());
			}
			for (LoanGroupDetail cus : loanGroupDetail) {
				SolicitudCreditoRevolventeDTO solicitudCreditoIndividual = new SolicitudCreditoRevolventeDTO();
				reportRequest.setCustomerId(cus.getCustomerId());
				reportRequest.setTramite(Integer.parseInt(application));
				solicitudCreditoIndividual = solicitudCreditoIndividualImpl.getContenido(reportRequest, sessionId,
						serviceIntegration);
				solicitudCreditoIndividual.setFootParam(param.getParameterValue());
				solicitudCreditoIndividual.setAsesor(loanData.getResponsibleAdvisor());
				solicitudCreditoIndividual.setGerente(loanData.getManagerOfice());
				solicitudCreditoIndividual.setAnalista(loanData.getAnalista());
				Services services = new Services();
				ParameterResponse reca = services.getParameter(4, "RNRECA", "CRE", serviceIntegration, sessionId);
				if (reca != null) {
					solicitudCreditoIndividual.setContraAdhesionS(reca.getParameterValue());
				}
				ParameterResponse pieAnio = services.getParameter(4, "PPREPR", "CRE", serviceIntegration, sessionId);
				if (pieAnio != null) {
					solicitudCreditoIndividual.setPieAnio(pieAnio.getParameterValue());
				}					
				contenido.add(solicitudCreditoIndividual);				
			}
			solicitudCreditoRevolventeDATABEAN.setContenido(contenido);
			collection.add(solicitudCreditoRevolventeDATABEAN);
		} catch (Exception e) {
			logger.logError("----->>>> Error Reporte Solicitud Credito Grupal Renovacion:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection, false);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("----->>>> Reporte Solicitud Credito Grupal Renovacion Inicio ");

		Method method = new Method();
		method.setPrmMain(params);

		try {
			params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
			params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
		} catch (Exception e) {
			logger.logDebug("----->>>> Reporte Solicitud Credito Grupal Renovacion - Principal - Error:", e);
			throw new RuntimeException("Reporte Solicitud Credito Grupal Renovacion - Principal - Error:", e);
		}

		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.SOLICITUD_CREDITO_GRUPAL_RENOVACION);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.SOLICITUD_CREDITO_GRUPAL_RENOVACION;
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

	public ICTSServiceIntegration getServiceIntegration() {
		return serviceIntegration;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

}
