package com.cobiscorp.cobis.customer.reports.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCreditsSummaryPrincipalResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCreditsSummaryResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistDetailConsultationsResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistDetailTheCreditsResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistEmployeeHomeResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistScoreBuroResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.customer.reports.commons.ConstantValue;
import com.cobiscorp.cobis.customer.reports.commons.Method;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTO;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTODetConsultas;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTODetCreditos;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTODom;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTOEmp;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTOResumenCredito;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTOScoreBuro;
import com.cobiscorp.cobis.customer.reports.impl.BuroCreditoHistoricoImpl;
import com.cobiscorp.cobis.customer.reports.security.COBISSecurityManager;
import com.cobiscorp.cobis.customer.reports.security.SessionSecurityKey;
import com.cobiscorp.cobis.customer.reports.security.dto.CTSServiceResponseTO;
import com.cobiscorp.cobis.customer.reports.services.BuroCreditoHistoricalServices;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;

//HttpServlet
public class BuroCreditoHistoricoServlet extends MainServlet {

	private static final String BURO_HISTORIAL = "/CUSTOMER/reports/jasper/BuroCreditoHistorico.jasper";
	private static final String NOBRE_BURO_HISTORIAL = "REPORTE DE CRÉDITO (Histórico)";
	private static final String APPLICATION_PDF = "application/pdf";
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoHistoricoServlet.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.execute(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.execute(req, resp);
	}

