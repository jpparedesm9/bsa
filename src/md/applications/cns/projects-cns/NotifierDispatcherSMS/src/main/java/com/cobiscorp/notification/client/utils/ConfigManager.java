package com.cobiscorp.notification.client.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.cobiscorp.cobis.commons.crypt.ReadAlgn;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class ConfigManager {

	private static final ILogger logger = LogFactory.getLogger(ConfigManager.class);
	private static ConfigManager configManager;

	// JDBC driver name and database URL
	private String jdbDriver;
	private String url;
	// Database credentials
	private String username;
	private String passwod;

	private InputStream inputStream;

	private ConfigManager() {
		try {
			initProperties();
		} catch (IOException e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Error al obtner configuracion: " + e);
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
			logger.logDebug("Inicia initProperties ConfigManager VS0");
		}

		try {
			Properties prop = new Properties();
			String propFileName = "./infrastructure/configurationSms.properties";

			inputStream = new FileInputStream(propFileName);

			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
			}

			// get the property value and print it out
			jdbDriver = prop.getProperty("datasource.driver");
			url = prop.getProperty("datasource.url");
			username = prop.getProperty("datasource.username");
			passwod = getPwdCredentials(prop.getProperty("datasource.password"));
			
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza initProperties ConfigManager ");
			}

		} catch (IOException e) {
			throw new IOException(e);
		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
		}
	}

	public String getPwdCredentials(String nameFileAlgncon) {
		logger.logDebug("nameFileAlgncon-> " + nameFileAlgncon);

		String returnValue = null;
		String algnFile = "./infrastructure/" + nameFileAlgncon;

		try {
			File file = new File(algnFile);
			if (!file.exists()) {

			} else {
				ReadAlgn wAlgReader = new ReadAlgn(algnFile);
				Properties wProperties = wAlgReader.leerParametros();

				returnValue = wProperties.getProperty("p");
			}
		} catch (Exception ex) {
			logger.logDebug("Error al obtener el password sql",ex);

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

	@Override
	public String toString() {
		return "ConfigManager [jdbDriver=" + jdbDriver + ", url=" + url + ", username=" + username + ", passwod=" + passwod + ", inputStream=" + inputStream + "]";
	}

}
