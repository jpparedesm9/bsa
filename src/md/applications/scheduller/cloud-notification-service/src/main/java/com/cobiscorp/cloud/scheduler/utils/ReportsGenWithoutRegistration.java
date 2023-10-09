package com.cobiscorp.cloud.scheduler.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class ReportsGenWithoutRegistration {

	private static final Logger logger = Logger.getLogger(ReportsGenWithoutRegistration.class);
	private static final String EXTENSION_PDF = ".pdf";

	public static Boolean generateReport(String filePathNameReportGenerate, List<?> list, Map<String, Object> paramsReport,
			String reportName, Collection<?> collection) {

		Boolean flag = false;
		logger.debug("-->>Ingresa generateReport");

		InputStream inputStreamPropertiesFile = null;

		try {
			// Para obtener la ruta de los jasper
			inputStreamPropertiesFile = new FileInputStream("notification/configuration.properties");
			Properties properties = new Properties();
			properties.load(inputStreamPropertiesFile);

			String jasperPath = properties.getProperty("JAS.path");

			logger.debug("-->>GenerateReport -->>jasperPath: " + jasperPath);

			JasperPrint jp = new JasperPrint();

			jp = JasperFillManager.fillReport(jasperPath + reportName, paramsReport,
					new JRBeanCollectionDataSource(collection));

			JasperExportManager.exportReportToPdfFile(jp, filePathNameReportGenerate + EXTENSION_PDF);

			flag = true;

		} catch (FileNotFoundException e) {
			logger.error(e.toString());
			throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo de configuraci\u00f3n");

		} catch (Exception ex) {
			logger.error("-->>ERROR generateReport-->", ex);
		}
		logger.debug("-->>Salida generateReport -->>"+flag);
		return flag;
	}

	public static class GenerateReportProperties {

		private String pathXml = "";
		private String pathJasper = "";
		private String pathPdf = "";
		private String nameXml = "";
		private String nameJasper = "";
		private String namePdf = "";
		private String piePagina = "";
		private String nameCompany = "";

		public String getPathXml() {
			return this.pathXml;
		}

		public void setPathXml(String pathXml) {
			this.pathXml = pathXml;
		}

		public String getPathJasper() {
			return this.pathJasper;
		}

		public void setPathJasper(String pathJasper) {
			this.pathJasper = pathJasper;
		}

		public String getPathPdf() {
			return this.pathPdf;
		}

		public void setPathPdf(String pathPdf) {
			this.pathPdf = pathPdf;
		}

		public String getNameXml() {
			return this.nameXml;
		}

		public void setNameXml(String nameXml) {
			this.nameXml = nameXml;
		}

		public String getNameJasper() {
			return this.nameJasper;
		}

		public void setNameJasper(String nameJasper) {
			this.nameJasper = nameJasper;
		}

		public String getNamePdf() {
			return this.namePdf;
		}

		public void setNamePdf(String namePdf) {
			this.namePdf = namePdf;
		}

		public String getPiePagina() {
			return this.piePagina;
		}

		public void setPiePagina(String piePagina) {
			this.piePagina = piePagina;
		}

		public String getNameCompany() {
			return this.nameCompany;
		}

		public void setNameCompany(String nameCompany) {
			this.nameCompany = nameCompany;
		}

	}

}
