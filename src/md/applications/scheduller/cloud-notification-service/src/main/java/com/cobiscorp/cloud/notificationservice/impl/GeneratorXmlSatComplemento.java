package com.cobiscorp.cloud.notificationservice.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.olap4j.Axis.Standard;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class GeneratorXmlSatComplemento extends Thread implements Job {

	private static final Logger logger = Logger.getLogger(GeneratorXmlSatComplemento.class);
	private static final String CAB_XML = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
	private static final String FILE_EXT = ".xml";
	private static String wFilesPath = "";
	private String tipoOperacion;

	public GeneratorXmlSatComplemento(String tipoOperacion) {
		super();
		this.tipoOperacion = tipoOperacion;
	}

	public GeneratorXmlSatComplemento() {
		super();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub

		try {
			logger.debug("JobName: " + arg0.getJobDetail().getName());

			GeneratorXmlSatComplemento xml2 = new GeneratorXmlSatComplemento("REVOLVENTE");
			xml2.start();

			GeneratorXmlSatComplemento xml1 = new GeneratorXmlSatComplemento("GRUPAL");
			xml1.start();

		} catch (Exception ex) {
			logger.error("Exception Complemento: ", ex);
		}

	}

	@Override
	public void run() {
		Connection cn = null;
		CallableStatement executeSP = null;

		try {

			String estadoGENXML = "";
			String timbrarXML = "";
			String generarPdf = "";
			String enviarEmail = "";

			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotificationGeneral(cn, executeSP, tipoOperacion);

			logger.debug("Tipo de Operacion COmplemento" + tipoOperacion);
			logger.debug("result: " + result);
			while (result.next()) {
				estadoGENXML = result.getString(1);
				timbrarXML = result.getString(2);
				generarPdf = result.getString(3);
				enviarEmail = result.getString(4);

				logger.debug("estadoGENXML para Complemento  " + tipoOperacion + ": " + estadoGENXML);
				logger.debug("timbrarXML para comlemento " + tipoOperacion + ": " + timbrarXML);
				logger.debug("generarPdf para complemento " + tipoOperacion + ": " + generarPdf);
				logger.debug("enviarEmail para complemento " + tipoOperacion + ": " + enviarEmail);
			}

			logger.debug("Estado para el tipo de operacion complemento:--> " + estadoGENXML + " " + tipoOperacion);

			if (estadoGENXML.equalsIgnoreCase("SI")) {
				logger.debug("Ingresa si es SI a ejecutar complemento:--> " + estadoGENXML + " " + tipoOperacion);
				wFilesPath = pathGenerateXmlSAT();
				logger.debug("wFilesPath para complemento: " + wFilesPath);
				ResultSet wXmlResultSet = getCustomerXmlList(tipoOperacion);
				createXmlFiles(wXmlResultSet, wFilesPath);
			} else {
				logger.debug("No se ejecuta ya que el parametro no es SI:valor del parametro regla:--> " + estadoGENXML + "" + tipoOperacion);
			}

		} catch (Exception ex) {
			logger.error("Exception: ", ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
		}

	}

	private static void createXmlFiles(ResultSet xmlResultSet, String filesPath) {
		logger.debug("Ingresa a createXmlFiles Complemento -->");
		String wFileName = "";
		String wFileOperation = "";
		File wXmlFile = null;
		BufferedWriter wBufferedWriter;
		Connection rConnection = null;
		PreparedStatement wPrepStat = null;
		try {
			ConfigManager ds = ConfigManager.getInstance();
			rConnection = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			while (xmlResultSet.next()) {
				wFileName = xmlResultSet.getString("file_name");
				wFileOperation = xmlResultSet.getString("num_operation");
				logger.debug("num_operation Complemento -->" + wFileOperation);
				try {
					if (wFileName != null && !"".equals(wFileName)) {
						wXmlFile = new File(filesPath + File.separator + wFileName + FILE_EXT);
						wBufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(wXmlFile), Charset.forName("UTF-8")));
						wBufferedWriter.write(xmlResultSet.getString("linea"));

						wBufferedWriter.close();
					} else {
						logger.error("ERROR createXmlFiles no se generó Complemento -->" + xmlResultSet.getString("linea"));
					}

				} catch (IOException e) {
					logger.error("ERROR createXmlFiles IOException Complemento -->", e);
				}

				getUpdateStatusXml(rConnection, wFileOperation, wFileName);
				logger.debug("actualizacion a estado y creacion del archivo de la  operacion Complemento -->" + wFileOperation);

			}
		} catch (SQLException e) {
			logger.error("ERROR createXmlFiles SQLException Complemento -->", e);
		}
	}

	private static String getXmlFileName(String xmlSqlString) {
		String xmlString = null;
		Document doc1 = null;
		try {
			doc1 = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new InputSource(new StringReader(xmlSqlString)));
			if (doc1 != null) {
				NodeList nList = doc1.getElementsByTagName("FacturaInterfactura");
				for (int i = 0; i < nList.getLength(); i++) {
					Node nNode = nList.item(i);
					Element eElement = (Element) nNode;
					Element cElement = (Element) eElement.getElementsByTagName("Receptor").item(0);
					if (cElement != null) {
						xmlString = cElement.getAttribute("Ente");
					} else {
						logger.error("ERROR getXmlFileName: No contiene Segmento Ente/Receptor Complemento");
					}
				}
			}
		} catch (ParserConfigurationException e) {
			logger.error("ERROR getXmlFileName ParserConfigurationException Complemento -->", e);
		} catch (SAXException e) {
			logger.error("ERROR getXmlFileName SAXException Complemento -->", e);
		} catch (IOException e) {
			logger.error("ERROR getXmlFileName IOException Complemento -->", e);
		} catch (NullPointerException e) {
			logger.error("ERROR getXmlFileName NullPointerException Complemento -->", e);
		}
		return xmlString;
	}

	private static ResultSet getCustomerXmlList(String tipoOperacion) {
		Connection rConnection = null;
		PreparedStatement wPrepStat = null;
		try {
			logger.debug("getCustomerXmlList --> " + tipoOperacion);
			ConfigManager ds = ConfigManager.getInstance();
			rConnection = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			wPrepStat = rConnection.prepareStatement("select linea, file_name,num_operation from cob_credito..cr_complemento_pago_xml where status=? and tipo_operacion =?");
			wPrepStat.setString(1, "P");
			wPrepStat.setString(2, tipoOperacion);
			return wPrepStat.executeQuery();

		} catch (SQLException e) {
			logger.error("ERROR getCustomerXmlList Complemento -->", e);
		}
		return null;
	}

	private static int getUpdateStatusXml(Connection rConnection, String operation, String nameFile) {
		logger.debug("getUpdateStatusXml num_operation complemento -->" + operation);
		logger.debug("getUpdateStatusXml filename complemento -->" + nameFile);
		PreparedStatement wPrepStat = null;
		Date date = new Date();
		try {
			wPrepStat = rConnection.prepareStatement("UPDATE cob_credito..cr_complemento_pago_xml SET status=?,processing_date=? where num_operation=? and status=? and file_name=?");
			wPrepStat.setString(1, "F");
			wPrepStat.setTimestamp(2, new java.sql.Timestamp(date.getTime()));
			wPrepStat.setString(3, operation);
			wPrepStat.setString(4, "P");
			wPrepStat.setString(5, nameFile);
			return wPrepStat.executeUpdate();

		} catch (SQLException e) {
			logger.error("ERROR getCustomerXmlList Complemento -->", e);
		}
		return 0;
	}

	private static String pathGenerateXmlSAT() {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa pathGenerateXmlSAT Para Complementos");
		}

		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.GXMLCO);
		String path = "";
		path = copyFileJob.getDestinationFolder();
		logger.debug(" ruta para getGenerarXmlSatComplemento()-->" + path);
		if (path == null || path.equals("") || path.equals(" ")) {
			logger.debug("No existe ruta para Depositar los archivos xml SAT Para complementos");
			return null;
		}
		return path;
	}

	public static ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String toperation) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa executeNotification General XMLSAT para Complemento");
		}
		String query = "{ call cob_conta_super..sp_admin_est_cta(?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, toperation);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("ERROR executeNotification General en Xml complemento -->", ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza executeNotification General Xml complemento");
			}
		}

	}

}