	private void execute(HttpServletRequest request, HttpServletResponse resp) {
		//String sessionId = SessionManager.getSessionId();
		
		String sessionId = null;
		
		if(SessionManager.getSessionId() != null){
			sessionId = SessionManager.getSessionId();
		} else {
			SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
			CTSServiceResponseTO response = new CTSServiceResponseTO();
	        COBISSecurityManager.ClearSessionId(wSessionSecurityKey);
	        sessionId = COBISSecurityManager.initializeSession(serviceIntegration, wSessionSecurityKey, response);
	        request.getSession().setAttribute("cobis-session-id", sessionId);
			if(sessionId == null){
				if (logger.isErrorEnabled()) {
	                logger.logError(response);
	            }
	            throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
			}
			logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - REPORT - no hay session");
		}
		
		Integer idCliente = Integer.parseInt(request.getParameter(ConstantValue.Params.ID_CUSTOMER));

		FileItemFactory factory = new DiskFileItemFactory();

		logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - execute MainServlet:" + idCliente);
		super.setApplicationType(APPLICATION_PDF);
		super.setReportJasperPath(BURO_HISTORIAL);

		try {
			 super.generateBuro(request, resp, serviceIntegration, ConstantValue.Params.BURO_REPORT_HISTORICO, sessionId);
			
		} catch (JRException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected Map<String, Object> getParameters(HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();
		Method method = new Method();
		method.setPrmMain(params);

		try {
			Integer idCliente = Integer.parseInt(request.getParameter(ConstantValue.Params.ID_CUSTOMER));
			logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - REPORT - getParameters idCliente:" + idCliente);
			
			String sessionId = null;
			
			if(SessionManager.getSessionId() != null){
				sessionId = SessionManager.getSessionId();
			} else {
				FilesUtilClass filesUtilClass = new FilesUtilClass();
				sessionId = filesUtilClass.getSession(request);
				/*SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
				CTSServiceResponseTO response = new CTSServiceResponseTO();
		        COBISSecurityManager.ClearSessionId(wSessionSecurityKey);
		        sessionId = COBISSecurityManager.initializeSession(serviceIntegration, wSessionSecurityKey, response);
				if(sessionId == null){
					if (logger.isErrorEnabled()) {
		                logger.logError(response);
		            }
		            throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
				}
				logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - REPORT - no hay session");*/
			}
			
			// Clases
			BuroCreditoHistoricalServices buroCredHistServices = new BuroCreditoHistoricalServices();

			params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
			params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
			// Envio de datos para servcios
			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setClient(idCliente);
			reportRequest.setFormatDate(ConstantValue.valueConstant.FORMAT_DATE);

			ReportHistCustomerResponse[] rHistCustomer = buroCredHistServices.histoCustomer(sessionId, reportRequest, serviceIntegration);

			if (rHistCustomer != null) {
				logger.logDebug("---->> BuroCreditoHistoricoServlet - REPORT - getParameters - DTO ReportHistCustomerResponse lenght:" + rHistCustomer.length);
				if (rHistCustomer.length > 0) {
					logger.logDebug("---->> BuroCreditoHistoricoServlet - REPORT - getParameters - DTO  rHistCustomer[0].getQueryFolioBure():" +  rHistCustomer[0].getQueryFolioBure());
					method.mapValuesToParams("cabFechHoraEmiReport", rHistCustomer[0].getReporeDate(), "");
					method.mapValuesToParams("cabSucursal", rHistCustomer[0].getBranchOffice(), "");
					method.mapValuesToParams("cabFuncionario", rHistCustomer[0].getOfficialName(), "");
					method.mapValuesToParams("cabFolioConsultaBuro", rHistCustomer[0].getQueryFolioBure(), "");
					method.mapValuesToParams("cabFechaHoraConsultaBC", rHistCustomer[0].getDateConsultationBC(), "");
							
					method.mapValuesToParams("datGenNombres", rHistCustomer[0].getNames(), "");
					method.mapValuesToParams("datGenApellidos", rHistCustomer[0].getLastName(), "");
					method.mapValuesToParams("datGenRFC", rHistCustomer[0].getRfc(), "");
					method.mapValuesToParams("datGenFechaNacimiento", rHistCustomer[0].getBirthDate(), "");
					method.mapValuesToParams("datGenIFE", rHistCustomer[0].getIFE(), "");
					method.mapValuesToParams("datGenCurp",rHistCustomer[0].getCurp() , "");					
					method.mapValuesToParams("datGenEstadoCivil", rHistCustomer[0].getCivilStatus(), "");
					method.mapValuesToParams("datGenRegBC", rHistCustomer[0].getRegistrationDate(), "");
				} else {
					initHeaderCB(params);
				}
			} else {
				initHeaderCB(params);
			}

			ReportHistCreditsSummaryResponse[] rHistCreditsSummary = buroCredHistServices.histSummaryCred(sessionId, reportRequest, serviceIntegration);

			if (rHistCreditsSummary != null) {
				logger.logDebug("---->> BuroCreditoHistoricoServlet - REPORT - getParameters - DTO ReportHistCreditsSummaryResponse lenght:" + rHistCreditsSummary.length);
				if (rHistCreditsSummary.length > 0) {
					method.mapValuesToParams("ncTotal", rHistCreditsSummary[0].getNumberofaccounts(), 0);
					method.mapValuesToParams("ncEnPagosFijosEHipoteca", rHistCreditsSummary[0].getFixedPaymentAccounts(), 0);
					method.mapValuesToParams("ncRevolventesYAbiertas", rHistCreditsSummary[0].getOpenAdvertisingAccounts(), 0);
					method.mapValuesToParams("ncCerradas", rHistCreditsSummary[0].getLockedAccounts(), 0);
					method.mapValuesToParams("ncNumCtasNegativasActuales", rHistCreditsSummary[0].getNegativeAccountsCurrent(), 0);
					method.mapValuesToParams("ncNumCtasEnDisputa", rHistCreditsSummary[0].getAccountsDisputa(), 0);
					method.mapValuesToParams("ncNumSolicÚltimos6Meses", rHistCreditsSummary[0].getNumberRequestsLast6Meses(), 0);
					method.mapValuesToParams("ncTotalSaldosActualesCtasRevolAbi", rHistCreditsSummary[0].getTotalCurrentRevolvingBalances(), 0.0);
					method.mapValuesToParams("ncTotalSaldosVencidosCtasRevolAbi", rHistCreditsSummary[0].getTotalRevolvingExpiredBalances(), 0.0);

					method.mapValuesToParams("cpfhTotalSaldosActuales", rHistCreditsSummary[0].getTotalCurrentBalancesFixedPayments(), 0.0);
					method.mapValuesToParams("cpfhTotalSaldosVencidos", rHistCreditsSummary[0].getTotalPastDueBalancesFixedPayments(), 0.0);
					method.mapValuesToParams("cpfhImporteTotalPagos", rHistCreditsSummary[0].getTotalPaymentsFixedPayments(), 0.0);
					method.mapValuesToParams("cpfhTotalCreditosMax", rHistCreditsSummary[0].getTotalCreditsMaximosFixedPayments(), 0.0);

					method.mapValuesToParams("dscobLimiteDeCreditoCtasRevolv", rHistCreditsSummary[0].getPctLimitCreditUsedRevolvers(), 0.0);
					method.mapValuesToParams("dscobDCTotalCts", rHistCreditsSummary[0].getKeyAccountsNegativeHistory(), 0);
					method.mapValuesToParams("dscobNumCtasClavesMopHistNegativa", rHistCreditsSummary[0].getTotalNumberAccountsDispatchCollection(), 0);
					method.mapValuesToParams("dscobDCFechaAbrioCtaMasReciente", rHistCreditsSummary[0].getDateAperCtaMasRecienteCobOffice(), "");
					method.mapValuesToParams("dscobDCNumTotalSolicitudesHechas", rHistCreditsSummary[0].getTotalNumberRequestsCobDispatches(), 0);
					method.mapValuesToParams("dscobDCFechaSolicitudMasReciente", rHistCreditsSummary[0].getDateSunMostRecentDisbursementCollection(), "");
					method.mapValuesToParams("dscobFechaAbrioCtaMasAntigua", rHistCreditsSummary[0].getOpeningDateOlderAccount(), "");
					method.mapValuesToParams("dscobFechaAbrioCtaMasReciente", rHistCreditsSummary[0].getDateRequestMostRecentReport(), "");
					method.mapValuesToParams("dscobNumTotalSolicReportesCredito", rHistCreditsSummary[0].getTotalRequestsReport(), 0);
					method.mapValuesToParams("dscobFechaMasRecienteSolicitoReporteCredito", rHistCreditsSummary[0].getDateRequestMostRecentReportCre(), "");
				} else {
					initHeaderNC(params);
				}
			} else {
				initHeaderNC(params);
			}

		} catch (Exception e) {
			logger.logDebug("---->> ERROR BuroCreditoHistorico - REPORT - getParamsReport", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistorico - REPORT - getParamsReport", e);
		}
		return params;
	}

	@Override
	protected JRDataSource getJRDataSource(HttpServletRequest request) {

		Collection<BuroCreditoHistoricoDTO> collection = new ArrayList<BuroCreditoHistoricoDTO>();
		try {
			Integer idCliente = Integer.parseInt(request.getParameter(ConstantValue.Params.ID_CUSTOMER));
			logger.logDebug("---->> INICIO BuroCreditoHistoricoServlet - SUB-REPORT - getJRDataSource idCliente:" + idCliente);
			
			String sessionId = null;
			
			if(SessionManager.getSessionId() != null){
				sessionId = SessionManager.getSessionId();
			} else {
				FilesUtilClass filesUtilClass = new FilesUtilClass();
				sessionId = filesUtilClass.getSession(request);
				/*SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
				CTSServiceResponseTO response = new CTSServiceResponseTO();
		        COBISSecurityManager.ClearSessionId(wSessionSecurityKey);
		        sessionId = COBISSecurityManager.initializeSession(serviceIntegration, wSessionSecurityKey, response);
				if(sessionId == null){
					if (logger.isErrorEnabled()) {
		                logger.logError(response);
		            }
		            throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
				}
				logger.logDebug("---->> INICIO BuroCreditoHistoricoServlet - SUB-REPORT - no hay session");
				*/
			}
			// Clases			
			BuroCreditoHistoricalServices buroCredHistServices = new BuroCreditoHistoricalServices();
			BuroCreditoHistoricoDTO list = new BuroCreditoHistoricoDTO();
			BuroCreditoHistoricoImpl imp = new BuroCreditoHistoricoImpl();
			List<BuroCreditoHistoricoDTODom> domicilios = new ArrayList<BuroCreditoHistoricoDTODom>();
			List<BuroCreditoHistoricoDTOEmp> domicilioEmpleo = new ArrayList<BuroCreditoHistoricoDTOEmp>();
			List<BuroCreditoHistoricoDTODetCreditos> detCreditos = new ArrayList<BuroCreditoHistoricoDTODetCreditos>();
			List<BuroCreditoHistoricoDTOResumenCredito> resumenCredito = new ArrayList<BuroCreditoHistoricoDTOResumenCredito>();
			List<BuroCreditoHistoricoDTODetConsultas> detConsultas = new ArrayList<BuroCreditoHistoricoDTODetConsultas>();
			List<BuroCreditoHistoricoDTOScoreBuro> scoreBuro = new ArrayList<BuroCreditoHistoricoDTOScoreBuro>();

			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setClient(idCliente);
			reportRequest.setFormatDate(ConstantValue.valueConstant.FORMAT_DATE);

			ReportIEAddressResponse[] histoAddress = buroCredHistServices.histoAddress(sessionId, reportRequest, serviceIntegration);
			ReportHistEmployeeHomeResponse[] rhAddressEmpl = buroCredHistServices.histAddressEmpl(sessionId, reportRequest, serviceIntegration);
			ReportHistDetailTheCreditsResponse[] rhDatailCred = buroCredHistServices.histDatailCred(sessionId, reportRequest, serviceIntegration);
			ReportHistCreditsSummaryPrincipalResponse[] rhPrincipalSummaryCred = buroCredHistServices.histPrincipalSummaryCred(sessionId, reportRequest, serviceIntegration);
			ReportHistDetailConsultationsResponse[] rhtDetailConsultations = buroCredHistServices.histDetailConsultations(sessionId, reportRequest, serviceIntegration);
			ReportHistScoreBuroResponse[] rhScoreBuro = buroCredHistServices.histScoreBuro(sessionId, reportRequest, serviceIntegration);

			// Llamar a los futuros servicios
			domicilios = imp.getDetalleDom(histoAddress, serviceIntegration);
			domicilioEmpleo = imp.getDetalleDomEmpRep(rhAddressEmpl, serviceIntegration);
			detCreditos = imp.detCreditos(rhDatailCred, serviceIntegration);// BIEN
			resumenCredito = imp.resumenCreditos(rhPrincipalSummaryCred, serviceIntegration);// BIEN
			detConsultas = imp.detConsult(rhtDetailConsultations, serviceIntegration);// BIEN
			scoreBuro = imp.scoreBuro(rhScoreBuro, serviceIntegration); // BIEN

			list.setDomicilios(domicilios);
			list.setDomicilioEmpleo(domicilioEmpleo);
			list.setDetCreditos(detCreditos);
			list.setResumenCredito(resumenCredito);
			list.setDetConsultas(detConsultas);
			list.setScoreBuroCredito(scoreBuro);

			collection.add(list);
		} catch (Exception e) {
			logger.logDebug("---->> ERROR BuroCreditoHistorico - REPORT - getDatasourceReport", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistorico - REPORT - getDatasourceReport", e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	public void initHeaderCB(Map<String, Object> params) {
		params.put("cabFechHoraEmiReport", "");
		params.put("cabSucursal", "");
		params.put("cabFuncionario", "");
		params.put("cabFechaHoraConsultaBC", "");
		params.put("cabFolioConsultaBuro", "");
		params.put("datGenNombres", "");
		params.put("datGenApellidos", "");
		params.put("datGenRFC", "");
		params.put("datGenFechaNacimiento", "");
		params.put("datGenIFE", "");
		params.put("datGenEstadoCivil", "");
		params.put("datGenRegBC", "");
	}

	public void initHeaderNC(Map<String, Object> params) {
		params.put("ncTotal", 0);
		params.put("ncEnPagosFijosEHipoteca", 0);
		params.put("ncRevolventesYAbiertas", 0);
		params.put("ncCerradas", 0);
		params.put("ncNumCtasNegativasActuales", 0);
		params.put("ncNumCtasEnDisputa", 0);
		params.put("ncNumSolicÚltimos6Meses", 0);
		params.put("ncTotalSaldosActualesCtasRevolAbi", 0.0);
		params.put("ncTotalSaldosVencidosCtasRevolAbi", 0.0);
		params.put("cpfhTotalSaldosActuales", 0.0);
		params.put("cpfhTotalSaldosVencidos", 0.0);
		params.put("cpfhImporteTotalPagos", 0.0);
		params.put("cpfhTotalCreditosMax", 0.0);
		params.put("dscobLimiteDeCreditoCtasRevolv", 0.0);
		params.put("dscobDCTotalCts", 0);
		params.put("dscobNumCtasClavesMopHistNegativa",  0);
		params.put("dscobDCFechaAbrioCtaMasReciente",  "");
		params.put("dscobDCNumTotalSolicitudesHechas",  0);
		params.put("dscobDCFechaSolicitudMasReciente",  "");
		params.put("dscobFechaAbrioCtaMasAntigua", "");
		params.put("dscobFechaAbrioCtaMasReciente", "");
		params.put("dscobNumTotalSolicReportesCredito", 0);
		params.put("dscobFechaMasRecienteSolicitoReporteCredito", "");
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
