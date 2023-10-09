package com.cobiscorp.cobis.customer.reports.servlet;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;
import cobiscorp.ecobis.htm.api.dto.CredentialsRequest;
import cobiscorp.ecobis.htm.api.dto.CredentialsResponse;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.customer.reports.commons.ConstantValue;
import com.cobiscorp.cobis.customer.reports.commons.Services;
import com.cobiscorp.cobis.customer.reports.services.DigitalizacionReporteServices;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.inbox.storage.services.IStorageService;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.platform.web.servlet.util.CredentialsDTO;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;
import com.cobiscorp.cobis.platform.web.servlet.util.GetCredentialsImpl;

public abstract class MainServlet extends HttpServlet {

	private static ILogger logger = LogFactory.getLogger(MainServlet.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	// FIELDS
	private static final long serialVersionUID = 1L;
	private String APPLICATION_TYPE = "HTML";// PDF, HTML , EXCEL, RTF
	private String REPORT_JASPER_PATH = "";
	protected final int DATE_FORMAT = 103;
	Services services = new Services();

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Main Set serviceIntegration:" + serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	// PROPERTIES
	protected String getApplicationType() {
		return APPLICATION_TYPE;
	}

	protected void setApplicationType(String applicationType) {
		this.APPLICATION_TYPE = applicationType;
	}

	protected String getReportJasperPath() {
		return REPORT_JASPER_PATH;
	}

	protected void setReportJasperPath(String reportJasperPath) {
		String cobishome = COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE);
		this.REPORT_JASPER_PATH = cobishome + reportJasperPath;
	}

	// METHODS - ABSTRACT
	protected abstract Map<String, Object> getParameters(HttpServletRequest request);

	protected abstract JRDataSource getJRDataSource(HttpServletRequest request);

	// METHODS - PROTECTED
	public void generate(HttpServletRequest request, HttpServletResponse response) throws JRException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Return report print
		JasperPrint jasperPrint = JasperFillManager.fillReport(this.REPORT_JASPER_PATH, getParameters(request), getJRDataSource(request));
		String initialString = "text";
		InputStream targetStream = new ByteArrayInputStream(initialString.getBytes());

