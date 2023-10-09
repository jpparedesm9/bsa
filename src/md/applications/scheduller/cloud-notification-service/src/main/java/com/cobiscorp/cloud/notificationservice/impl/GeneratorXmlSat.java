package com.cobiscorp.cloud.notificationservice.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
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
import java.util.Date;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
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


public class GeneratorXmlSat extends Thread implements Job {

	private static final Logger logger = Logger.getLogger(GeneratorXmlSat.class);
	private static final String CAB_XML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	private static final String FILE_EXT = ".xml";
	private static final String XSI = "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"";
	private static final String SCHEMALOCATION = "xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/4 http://www.sat.gob.mx/sitio_internet/cfd/4/cfdv40.xsd\"";
	private static final String CFDI = "xmlns:cfdi=\"http://www.sat.gob.mx/cfd/4\"";
	private static String wFilesPath = "";
	private String tipoOperacion;

	public GeneratorXmlSat(String tipoOperacion) {
		super();
		this.tipoOperacion = tipoOperacion;
	}

	public GeneratorXmlSat() {
		super();
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		logger.debug("JobName: " + arg0.getJobDetail().getName());

		GeneratorXmlSat xml2 = new GeneratorXmlSat("REVOLVENTE");
		xml2.start();

		GeneratorXmlSat xml1 = new GeneratorXmlSat("GRUPAL");
		xml1.start();

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

			logger.debug("Tipo de Operacion" + tipoOperacion);
			logger.debug("ResultSet: " + result);
			while (result.next()) {
				estadoGENXML = result.getString(1);
				timbrarXML = result.getString(2);
				generarPdf = result.getString(3);
				enviarEmail = result.getString(4);

				logger.debug("estadoGENXML para Factura  " + tipoOperacion + ": " + estadoGENXML);
				logger.debug("timbrarXML para Factura " + tipoOperacion + ": " + timbrarXML);
				logger.debug("generarPdf para Factura " + tipoOperacion + ": " + generarPdf);
				logger.debug("enviarEmail para Factura " + tipoOperacion + ": " + enviarEmail);
			}

			logger.debug("Estado para el tipo de operacion:--> " + estadoGENXML + " " + tipoOperacion);

			if (estadoGENXML.equalsIgnoreCase("SI")) {
				logger.debug("Ingresa si es SI a ejecutar:--> " + estadoGENXML + " " + tipoOperacion);
				wFilesPath = pathGenerateXmlSAT();
				logger.debug("wFilesPath: " + wFilesPath);
				ResultSet wXmlResultSet = getCustomerXmlList(tipoOperacion);
				createXmlFiles(wXmlResultSet, wFilesPath);
			} else {
				logger.debug("No se ejecuta ya que el parametro no es SI:valor del parametro regla:--> " + estadoGENXML + "" + tipoOperacion);
			}

		} catch (Exception ex) {
			logger.error("Exception: " + ex);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
		}

	}

	private static void createXmlFiles(ResultSet xmlResultSet, String filesPath) {
		logger.debug("Ingresa a ejecutar metodo createXmlFiles ");
		String wFileName = "";
		String wFileOperation = "";
		File wXmlFile = null;
		BufferedWriter wBufferedWriter;
		Connection rConnection = null;
		try {
			ConfigManager ds = ConfigManager.getInstance();
			rConnection = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			// Concatenación de referencias
			StringBuilder ref = new StringBuilder();
			ref.append(XSI);
			ref.append(" ");
			ref.append(SCHEMALOCATION);
			ref.append(" ");
			ref.append(CFDI);

			while (xmlResultSet.next()) {
				wFileName = xmlResultSet.getString("file_name");
				wFileOperation = xmlResultSet.getString("num_operation");
				logger.debug("num_operation -->" + wFileOperation);
				try {
					if (wFileName != null && !"".equals(wFileName)) {
						wXmlFile = new File(filesPath + File.separator + wFileName + FILE_EXT);
						wBufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(wXmlFile), Charset.forName("UTF-8")));

						// Cambio de cfdi a cfdi:
						String xmlCfdi = xmlResultSet.getString("linea").replace("cfdi", "cfdi:");
						// Cambio de referencias
						String xmlRef = xmlCfdi.replace("Referencias=\"\"", ref.toString());

						wBufferedWriter.write(xmlRef);
						wBufferedWriter.close();
					} else {
						logger.error("ERROR createXmlFiles no se generó -->" + xmlResultSet.getString("linea"));
					}

				} catch (IOException e) {
					logger.error("ERROR createXmlFiles IOException -->", e);
				}

				getUpdateStatusXml(rConnection, wFileOperation,wFileName);
				logger.debug("actualizacion a estado y creacion del archivo de la  operacion-->" + wFileOperation);

			}
		} catch (SQLException e) {
			logger.error("ERROR createXmlFiles SQLException -->", e);
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
						logger.error("ERROR getXmlFileName: No contiene Segmento Ente/Receptor");
					}
				}
			}
		} catch (ParserConfigurationException e) {
			logger.error("ERROR getXmlFileName ParserConfigurationException -->", e);
		} catch (SAXException e) {
			logger.error("ERROR getXmlFileName SAXException -->", e);
		} catch (IOException e) {
			logger.error("ERROR getXmlFileName IOException -->", e);
		} catch (NullPointerException e) {
			logger.error("ERROR getXmlFileName NullPointerException -->", e);
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
			wPrepStat = rConnection.prepareStatement("select linea, file_name,num_operation from cob_credito..cr_resultado_xml where status=? and rx_tipo_operacion =?");
			wPrepStat.setString(1, "P");
			wPrepStat.setString(2, tipoOperacion);
			return wPrepStat.executeQuery();

		} catch (SQLException e) {
			logger.error("ERROR getCustomerXmlList -->", e);

		}

		return null;
	}

	private static int getUpdateStatusXml(Connection rConnection, String operation, String nameFile) {
		logger.debug("getUpdateStatusXml num_operation -->" + operation);
		logger.debug("getUpdateStatusXml filename -->" + nameFile);
		PreparedStatement wPrepStat = null;
		Date date = new Date();
		try {
			wPrepStat = rConnection.prepareStatement("UPDATE cob_credito..cr_resultado_xml SET status=?,processing_date=? where num_operation=? and status=? and file_name=?");
			wPrepStat.setString(1, "F");
			wPrepStat.setTimestamp(2, new java.sql.Timestamp(date.getTime()));
			wPrepStat.setString(3, operation);
			wPrepStat.setString(4, "P");
			wPrepStat.setString(5, nameFile);
			return wPrepStat.executeUpdate();

		} catch (SQLException e) {
			logger.error("ERROR getCustomerXmlList -->", e);
		}
		return 0;
	}

	private static String pathGenerateXmlSAT() {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa pathGenerateXmlSAT");
		}

		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.GXMLCI);
		String path = "";
		path = copyFileJob.getDestinationFolder();
		logger.debug(" ruta para getGenerarXmlSat()-->" + path);
		if (path == null || path.equals("") || path.equals(" ")) {
			logger.debug("No existe ruta para Depositar los archivos xml SAT");
			return null;
		}
		return path;
	}

	public static ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String toperation) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa executeNotification General XMLSAT");
		}
		String query = "{ call cob_conta_super..sp_admin_est_cta(?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, toperation);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("ERROR executeNotification General en Xml -->", ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza executeNotification General Xml");
			}
		}

	}

}
