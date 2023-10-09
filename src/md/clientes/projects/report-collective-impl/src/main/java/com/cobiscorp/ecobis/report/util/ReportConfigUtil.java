package com.cobiscorp.ecobis.report.util;

import java.io.File;
import java.io.PrintWriter;
import java.util.Map;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

public class ReportConfigUtil {

	/*
	 * PUBLIC METHODS
	 */
	public static boolean compileReport(String compileDir, String filename) throws JRException {

		String jasperFileName = getJasperFile(compileDir, filename);

		// jasper file already exists, do not compile again
		File jasperFile = new File(jasperFileName);
		if (jasperFile.exists()) {
			return true;
		}

		// jasper file has not been constructed yet, so compile the xml file
		try {

			String xmlFileName = jasperFileName.substring(0, jasperFileName.indexOf(".jasper")) + ".jrxml";
			JasperCompileManager.compileReportToFile(xmlFileName);
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static JasperPrint fillReport(File reportFile, Map<String, Object> parameters, JRDataSource jrDataSource) throws JRException {
		JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile.getPath(), parameters, jrDataSource);
		return jasperPrint;
	}

	public static String getJasperFile(String compileDir, String filename) {
		return COBISGeneralConfiguration.getEnvironmentVariable(ICOBISTS.COBIS_HOME, ICOBISTS.JVM_SOURCE) + File.separator + compileDir + File.separator + filename + ".jasper";
	}

	public static void exportReportAsHtml(JasperPrint jasperPrint, PrintWriter out) throws JRException {
		JRHtmlExporter exporter = new JRHtmlExporter();
		exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
		exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
		exporter.setParameter(JRHtmlExporterParameter.CHARACTER_ENCODING, "ISO-8859-9");
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
		exporter.exportReport();
	}
}
