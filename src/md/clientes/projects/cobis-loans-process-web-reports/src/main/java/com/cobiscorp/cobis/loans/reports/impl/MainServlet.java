package com.cobiscorp.cobis.loans.reports.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

public abstract class MainServlet extends HttpServlet {
	// FIELDS
	private static final long serialVersionUID = 1L;
	private   String APPLICATION_TYPE = "HTML";// PDF, HTML , EXCEL, RTF
	private  String REPORT_JASPER_PATH = "";
	protected final int DATE_FORMAT = 103;

	// PROPERTIES
	protected String getApplicationType() {
		return APPLICATION_TYPE;
	}

	protected void setApplicationType(String applicationType) {
		APPLICATION_TYPE = applicationType;
	}

	protected String getReportJasperPath() {
		return REPORT_JASPER_PATH;
	}

	protected void setReportJasperPath(String reportJasperPath) {
		String cobishome = COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE);
		this.REPORT_JASPER_PATH = cobishome + reportJasperPath;
	}

	// METHODS - ABSTRACT
	protected abstract Map<String, Object> getParameters();

	protected abstract JRDataSource getJRDataSource();

	// METHODS - PROTECTED
	public void generate(HttpServletRequest request, HttpServletResponse response) throws JRException, IOException {
		request.setCharacterEncoding("UTF-8");
		// Return report print
		JasperPrint jasperPrint = JasperFillManager.fillReport(this.REPORT_JASPER_PATH, getParameters(), getJRDataSource());

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

}
