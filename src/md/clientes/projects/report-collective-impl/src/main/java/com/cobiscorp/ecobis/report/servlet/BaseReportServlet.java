package com.cobiscorp.ecobis.report.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;

/**
 * Clase base para reportes.
 * 
 * @author sgavilanes
 * 
 */
public abstract class BaseReportServlet extends HttpServlet {

	/**
	 * Clase que permite obtener el identificador del tipo de archivo para PDF.
	 */
	protected static final String APPLICATION_PDF = "application/pdf";
	private static final ILogger logger = LogFactory.getLogger(BaseReportServlet.class);
	private static String REPORTJASPERPATH = "reportJasperPath";
	/**
	 * Id por serialización.
	 */
	private static final long serialVersionUID = 1L;

	// METHODS - ABSTRACT
	protected abstract Map<String, Object> getParameters();

	protected abstract JRDataSource getJRDataSource();

	/**
	 * Metodo que permite generar el reporte
	 * 
	 * @param request
	 * @param response
	 * @throws JRException
	 * @throws IOException
	 */
	public void generate(HttpServletRequest request, HttpServletResponse response) throws JRException {
		try {
			request.setCharacterEncoding("UTF-8");
			// Return report print

			JRDataSource data = getJRDataSource();
			Map<String, Object> params = getParameters();
			logger.logDebug("params: " + params);

			JasperPrint jasperPrint = JasperFillManager.fillReport(REPORTJASPERPATH, params, data);

			// Redirect servlet according to the export
			ServletOutputStream out = response.getOutputStream();
			response.setContentType(APPLICATION_PDF);

			JasperExportManager.exportReportToPdfStream(jasperPrint, out);
			out.flush();
			out.close();
		} catch (IOException ie) {
			logger.logError("ERROR REPORT ", ie);
		}
	}

	/**
	 * Método que permite obtener el directorio de reportes
	 * 
	 * @return
	 */
	protected String getReportJasperPath() {
		return REPORTJASPERPATH;
	}

	protected static void setReportJasperPath(String reportJasperPath) {
		String cobishome = COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE);
		REPORTJASPERPATH = cobishome + reportJasperPath;
	}

}
