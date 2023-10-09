package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.AccountStatusDTO;
import com.cobiscorp.cloud.notificationservice.factory.NotificationServiceFactory;
import com.cobiscorp.cloud.notificationservice.service.IServiceBase;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class GenerateReport {

	private static final Logger logger = Logger.getLogger(GenerateReport.class);

	private static final String EXTENSION_PDF = ".pdf";
	private static final String COLUMN_CODE = "codigo";
	private static final String COLUMN_VALUE = "valor";
	private static HashMap<String, GenerateReportProperties> properties = new HashMap<String, GenerateReportProperties>();

	public static GenerateReportProperties getProperties(String parameter) {
		if (!properties.containsKey(parameter)) {
			properties.put(parameter, new GenerateReportProperties());
		}
		return properties.get(parameter);
	}

	public static void generateReport(String parameter, String parameterToPdf, List<?> objectList) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa generateReport");
		}
		
		logger.debug("parameter: " + parameter);
		
		logger.debug("objectList: " + objectList);

		try {
			returnParamGeneric(parameter);
			if (validationParamGeneric(parameter)) {
				int archivo = 0;
				IServiceBase notificationImpl = null;
				if (objectList == null) {
					File xmlFile = returnFile(parameter);
					notificationImpl = NotificationServiceFactory.getClass(parameter);

					if (!xmlFile.exists()) {
						logger.error("Archivo xml no existe.");
						return;
					}
					if (notificationImpl == null) {
						logger.error("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
						return;
					}

					if (!ReadXml.read(xmlFile)) {
						logger.debug("No existe data para procesar.");
						return;
					}

					objectList = notificationImpl.xmlToDTO(xmlFile);
					logger.debug("objectLis" + objectList);
				} else {
					notificationImpl = NotificationServiceFactory.getClass(parameter);
					if (notificationImpl == null) {
						logger.error("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
						return;
					}
				}
				for (Object iterator : objectList) {

					Map<String, Object> parameters = notificationImpl.setParameterToJasper(iterator);
					logger.debug(notificationImpl.setCollection(iterator));
					List<?> dataCol = notificationImpl.setCollection(iterator);
					parameters.put("PIEPAGINA", getProperties(parameter).getPiePagina());
					parameters.put("NOMBREEMPRESA", getProperties(parameter).getNameCompany());

					JasperPrint jp = JasperFillManager.fillReport(returnNameJasper(parameter), parameters,
							new JRBeanCollectionDataSource(dataCol));

					if (parameterToPdf == null) {

						JasperExportManager.exportReportToPdfFile(jp,
								returnNameExportJasper(String.valueOf(archivo), EXTENSION_PDF, false, parameter));
						sendNotification(notificationImpl.setParameterToSendMail(iterator),
								returnNameExportJasper(String.valueOf(archivo), EXTENSION_PDF, true, parameter),
								parameter);
						archivo++;
					} else {

						JasperExportManager.exportReportToPdfFile(jp,
								returnNameExportJasper(parameterToPdf, EXTENSION_PDF, false, parameter));
						sendNotification(notificationImpl.setParameterToSendMail(iterator),
								returnNameExportJasper(parameterToPdf, EXTENSION_PDF, true, parameter), parameter);
					}

				}
			} else {
				logger.error("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
			}
		} catch (Exception ex) {
			logger.error("ERROR generateReport-->", ex);
		}

	}

	public static void generateReport(String parameter, String parameterToPdf, List<?> list, Object objectList) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa generateReport");
		}

		try {

			returnParamGeneric(parameter);
			if (validationParamGeneric(parameter)) {

				int archivo = 0;
				IServiceBase notificationImpl = null;

				notificationImpl = NotificationServiceFactory.getClass(parameter);
				if (notificationImpl == null) {
					logger.error("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
					return;
				}

				logger.debug("Ingresa al iterador..");
				Map<String, Object> parameters = notificationImpl.setParameterToJasper(objectList);
				// List<?> dataCol = notificationImpl.setCollection(objectList);

				Collection<AccountStatusDTO> dataCol = new ArrayList<AccountStatusDTO>();
				AccountStatusDTO accountStatusDTO = (AccountStatusDTO) objectList;

				dataCol.add(accountStatusDTO);

				parameters.put("PIEPAGINA", getProperties(parameter).getPiePagina());
				parameters.put("NOMBREEMPRESA", getProperties(parameter).getNameCompany());

				JasperPrint jp = JasperFillManager.fillReport(returnNameJasper(parameter), parameters,
						new JRBeanCollectionDataSource(dataCol));

				if (parameterToPdf == null) {
					JasperExportManager.exportReportToPdfFile(jp,
							returnNameExportJasper(String.valueOf(archivo), EXTENSION_PDF, false, parameter));
					sendNotification(notificationImpl.setParameterToSendMail(objectList),
							returnNameExportJasper(String.valueOf(archivo), EXTENSION_PDF, true, parameter), parameter);
					archivo++;
				} else {
					JasperExportManager.exportReportToPdfFile(jp,
							returnNameExportJasper(parameterToPdf, EXTENSION_PDF, false, parameter));
					sendNotification(notificationImpl.setParameterToSendMail(objectList),
							returnNameExportJasper(parameterToPdf, EXTENSION_PDF, true, parameter), parameter);
				}

			} else {
				logger.error("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
			}
		} catch (Exception ex) {
			logger.error("ERROR generateReport-->", ex);
		}

	}

	public static void generateReport(String parameter, String parameterToPdf) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa generateReport");
		}
		generateReport(parameter, parameterToPdf, null);
	}

	public static void returnParamGeneric(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa returnParamGeneric");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			String query = "{ call cob_cartera..sp_parametros_notificacion(?) }";

			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);

			executeSP.setString(1, parameter);
			executeSP.execute();

			ResultSet result = executeSP.getResultSet();

			if (result != null) {
				while (result.next()) {
					evalueResulset(result, parameter);
				}
			}

			pathArchives(parameter);
			returnFooterPage(parameter);
			returnNameCompany(parameter);
		} catch (Exception ex) {
			logger.error("ERROR returnParamGeneric:", ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza returnParamGeneric");
			}
		}
	}

	private static File returnFile(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa returnFile");
		}
		return new File(getProperties(parameter).getPathXml().concat(getProperties(parameter).getNameXml()));
	}

	private static String returnNameJasper(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa returnNameJasper");
		}
		return getProperties(parameter).getPathJasper().concat(getProperties(parameter).getNameJasper());
	}

	private static String returnNameExportJasper(String iteracion, String extension, boolean onlyName,
			String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa returnNameJasper");
		}
		return (onlyName ? "" : getProperties(parameter).getPathPdf()).concat(getProperties(parameter).getNamePdf())
				.concat(iteracion).concat(extension);
	}

	private static void sendNotification(Map<String, Object> parameters, String pdfFile, String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa sendNotification");
		}

		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			// Envio de notificacion
			String query = "{ call cob_cartera..sp_notifica_grupo(?,?,?,?,?,?,?,?) }";

			ConfigManager ds = ConfigManager.getInstance();
			Class.forName(ds.getJdbDriver()).newInstance();

			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);

			Integer funcionarioId = (Integer) parameters.get("ID_GRUPO");
			String nombreFuncionario = (String) parameters.get("NOMBRE_GRUPO");

			String emailTO = (String) parameters.get("EMAIL_TO");
			String emailCC = (String) parameters.get("EMAIL_CC");
			String emailBCC = (String) parameters.get("EMAIL_BCC");
			String subject = (String) parameters.get("SUBJECT");

			if (logger.isDebugEnabled()) {
				logger.debug("emailTO-->" + emailTO);
				logger.debug("emailCC-->" + emailCC);
				logger.debug("emailBCC-->" + emailBCC);
				logger.debug("subject-->" + subject);
				logger.debug("funcionarioId-->" + funcionarioId);
				logger.debug("nombreFuncionario-->" + nombreFuncionario);
				logger.debug("pdfFile-->" + pdfFile);
				logger.debug("paramExec-->" + parameter);
			}

			executeSP.setString(1, emailTO);
			executeSP.setString(2, emailCC);
			executeSP.setString(3, emailBCC);
			executeSP.setString(4, subject);
			executeSP.setInt(5, funcionarioId);
			executeSP.setString(6, nombreFuncionario);
			executeSP.setString(7, pdfFile);
			executeSP.setString(8, parameter);

			executeSP.execute();

			if (logger.isDebugEnabled()) {
				logger.debug("finailiza sendNotification");
			}

		} catch (Exception e) {
			logger.error("ERROR sendNotification -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza sendNotification");
			}
		}

	}

	private static void evalueResulset(ResultSet result, String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa evalueResulset");
			logger.debug("result-->" + result.toString());
		}

		String param;
		try {
			if (logger.isDebugEnabled()) {
				logger.debug("COLUMN_CODE-->" + result.getString(COLUMN_CODE));
				logger.debug("COLUMN_VALUE-->" + result.getString(COLUMN_VALUE));
			}

			param = parameter + "_NXML";
			if ((param).equals(result.getString(COLUMN_CODE))) {
				getProperties(parameter).setNameXml(result.getString(COLUMN_VALUE));
			}

			param = parameter + "_NJAS";
			if ((param).equals(result.getString(COLUMN_CODE))) {
				getProperties(parameter).setNameJasper(result.getString(COLUMN_VALUE));
			}

			param = parameter + "_NPDF";
			if ((param).equals(result.getString(COLUMN_CODE))) {
				getProperties(parameter).setNamePdf(result.getString(COLUMN_VALUE));
			}
		} catch (Exception ex) {
			logger.error("ERROR evalueResulset:", ex);
		}
	}

	private static void pathArchives(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa pathArchives");
		}

		ConfigManager config = ConfigManager.getInstance();
		getProperties(parameter).setPathXml(config.getRXmlPath());
		getProperties(parameter).setPathJasper(config.getJasPath());
		getProperties(parameter).setPathPdf(config.getPDFPath());
	}

	private static boolean validationParamGeneric(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa validationParamGeneric");
		}
		if (!(evalueParameter(parameter) && evalueXML(parameter) && evalueJasper(parameter) && evaluePDF(parameter))) {
			return false;
		}
		return true;
	}

	private static boolean evalueParameter(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa evalueParameter");
			logger.debug("paramExec-->" + parameter);
		}

		String valueEmpty = "";
		if (parameter == null || valueEmpty.equals(parameter)) {
			return false;
		}

		return true;
	}

	private static boolean evalueXML(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa evalueXML");

			logger.debug("pathXml-->" + getProperties(parameter).getPathXml());
			logger.debug("nameXml-->" + getProperties(parameter).getNameXml());
		}

		String valueEmpty = "";
		if (getProperties(parameter).getPathXml() == null || valueEmpty.equals(getProperties(parameter).getPathXml())) {
			return false;
		}

		if (getProperties(parameter).getNameXml() == null || valueEmpty.equals(getProperties(parameter).getNameXml())) {
			return false;
		}

		return true;
	}

	private static boolean evalueJasper(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa evalueJasper");
			logger.debug("pathJasper-->" + getProperties(parameter).getPathJasper());
			logger.debug("nameJasper-->" + getProperties(parameter).getNameJasper());
		}

		String valueEmpty = "";
		if (getProperties(parameter).getPathJasper() == null
				|| valueEmpty.equals(getProperties(parameter).getPathJasper())) {
			return false;
		}

		if (getProperties(parameter).getNameJasper() == null
				|| valueEmpty.equals(getProperties(parameter).getNameJasper())) {
			return false;
		}

		return true;
	}

	private static boolean evaluePDF(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa evalueXML");
			logger.debug("pathPdf-->" + getProperties(parameter).getPathPdf());
			logger.debug("namePdf-->" + getProperties(parameter).getNamePdf());
		}

		String valueEmpty = "";
		if (getProperties(parameter).getPathPdf() == null || valueEmpty.equals(getProperties(parameter).getPathPdf())) {
			return false;
		}

		if (getProperties(parameter).getNamePdf() == null || valueEmpty.equals(getProperties(parameter).getNamePdf())) {
			return false;
		}

		return true;
	}

	private static void returnFooterPage(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa returnFooterPage");
		}

		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			String query = "{ call cob_cartera..sp_pie_pagina_notificacion() }";
			StringBuilder piePagina = new StringBuilder();
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			executeSP.execute();

			ResultSet result = executeSP.getResultSet();

			if (result != null) {
				while (result.next()) {

					piePagina.append(result.getString(COLUMN_VALUE));
					piePagina.append("\n");
				}

				getProperties(parameter).setPiePagina(piePagina.toString());
			}

			pathArchives(parameter);
		} catch (Exception ex) {
			logger.error("ERROR returnFooterPage:", ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza returnFooterPage");
			}
		}
	}

	private static void returnNameCompany(String parameter) {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa returnNameCompany");
		}

		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			String query = "{ call cob_cartera..sp_consulta_nombre_empresa(?) }";

			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);

			executeSP.setString(1, parameter);
			executeSP.execute();

			ResultSet result = executeSP.getResultSet();

			if (result != null) {
				while (result.next()) {
					getProperties(parameter).setNameCompany(result.getString(COLUMN_VALUE));
				}
			}

			pathArchives(parameter);
		} catch (Exception ex) {
			logger.error("ERROR returnNameCompany:", ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza returnNameCompany");
			}
		}
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
