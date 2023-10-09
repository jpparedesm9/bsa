package com.cobiscorp.ecobis.report.util;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.j2ee.servlets.BaseHttpServlet;

public abstract class AbstractReportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// PDF, HTML , EXCEL, RTF
	private String exportOption = "PDF";

	public void execute(HttpServletRequest request, HttpServletResponse response) throws JRException, IOException {

		// Create file object with send parameters
		File reportFile = new File(ReportConfigUtil.getJasperFile(getCompileDir(), getCompileFileName()));

		// Compile the report if not exist
		ReportConfigUtil.compileReport(getCompileDir(), getCompileFileName());

		// Return report print
		JasperPrint jasperPrint = ReportConfigUtil.fillReport(reportFile, getReportParameters(), getJRDataSource());

		// Redirect servlet according to the export
		if (exportOption.equals("HTML")) {
			ReportConfigUtil.exportReportAsHtml(jasperPrint, response.getWriter());
		} else {
			request.getSession().setAttribute(BaseHttpServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
			response.sendRedirect("/CTSProxy/services/cobis/report/export/" + getExportOption());
		}

	}

	/**
	 * Map parameters sent to report
	 * 
	 * @return
	 */
	protected Map<String, Object> getReportParameters() {
		Map<String, Object> reportParameters = new HashMap<String, Object>();
		reportParameters.put("nombreOrganizacion", "Cobiscorp");
		return reportParameters;
	}

	/**
	 * Return export option
	 * 
	 * @return
	 */
	public String getExportOption() {
		return exportOption;
	}

	/**
	 * @param exportOption
	 */
	public void setExportOption(String exportOption) {
		this.exportOption = exportOption;
	}

	/**
	 * Return compile directory
	 * 
	 * @return
	 */
	protected abstract String getCompileDir();

	/**
	 * Return JRDataSource (Data Report)
	 * 
	 * @return
	 */
	protected abstract JRDataSource getJRDataSource();

	/**
	 * Return report name
	 * 
	 * @return
	 */
	protected abstract String getCompileFileName();

}
