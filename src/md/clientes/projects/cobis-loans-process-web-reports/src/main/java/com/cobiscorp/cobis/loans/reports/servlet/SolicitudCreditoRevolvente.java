package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
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
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.SolicitudCreditoRevolventeDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoRevolventeDTO;
import com.cobiscorp.cobis.loans.reports.impl.SolicitudCreditoRevolventeIMPL;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "solicitudCreditoRevolvente") })
public class SolicitudCreditoRevolvente implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoRevolvente.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	Services service = new Services();

	/*
	 * sp_reporte_sol_complementaria @i_operacion = 'IG', @i_ente = <cliente>
	 * --Informacion General del Cliente sp_reporte_sol_complementaria
	 * 
	 * @i_operacion = 'DI', @i_ente = <cliente>, @i_tipo = 'RE' --Informacion
	 * Direcciones de Domiciliaria sp_reporte_sol_complementaria @i_operacion =
	 * 'DI', @i_ente = <cliente>, @i_tipo = 'AE' --Informacion Direcciones de
	 * Negocio sp_reporte_sol_complementaria @i_operacion = 'DI', @i_ente =
	 * <cliente>, @i_tipo_dir = 'V' --Informacion Direcciones de Correo Electronico
	 * sp_reporte_sol_complementaria @i_operacion = 'NC', @i_ente = <cliente>
	 * --Informacion de Negocios del Cliente
	 * sp_reporte_sol_complementaria @i_operacion = 'RP', @i_ente = <cliente>
	 * --Informacion de Referencias Personales del Cliente
	 * sp_reporte_sol_complementaria @i_operacion = 'RC', @i_ente = <cliente>
	 * --Informacion de Relaciones del Cliente
	 */
	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("----->>>> Reporte Solicitud Credito Revolvente Inicio Sub");
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);

		logger.logError("----->>>> AAA Reporte Solicitud Credito Revolvente - Principal Sub - application:-"
				+ application + "--");

		ReportResponse[] reportResponsePrincipal;
		params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como
															// 122,345.56

		Collection<SolicitudCreditoRevolventeDATABEAN> collection = new ArrayList<SolicitudCreditoRevolventeDATABEAN>();
		SolicitudCreditoRevolventeDATABEAN solicitudCreditoRevolventeDATABEAN = new SolicitudCreditoRevolventeDATABEAN();

		SolicitudCreditoRevolventeIMPL solicitudCreditoIndividualImpl = new SolicitudCreditoRevolventeIMPL();

		List<SolicitudCreditoRevolventeDTO> contenido = new ArrayList<SolicitudCreditoRevolventeDTO>();
		SolicitudCreditoRevolventeDTO solicitudCreditoIndividual = new SolicitudCreditoRevolventeDTO();

		try {

			LoanInfResponse loanData = service.getLoanData(sessionId, application, serviceIntegration);
			logger.logError("----->>>> Reporte Solicitud Credito Revolvente loanData:" + loanData);
			if (loanData != null) {
				logger.logDebug("----->>>> Reporte Solicitud Credito Revolvente loanData.getOperationId():"
						+ loanData.getOperationId());

				ReportRequest reportRequest = new ReportRequest();
				reportRequest.setDateFormat(ConstantValue.Params.FORMAT_DATE);
				logger.logDebug(
						"----->>>> Reporte Solicitud Credito Revolvente reportResponsePrincipal.getCustomerId():"
								+ loanData.getIdDebtor());
				reportRequest.setCustomerId(loanData.getIdDebtor());
				reportRequest.setTramite(Integer.parseInt(application));
				solicitudCreditoIndividual = solicitudCreditoIndividualImpl.getContenido(reportRequest, sessionId,
						serviceIntegration);
				ParameterResponse param = service.getParameter(4, "PSOLCR", "CRE", serviceIntegration, sessionId);
				if (logger.isDebugEnabled()) {
					logger.logDebug("Parametro pie: " + param.getParameterValue());
				}
				solicitudCreditoIndividual.setFootParam(param.getParameterValue());
				solicitudCreditoIndividual.setAsesor(loanData.getResponsibleAdvisor());
				solicitudCreditoIndividual.setGerente(loanData.getManagerOfice());
				solicitudCreditoIndividual.setAnalista(loanData.getAnalista());
				solicitudCreditoIndividual.setFuncionario1(loanData.getOfficial1());
				solicitudCreditoIndividual.setFuncionario2(loanData.getOfficial2());
				solicitudCreditoIndividual.setIdOperacion(loanData.getOperationId());
				logger.logDebug("Antes de añadir contenido");
				contenido.add(solicitudCreditoIndividual);
				logger.logDebug("Despues de añadir contenido");

			}

			solicitudCreditoRevolventeDATABEAN.setContenido(contenido);
			collection.add(solicitudCreditoRevolventeDATABEAN);
		} catch (Exception e) {
			logger.logError("----->>>> Error Reporte Solicitud Credito Revolvente:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection, false);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("----->>>> Reporte Solicitud Credito Revolvente Inicio ");
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		Method method = new Method();
		method.setPrmMain(params);
		ParameterResponse param = service.getParameter(4, "PSOLCR", "CRE", serviceIntegration, sessionId);
		try {
			params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como
																// 122,345.56
			params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
		} catch (Exception e) {
			logger.logDebug("Error Reporte Solicitud Credito Revolvente:", e);
			throw new RuntimeException("Erro Reporte Solicitud Credito Revolvente:", e);
		}

		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.SOLICITUD_CREDITO_REVOLVENTE);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.SOLICITUD_CREDITO_REVOLVENTE;
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
