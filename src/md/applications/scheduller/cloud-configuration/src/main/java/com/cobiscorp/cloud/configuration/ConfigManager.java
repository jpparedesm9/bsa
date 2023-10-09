package com.cobiscorp.cloud.configuration;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.cobiscorp.cobis.commons.crypt.ReadAlgn;

public class ConfigManager {

	private static final Logger logger = Logger.getLogger(ConfigManager.class);
	private static ConfigManager configManager;

	// JDBC driver name and database URL
	private String jdbDriver;
	private String url;
	// Database credentials
	private String username;
	private String passwod;

	private Integer rangeBach;
	private String xmlPath;

	private String pdfPath;
	private String jasPath;
	private String rxmlPath;
	
	//patch para carpeta de historicos
	private String xmlInFacFeliPath;
	private String xmlInFacFeliHisPath;
	private String xmlInFacGlobalFeliPath;
	private InputStream inputStream;

	private ConfigManager() {
		try {
			initProperties();
		} catch (IOException e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error al obtner configuracion: " + e);
			}
		}
	}

	public static ConfigManager getInstance() {
		if (configManager == null) {
			configManager = new ConfigManager();
		}
		return configManager;
	}

	public void initProperties() throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia initProperties ConfigManager VS0");
		}
		try {
			Properties prop = new Properties();
			String propFileName = "notification/configuration.properties";

			inputStream = new FileInputStream("notification/configuration.properties");
			// inputStream = getClass().getClassLoader().getResourceAsStream(
			// propFileName);

			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("property file '"
						+ propFileName + "' not found in the classpath");
			}

			// get the property value and print it out
			jdbDriver = prop.getProperty("datasource.driver");
			url = prop.getProperty("datasource.url");
			username = prop.getProperty("datasource.username");
			// passwod = prop.getProperty("datasource.password");
			passwod = getPwdCredentials();
			String rangeBachString = prop.getProperty("query.range.bach");

			if (logger.isDebugEnabled()) {
				logger.debug("prop->" + prop);
				logger.debug("pdfPath->" + prop.getProperty("PDF.path"));
			}

			pdfPath = prop.getProperty("PDF.path");
			jasPath = prop.getProperty("JAS.path");
			rxmlPath = prop.getProperty("RXML.path");
			xmlInFacFeliPath=prop.getProperty("INFACXML.path");
			logger.debug("xmlInFacFeliPath->" + xmlInFacFeliPath);
			xmlInFacFeliHisPath=prop.getProperty("INFACXMLHist.path");
			logger.debug("xmlInFacFeliHisPath->" + xmlInFacFeliHisPath);
			xmlInFacGlobalFeliPath=prop.getProperty("INFACXMLGLB.path");
			logger.debug("xmlInFacGlobalFeliPath->" + xmlInFacGlobalFeliPath);
			
			if (rangeBachString != null) {
				rangeBach = Integer.parseInt(rangeBachString);
			}
			xmlPath = prop.getProperty("xml.path");

			if (logger.isDebugEnabled()) {
				// logger.debug("Resultado de archivo properties: " + jdbDriver
				// + " " + url + " " + username + " " + passwod + " "
				// + rangeBach + " " + xmlPath + pdfPath + " " + jasPath
				// + " " + rxmlPath);

				logger.debug("Finaliza initProperties ConfigManager ");
			}

		} catch (IOException e) {
			throw new IOException(e);
		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
		}
	}

	public String getPwdCredentials() {
		if (logger.isDebugEnabled()) {
			logger.debug("---> getPwdCredentials ");
		}

		String returnValue = null;
		String algnFile = "notification/configuracion.algncon";

		try {
			File file = new File(algnFile);
			if (!file.exists()) {
				logger.error("No existe archivo de configuracion " + algnFile);
			} else {
				ReadAlgn wAlgReader = new ReadAlgn(algnFile);
				Properties wProperties = wAlgReader.leerParametros();

				returnValue = wProperties.getProperty("p");
			}
		} catch (Exception ex) {
			logger.error("ERROR EN getPwdCredentials ", ex);
		}

		return returnValue;
	}

	public String getJdbDriver() {
		return jdbDriver;
	}

	public void setJdbDriver(String jdbDriver) {
		this.jdbDriver = jdbDriver;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPasswod() {
		return passwod;
	}

	public void setPasswod(String passwod) {
		this.passwod = passwod;
	}

	public Integer getRangeBach() {
		return rangeBach;
	}

	public void setRangeBach(Integer rangeBach) {
		this.rangeBach = rangeBach;
	}

	public String getXmlPath() {
		return xmlPath;
	}

	public void setXmlPath(String xmlPath) {
		this.xmlPath = xmlPath;
	}

	public String getPDFPath() {
		return pdfPath;
	}

	public String getJasPath() {
		return jasPath;
	}

	public String getRXmlPath() {
		return rxmlPath;
	}
	public String getXmlInFacFeliPath() {
		return xmlInFacFeliPath;
	}

	public String getXmlInFacFeliHisPath() {
		return xmlInFacFeliHisPath;
	}
	
	public String getXmlInFacGlobalFeliPath() {
		return xmlInFacGlobalFeliPath;
	}
	
	
}
