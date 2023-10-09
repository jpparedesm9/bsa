package com.cobiscorp.ecobis.report.servlet;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.report.dto.AdvisorReportDto;
import com.cobiscorp.ecobis.clientviewer.report.service.AdvisorReportService;
import com.cobiscorp.ecobis.collective.commons.services.AdvisorExternalManager;
import com.cobiscorp.ecobis.report.util.Constants;
import com.cobiscorp.ecobis.report.util.GenericParameter;
import com.cobiscorp.ecobis.report.util.Util;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.collective.dto.AdvisorExternalResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;

public class AdvisorReportHistoryServlet extends BaseReportServlet {

	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(AdvisorReportHistoryServlet.class);
	private static ICTSServiceIntegration serviceIntegration;
	private JasperReportsContext jasperReportsContext;
	private static AdvisorReportService service = new AdvisorReportService();

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.
	 * HttpServletRequest , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.
	 * HttpServletRequest , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		loadDataReport(request, response);

	}

	public void loadDataReport(HttpServletRequest request, HttpServletResponse response) {
		 
		try {
			logger.logDebug("ingresa a Load report ");
			
			JasperPrint jasperPrint = new JasperPrint();
			AdvisorExternalRequest advisorExternalRequest =new AdvisorExternalRequest();
			advisorExternalRequest.setOperation("B");
			logger.logDebug("advisorExternalRequest"+advisorExternalRequest.getOperation());
			//AdvisorExternalManager advisorExternalManager = new AdvisorExternalManager(serviceIntegration);
			
			logger.logDebug("ingresa a Load report antes ");
			AdvisorExternalResponse[] advisorExternalResponse1 =service.queryAdvisorExecl(advisorExternalRequest, serviceIntegration) ;//advisorExternalManager.searchAdvisorExternalExecl(advisorExternalRequest);
			logger.logDebug("ingresa a Load report antes "+advisorExternalResponse1);
			List<AdvisorReportDto> advisorReports = new ArrayList<AdvisorReportDto>();
			for (AdvisorExternalResponse advisorExternal : advisorExternalResponse1) {
				if (advisorExternal != null) {
					advisorReports.add(mapSGDTOtoDTO1(advisorExternal));
				}
			}
			//List<AdvisorExternalResponse> advisorExternalResponse = Arrays.asList(advisorExternalResponse1);
			
			for (AdvisorReportDto advisorReportDto : advisorReports) {
				if (advisorReportDto != null) {
					logger.logDebug("getIdSecuencial()---> " + advisorReportDto.getCustomerId());
					logger.logDebug("advisorExternal---> " + advisorReportDto.getCustomerName());
					
				}
			}
			
			logger.logDebug("ingresa a Load repor"+advisorReports.size());

			if (advisorReports != null && advisorReports.size() > 0) {

				// net.sf.jasperreports.engine.data.JRBeanCollectionDataSource
				// dataSourceTest = new
				// JRBeanCollectionDataSource(beanCollection)
				/*
				 * if (logger.isDebugEnabled()) { for (String key :
				 * prepareDataHistoryMap.keySet()) { logger.logDebug(
				 * "-----------------historicDetail-------------------------------"
				 * ); logger.logDebug("key: " + key + " value: " +
				 * prepareDataHistoryMap.get(key)); } }
				 */
				request.setCharacterEncoding("UTF-8");
				GenericParameter parameters = new GenericParameter();
				if (logger.isDebugEnabled()) {
					logger.logDebug("report---> " + request.getParameter("report"));
					logger.logDebug("title---> " + request.getParameter("title"));
					logger.logDebug("clientName---> " + request.getParameter("clientName"));
					logger.logDebug("formatDate---> " + request.getParameter("formatDate"));
				}

				String title = request.getParameter("title");
				String report = request.getParameter("report");
				String clientName = request.getParameter("clientName");
				String dateFormatPattern = request.getParameter("formatDate");
				jasperPrint = JasperFillManager.fillReport(Util.getDirectory() + Constants.ADVISOR_REPORT, parameters.getReportsParameter(title, report, clientName, dateFormatPattern, Util.getDataSourceCollection(advisorReports, report, dateFormatPattern)), new JREmptyDataSource());
				ServletOutputStream out = response.getOutputStream();
				response.setHeader("Content-disposition", "attachment; filename=" + title + ".xlsx");
				response.setContentType(Constants.XLSX_TYPE);
				generarXLSX(jasperPrint,out);
				//JasperExportManager.exportReportToPdfStream(jasperPrint, out);
				out.flush();
				out.close();
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("La sesion de datos historicos  es NULL");
				}
			}

		}

		catch (JRException e) {
			logger.logError("Error en la generaci�n del reporte de " + Constants.ADVISOR_REPORT, e);
		} catch (IOException e) {
			logger.logError("Error en la generaci�n del reporte de " + Constants.ADVISOR_REPORT, e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza la generaci�n del reporte de " + Constants.ADVISOR_REPORT);
			}
		}

	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		AdvisorReportHistoryServlet.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration() {
		AdvisorReportHistoryServlet.serviceIntegration  = null;
	}

    public void generarXLSX(JasperPrint jasperPrint,ServletOutputStream outputStream) throws  JRException, IOException {  	 
    	JRXlsxExporter docxExporter = new JRXlsxExporter();
        docxExporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
        docxExporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, outputStream);
        docxExporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
        docxExporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
        docxExporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
        docxExporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
        
 
        docxExporter.exportReport();


    }

	@Override
	protected Map<String, Object> getParameters() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected JRDataSource getJRDataSource() {
		// TODO Auto-generated method stub
		return null;
	}	
	
	
	public static AdvisorReportDto mapSGDTOtoDTO1(AdvisorExternalResponse advisorExternalResponse) {

		AdvisorReportDto advisorReportDto = null;

		advisorReportDto = new AdvisorReportDto();
		advisorReportDto.setAsesorExterno(advisorExternalResponse.getAsesorExterno()!=null?advisorExternalResponse.getAsesorExterno():"");
		advisorReportDto.setCollective(advisorExternalResponse.getCollective());
		advisorReportDto.setCustomerAddress(advisorExternalResponse.getCustumerAddress());
		advisorReportDto.setCustomerCell(advisorExternalResponse.getCustomerCell());
		advisorReportDto.setCustomerName(advisorExternalResponse.getCustomerName());
		advisorReportDto.setEmail(advisorExternalResponse.getEmail());
		advisorReportDto.setCustomerId(advisorExternalResponse.getCustomerId());

		return advisorReportDto;

	}
	
	
}
