package com.cobiscorp.cloud.configuration;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

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

	private InputStream inputStream;

	private ConfigManager() {
		try {
			initProperties();
		} catch (IOException e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error al obtner configuracion: " +e);
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
			logger.debug("Inicia initProperties ConfigManager");
		}
		try {
			Properties prop = new Properties();
			String propFileName = "configuration.properties";

			inputStream = getClass().getClassLoader().getResourceAsStream(
					propFileName);

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
			passwod = prop.getProperty("datasource.password");
			String rangeBachString = prop.getProperty("query.range.bach");
			if (rangeBachString != null) {
				rangeBach = Integer.parseInt(rangeBachString);
			}
			xmlPath = prop.getProperty("xml.path");

			if (logger.isDebugEnabled()) {
				logger.debug("Resultado de archivo properties: " + jdbDriver
						+ " " + url + " " + username + " " + passwod + " "
						+ rangeBach + " " + xmlPath);

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

}
