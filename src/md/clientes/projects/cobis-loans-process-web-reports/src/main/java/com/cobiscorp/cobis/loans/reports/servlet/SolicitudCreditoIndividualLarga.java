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
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.SolicitudCreditoIndividualLargaDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoIndividualLargaDTO;
import com.cobiscorp.cobis.loans.reports.impl.SolicitudCreditoIndividualLargaIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "solicitudCreditoIndividualLarga") })
public class SolicitudCreditoIndividualLarga implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoIndividualLarga.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	Services service = new Services();

	/*
	 * sp_reporte_sol_complementaria @i_operacion = 'IG', @i_ente = <cliente> --Informacion General del Cliente sp_reporte_sol_complementaria @i_operacion = 'DI', @i_ente = <cliente>, @i_tipo = 'RE' --Informacion Direcciones de Domiciliaria
	 * sp_reporte_sol_complementaria @i_operacion = 'DI', @i_ente = <cliente>, @i_tipo = 'AE' --Informacion Direcciones de Negocio sp_reporte_sol_complementaria @i_operacion = 'DI', @i_ente = <cliente>, @i_tipo_dir = 'V' --Informacion Direcciones de
	 * Correo Electronico sp_reporte_sol_complementaria @i_operacion = 'NC', @i_ente = <cliente> --Informacion de Negocios del Cliente sp_reporte_sol_complementaria @i_operacion = 'RP', @i_ente = <cliente> --Informacion de Referencias Personales del
	 * Cliente sp_reporte_sol_complementaria @i_operacion = 'RC', @i_ente = <cliente> --Informacion de Relaciones del Cliente
	 */
	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub");
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);

		logger.logError("----->>>> AAA Reporte Solicitud Credito Individual Larga - Principal Sub - application:-" + application + "--");

		ReportResponse[] reportResponsePrincipal;
		params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56

		Collection<SolicitudCreditoIndividualLargaDATABEAN> collection = new ArrayList<SolicitudCreditoIndividualLargaDATABEAN>();
		SolicitudCreditoIndividualLargaDATABEAN scilDATABEAN = new SolicitudCreditoIndividualLargaDATABEAN();
		
		SolicitudCreditoIndividualLargaIMPL scilImp = new SolicitudCreditoIndividualLargaIMPL();
		
		List<SolicitudCreditoIndividualLargaDTO> contenido = new ArrayList<SolicitudCreditoIndividualLargaDTO>();
		SolicitudCreditoIndividualLargaDTO sCILargaDTO = new SolicitudCreditoIndividualLargaDTO();

		try {

			LoanInfResponse loanData = service.getLoanData(sessionId, application, serviceIntegration);
			logger.logError("----->>>> Reporte Solicitud Credito Individual Larga - Principal Sub - loanData:" + loanData);
			if (loanData != null) {
				logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga - Principal Sub - loanData.getOperationId():" + loanData.getOperationId());
				reportResponsePrincipal = service.getDisbursementOrderDetail(sessionId, loanData.getOperationId(), "2", 2, serviceIntegration);

				if (reportResponsePrincipal != null) {
					if (reportResponsePrincipal.length > 0) {
						for (int i = 0; i < reportResponsePrincipal.length; i++) {
							logger.logDebug("*****>>getPagarePrincipal - NumBanco:" + reportResponsePrincipal[i].getClient());
							ReportRequest reportRequest = new ReportRequest();
							reportRequest.setDateFormat(ConstantValue.Params.FORMAT_DATE);
							reportRequest.setCustomerId(reportResponsePrincipal[i].getCustomerId());
							reportRequest.setTramite(Integer.parseInt(application));
							sCILargaDTO = scilImp.getContenido(reportRequest, sessionId, serviceIntegration);							
							contenido.add(sCILargaDTO);							
						}
					}
				}
			}
			scilDATABEAN.setContenido(contenido);
			collection.add(scilDATABEAN);
		} catch (Exception e) {
			logger.logError("----->>>> Reporte Solicitud Credito Individual Larga Sub - Principal - Error:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio ");

		Method method = new Method();
		method.setPrmMain(params);

		try {
			params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
			params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
		} catch (Exception e) {
			logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga - Principal - Error:", e);
			throw new RuntimeException("Reporte Solicitud Credito Individual Larga - Principal - Error:", e);
		}

		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.SOLICITUD_INDIVIDUAL_CREDITO_LARGA);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.SOLICITUD_INDIVIDUAL_CREDITO_LARGA;
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
