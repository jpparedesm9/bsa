package com.cobiscorp.ecobis.report.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.clientviewer.dto.ProductsByClientDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.report.util.Constants;
import com.cobiscorp.ecobis.report.util.GenericParameter;
import com.cobiscorp.ecobis.report.util.GenericParameter;
import com.cobiscorp.ecobis.report.util.Util;

public class ProductHistoryServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final ILogger logger = LogFactory.getLogger(ProductHistoryServlet.class);
	private ICTSServiceIntegration serviceIntegration;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest
	 * , javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		loadDataReport(request, response);

	}

	public void loadDataReport(HttpServletRequest request, HttpServletResponse response) {

		try {
			ServiceResponse serviceResponse = Util.loadHistoryDataClient(request);
			JasperPrint jasperPrint = new JasperPrint();
			if (serviceResponse.isResult()) {
				ProductsByClientDTO prepareDataHistory = (ProductsByClientDTO) serviceResponse.getData();

				if (prepareDataHistory != null && prepareDataHistory.getProductsByClientDTO() != null) {
					HashMap<String, Object> prepareDataHistoryMap = prepareDataHistory.getProductsByClientDTO();
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
					jasperPrint = JasperFillManager.fillReport(
							Util.getDirectory() + Constants.HISTORY_OPERATION_DATA_CLIENT_REPORT,
							parameters.getReportsParameter(title, report, clientName, dateFormatPattern,
									Util.getDataSourceCollection(prepareDataHistoryMap, report, dateFormatPattern)), new JREmptyDataSource());
					ServletOutputStream out = response.getOutputStream();
					response.setContentType(Constants.PDF_TYPE);
					JasperExportManager.exportReportToPdfStream(jasperPrint, out);
					out.flush();
					out.close();
				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("La sesion de datos historicos  es NULL");
					}
				}

			}

		} catch (JRException e) {
			logger.logError("Error en la generaci�n del reporte de " + Constants.HISTORY_OPERATION_DATA_CLIENT_REPORT, e);
		} catch (IOException e) {
			logger.logError("Error en la generaci�n del reporte de " + Constants.HISTORY_OPERATION_DATA_CLIENT_REPORT, e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza la generaci�n del reporte de " + Constants.HISTORY_OPERATION_DATA_CLIENT_REPORT);
			}
		}

	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
