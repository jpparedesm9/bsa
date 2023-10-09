package com.cobiscorp.cobis.customer.reports.servlet;

import java.io.IOException;
import java.io.OutputStream;
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
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAccountClientResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIECustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIELoanResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.customer.reports.commons.ConstantValue;
import com.cobiscorp.cobis.customer.reports.commons.Method;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTO;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTODom;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTOHis;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTOSisFin;
import com.cobiscorp.cobis.customer.reports.impl.BuroCreditoInternoExternoImpl;
import com.cobiscorp.cobis.customer.reports.security.COBISSecurityManager;
import com.cobiscorp.cobis.customer.reports.security.SessionSecurityKey;
import com.cobiscorp.cobis.customer.reports.security.dto.CTSServiceResponseTO;
import com.cobiscorp.cobis.customer.reports.services.BuroCreditoInternoExternoServices;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;

//HttpServlet
public class BuroCreditoInternoExternoServlet extends MainServlet {

	private static final String BURO_INTERNO_EXTERNO = "/CUSTOMER/reports/jasper/BuroCreditoInternoExterno.jasper";
	private static final String NOBRE_BURO_INTERNO_EXTERNO = "REPORTE DE CREDITO INTERNO Y EXTERNO";
	private static final String APPLICATION_PDF = "application/pdf";
	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoInternoExternoServlet.class);
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

		logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - execute MainServlet:" + idCliente);
		super.setApplicationType(APPLICATION_PDF);
		super.setReportJasperPath(BURO_INTERNO_EXTERNO);

		try {
			 super.generateBuro(request, resp, serviceIntegration,ConstantValue.Params.BURO_REPORT_INTERNO, sessionId);			
		} catch (JRException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected Map<String, Object> getParameters(HttpServletRequest request) {
		Map<String, Object> params = new HashMap<String, Object>();

		Integer idCliente = Integer.parseInt(request.getParameter(ConstantValue.Params.ID_CUSTOMER));
		
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - REPORT - getParameters idCliente:" + idCliente);
		Method method = new Method();
		method.setPrmMain(params);

		try {
			String sessionId = null;
			
			if(SessionManager.getSessionId() != null){
				sessionId = SessionManager.getSessionId();
			} else {
				FilesUtilClass filesUtilClass = new FilesUtilClass();
				sessionId = filesUtilClass.getSession(request);
			}
			// Servicios
			BuroCreditoInternoExternoServices buroCreditoIEServices = new BuroCreditoInternoExternoServices();

			initHeader(params);
			params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
			params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
			// Envio de datos para servcios
			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setClient(idCliente);
			reportRequest.setFormatDate(ConstantValue.valueConstant.FORMAT_DATE);

			ReportIECustomerResponse[] rIECustomer = buroCreditoIEServices.reportIECustomer(sessionId, reportRequest, serviceIntegration);
			if (rIECustomer != null) {
				logger.logDebug("---->> BuroCreditoInternoExternoServlet - REPORT - getParameters - DTO ReportIECustomerResponse lenght:" + rIECustomer.length);
				if (rIECustomer.length > 0) {
					method.mapValuesToParams("cabFechHoraEmiReport", rIECustomer[0].getReportDate(), "");
					method.mapValuesToParams("cabSucursal", rIECustomer[0].getBranchOffice(), "");
					method.mapValuesToParams("cabFuncionario", rIECustomer[0].getOfficialName(), "");
					method.mapValuesToParams("cabFechaHoraConsultaBC", rIECustomer[0].getDateQueryBR(), "");
					method.mapValuesToParams("datGenClaveCliUnico", rIECustomer[0].getCodeCustomerBS(), "");
					method.mapValuesToParams("datGenNombres", rIECustomer[0].getNames(), "");
					method.mapValuesToParams("datGenApellidos", rIECustomer[0].getLastName(), "");
					method.mapValuesToParams("datGenRFC", rIECustomer[0].getRfc(), "");
					method.mapValuesToParams("datGenFechaNacimiento", rIECustomer[0].getBirthDate(), "");
					method.mapValuesToParams("datGenCURP", rIECustomer[0].getCurp(), "");
					method.mapValuesToParams("datGenEstadoCivil", rIECustomer[0].getCivilStatus(), "");
				} else {
					initHeader(params);
				}
			} else {
				initHeader(params);
			}
		} catch (Exception e) {
			logger.logDebug("---->> ERROR BuroCreditoInternoExternoServlet - REPORT - getParamsReport", e);
			throw new RuntimeException("---->> ERROR BuroCreditoInternoExternoServlet - REPORT - getParamsReport", e);
		}
		return params;
	}

	@Override
	protected JRDataSource getJRDataSource(HttpServletRequest request) {
		
		Collection<BuroCreditoInternoExternoDTO> collection = new ArrayList<BuroCreditoInternoExternoDTO>();
		try {
			Integer idCliente = Integer.parseInt(request.getParameter(ConstantValue.Params.ID_CUSTOMER));
			
			logger.logDebug("---->> INICIO BuroCreditoInternoExternoServlet - SUB-REPORT - getJRDataSource idCliente:" + idCliente);
			
			String sessionId = null;
			
			if(SessionManager.getSessionId() != null){
				sessionId = SessionManager.getSessionId();
			} else {
				FilesUtilClass filesUtilClass = new FilesUtilClass();
				sessionId = filesUtilClass.getSession(request);
			}
			
			// Servicios
			BuroCreditoInternoExternoServices buroCreditoIEServices = new BuroCreditoInternoExternoServices();
			BuroCreditoInternoExternoDTO list = new BuroCreditoInternoExternoDTO();

			BuroCreditoInternoExternoImpl imp = new BuroCreditoInternoExternoImpl();

			List<BuroCreditoInternoExternoDTODom> domicilios = new ArrayList<BuroCreditoInternoExternoDTODom>();
			List<BuroCreditoInternoExternoDTOHis> historico = new ArrayList<BuroCreditoInternoExternoDTOHis>();
			List<BuroCreditoInternoExternoDTOSisFin> sisFinanciero = new ArrayList<BuroCreditoInternoExternoDTOSisFin>();

			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setClient(idCliente);
			reportRequest.setFormatDate(ConstantValue.valueConstant.FORMAT_DATE);

			// ReportIEAccountClientResponse rIEAccountClientResponse = service.
			ReportIEAddressResponse[] rIEAddressResponse = buroCreditoIEServices.reportIEAddressClient(sessionId, reportRequest, serviceIntegration);
			ReportIELoanResponse[] rIEHistorical = buroCreditoIEServices.reportIEHistorical(sessionId, reportRequest, serviceIntegration);
			ReportIEAccountClientResponse[] rIEFinanceSystem = buroCreditoIEServices.reportIEFinanceSystem(sessionId, reportRequest, serviceIntegration);
			// ReportIELoanResponse
			// Llamar a los futuros servicios
			domicilios = imp.getDetalleDom(rIEAddressResponse, serviceIntegration);
			historico = imp.getDetalleHis(rIEHistorical, serviceIntegration);
			sisFinanciero = imp.getDetalleSisFin(rIEFinanceSystem, serviceIntegration); // Bien

			list.setDomicilios(domicilios);
			list.setHistorico(historico);
			list.setSisFinanciero(sisFinanciero);
			collection.add(list);
		} catch (Exception e) {
			logger.logDebug("---->> ERROR BuroCreditoInternoExternoServlet - REPORT - getDatasourceReport", e);
			throw new RuntimeException("---->> ERROR BuroCreditoInternoExternoServlet - REPORT - getDatasourceReport", e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	public void initHeader(Map<String, Object> params) {
		params.put("cabFechHoraEmiReport", "");
		params.put("cabSucursal", "");
		params.put("cabFuncionario", "");
		params.put("cabFechaHoraConsultaBC", "");
		params.put("datGenClaveCliUnico", 0);
		params.put("datGenNombres", "");
		params.put("datGenApellidos", "");
		params.put("datGenRFC", "");
		params.put("datGenFechaNacimiento", "");
		params.put("datCURP", "");
		params.put("datGenEstadoCivil", "");
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