		// Redirect servlet according to the export
		if (this.APPLICATION_TYPE.equals("HTML")) {
			exportReportAsHtml(jasperPrint, response.getWriter());
		} else {
			ServletOutputStream out = response.getOutputStream();

			response.setContentType(this.APPLICATION_TYPE);
			if (this.APPLICATION_TYPE.equals("application/pdf"))
				JasperExportManager.exportReportToPdfStream(jasperPrint, out);

			out.flush();
			out.close();
		}
	}

	// METHODS - PROTECTED
	public void generate(HttpServletRequest request, HttpServletResponse response, ICTSServiceIntegration serviceIntegration, String report) throws JRException, IOException {
		try {
			FilesUtilClass filesUtilClass = new FilesUtilClass();
			String session = filesUtilClass.getSession(request);
			request.setCharacterEncoding("UTF-8");
			String idCliente = request.getParameter(ConstantValue.Params.ID_CUSTOMER);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicio uploadFile: ");
			}
			// Return report print
			JasperPrint jasperPrint = JasperFillManager.fillReport(this.REPORT_JASPER_PATH, getParameters(request), getJRDataSource(request));
			// Redirect servlet according to the export
			if (this.APPLICATION_TYPE.equals("HTML")) {
				exportReportAsHtml(jasperPrint, response.getWriter());
			} else {
				// ServletOutputStream out = response.getOutputStream();
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				response.setContentType(this.APPLICATION_TYPE);
				if (this.APPLICATION_TYPE.equals("application/pdf"))
					JasperExportManager.exportReportToPdfStream(jasperPrint, out);

				response.getOutputStream().write(out.toByteArray());

				if (!report.equals("")) {
					uploadFile(session, idCliente, report, out.toByteArray(), serviceIntegration);
				}
				
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}

		} catch (Exception ex) {
			logger.logError("----->>>Error al generar", ex);
			throw new RuntimeException("Error al generar el reporte", ex);
		}
	}

	// Reporte de Buro
	public void generateBuro(HttpServletRequest request, HttpServletResponse response, ICTSServiceIntegration serviceIntegration, String report, String sessionId)
			throws JRException, IOException {
		try {

			logger.logDebug("Inicio MainServlet Buro XX");
			FilesUtilClass filesUtilClass = new FilesUtilClass();
			String session = filesUtilClass.getSession(request);
			request.setCharacterEncoding("UTF-8");
			String idCliente = request.getParameter(ConstantValue.Params.ID_CUSTOMER);
			logger.logDebug("La session en generate buró: " + session);
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicio uploadFile: ");
			}
			// Return report print
			JasperPrint jasperPrint = JasperFillManager.fillReport(this.REPORT_JASPER_PATH, getParameters(request), getJRDataSource(request));
			// Redirect servlet according to the export
			if (this.APPLICATION_TYPE.equals("HTML")) {
				exportReportAsHtml(jasperPrint, response.getWriter());
			} else {
				// ServletOutputStream out = response.getOutputStream();
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				response.setContentType(this.APPLICATION_TYPE);
				if (this.APPLICATION_TYPE.equals("application/pdf"))
					JasperExportManager.exportReportToPdfStream(jasperPrint, out);

				response.getOutputStream().write(out.toByteArray());
			
				if (!report.equals("")) {
					if(request.getSession(false).getAttribute("user") != null){ 
						uploadFile(session, idCliente, report, out.toByteArray(), serviceIntegration);
					} else {
						uploadFile(session, idCliente, report, out.toByteArray(), serviceIntegration, true);
					}
				}
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}

		} catch (Exception ex) {
			Integer idCliente = Integer.parseInt(request.getParameter(ConstantValue.Params.ID_CUSTOMER));
			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setClient(idCliente);
			reportRequest.setOperation('F');
			services.updateBuroMistake(sessionId, reportRequest, serviceIntegration);
			logger.logError("----->>>Error al generar", ex);
			throw new RuntimeException("Error al generar el reporte", ex);
		}
	}

	// METHODS - PRIVATE
	private static void exportReportAsHtml(JasperPrint jasperPrint, PrintWriter out) throws JRException {
		JRHtmlExporter exporter = new JRHtmlExporter();
		exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
		exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
		exporter.setParameter(JRHtmlExporterParameter.CHARACTER_ENCODING, "ISO-8859-9");
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
		exporter.exportReport();
	}

	private void uploadFile(String session, String customerId, String fileName, byte[] parFile, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicio uploadFile " + session + " " + customerId);
			logger.logDebug("Array" + parFile.toString());
		}
		GetCredentialsImpl getCredentialsImpl = new GetCredentialsImpl();
		getCredentialsImpl.setServiceIntegration(serviceIntegration);

		CredentialsDTO credentials = null;
		try {
			credentials = getCredentialsImpl.getCredentials(session);
		} catch (Exception e) {
			new Exception("No se encuentra autorizado para realizar esta acción");
		}

		String password = credentials.getPassword();

		ComponentLocator componetlocator = ComponentLocator.getInstance(this);

		IStorageService spl = null;

		if (componetlocator != null) {
			spl = componetlocator.find(IStorageService.class, StorageConfiguration.getFilterEntity(1));
		}

		if (customerId != null && !customerId.equalsIgnoreCase("0")) {
			spl.createFolder(StorageConfiguration.getConfiguration(1, "library"), ConstantValue.Params.ROOT_FOLDER_CUSTOMER + "/" + customerId,
					StorageConfiguration.getConfiguration(1, "login"), password);

			UpLoadReport.saveFile(StorageConfiguration.getConfiguration(1, "library") + "/" + ConstantValue.Params.ROOT_FOLDER_CUSTOMER + "/" + customerId, fileName, parFile,
					StorageConfiguration.getConfiguration(1, "login"), password);

			activateReport(customerId, fileName, serviceIntegration);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("Finaliza uploadFile");
	}
	
	private void uploadFile(String session, String customerId, String fileName, byte[] parFile, ICTSServiceIntegration serviceIntegration, boolean isMobile) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicio uploadFile 2 " + session + " " + customerId);
			logger.logDebug("Array" + parFile.toString());
		}
		CredentialsDTO credentials = new CredentialsDTO();
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceRequest header = new ServiceRequest();
			CredentialsRequest credentialsRequest = new CredentialsRequest();
			credentialsRequest.setNameFileCredential("");
			ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
			CredentialsResponse credentialsResponse = new CredentialsResponse();
			
			serviceRequestTO.setServiceId("HTM.API.HumanTask.GetCredencials");
			serviceRequestTO.getData().put("inCredentialsRequest", credentialsRequest);
			serviceRequestTO.getData().put("outCredentialsResponse", credentialsRequest);
		    serviceRequestTO.setSessionId(session);
			
	        header.addFieldInHeader("sessionId", 'S', serviceRequestTO.getSessionId());
	        serviceRequestTO.addValue("com.cobiscorp.cobis.cts.service.header", header);
	        if (logger.isDebugEnabled()) {
	            logger.logDebug("header: " + header.readFieldInHeader("sessionId"));
	            logger.logDebug("serviceRequestTO.header: " + serviceRequestTO.getValue("com.cobiscorp.cobis.cts.service.header"));
	        }	  
	        
	        serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
	        
	        credentialsResponse = (CredentialsResponse)serviceResponseTO.getValue("returnCredentialsResponse");
	        credentials.setPassword(credentialsResponse.getPassword());
		} catch (Exception e) {
			new Exception("No se encuentra autorizado para realizar esta acción");
		}

		String password = credentials.getPassword();
		 logger.logDebug("El password de la session:  " + password);
		ComponentLocator componetlocator = ComponentLocator.getInstance(this);

		IStorageService spl = null;

		if (componetlocator != null) {
			spl = componetlocator.find(IStorageService.class, StorageConfiguration.getFilterEntity(1));
		}

		if (customerId != null && !customerId.equalsIgnoreCase("0")) {
			spl.createFolder(StorageConfiguration.getConfiguration(1, "library"), ConstantValue.Params.ROOT_FOLDER_CUSTOMER + "/" + customerId,
					StorageConfiguration.getConfiguration(1, "login"), password);

			UpLoadReport.saveFile(StorageConfiguration.getConfiguration(1, "library") + "/" + ConstantValue.Params.ROOT_FOLDER_CUSTOMER + "/" + customerId, fileName, parFile,
					StorageConfiguration.getConfiguration(1, "login"), password);

			activateReport(customerId, fileName, serviceIntegration, session);
		}

		if (logger.isDebugEnabled())
			logger.logDebug("Finaliza uploadFile");
	}

	private void activateReport(String customerId, String nameFile, ICTSServiceIntegration serviceIntegration) {
		try {
			String nameReport;
			String ext;
			String sessionId = SessionManager.getSessionId();
			nameReport = nameFile.substring(0, nameFile.indexOf('.'));
			ext = nameFile.substring(nameFile.indexOf('.') + 1, nameFile.length());

			Date date = new Date();
			Calendar cal = null;
			cal = Calendar.getInstance();
			cal.setTime(date);

			Integer idCliente = Integer.parseInt(customerId);
			// Envio de datos para servcios
			ScannedDocumentsRequest reportRequest = new ScannedDocumentsRequest();
			reportRequest.setProcessInst(0);
			reportRequest.setCustomerId(idCliente);
			reportRequest.setGroupId(0);
			reportRequest.setDate(cal);
			reportRequest.setDocumentType(nameReport);
			reportRequest.setExtension(ext);

			DigitalizacionReporteServices digitalReport = new DigitalizacionReporteServices();
			digitalReport.digitalizarReport(sessionId, reportRequest, serviceIntegration);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicio activateReport");
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services ErroractivateReport " + ex);
			throw new RuntimeException("----->>>Services Error ActivateReport", ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza ActivateReport");
		}
	}
	
	private void activateReport(String customerId, String nameFile, ICTSServiceIntegration serviceIntegration, String sessionId) {
		try {
			String nameReport;
			String ext;
			nameReport = nameFile.substring(0, nameFile.indexOf('.'));
			ext = nameFile.substring(nameFile.indexOf('.') + 1, nameFile.length());

			Date date = new Date();
			Calendar cal = null;
			cal = Calendar.getInstance();
			cal.setTime(date);

			Integer idCliente = Integer.parseInt(customerId);
			// Envio de datos para servcios
			ScannedDocumentsRequest reportRequest = new ScannedDocumentsRequest();
			reportRequest.setProcessInst(0);
			reportRequest.setCustomerId(idCliente);
			reportRequest.setGroupId(0);
			reportRequest.setDate(cal);
			reportRequest.setDocumentType(nameReport);
			reportRequest.setExtension(ext);

			DigitalizacionReporteServices digitalReport = new DigitalizacionReporteServices();
			digitalReport.digitalizarReport(sessionId, reportRequest, serviceIntegration);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicio activateReport");
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services ErroractivateReport " + ex);
			throw new RuntimeException("----->>>Services Error ActivateReport", ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza ActivateReport");
		}
	}
}
