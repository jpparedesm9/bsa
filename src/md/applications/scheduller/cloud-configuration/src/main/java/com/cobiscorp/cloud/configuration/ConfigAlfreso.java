package com.cobiscorp.cloud.configuration;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.cobiscorp.cobis.commons.crypt.ReadAlgn;

public class ConfigAlfreso {

	private static final Logger logger = Logger.getLogger(ConfigAlfreso.class);
	private static ConfigAlfreso configAlfreso;

	// Communication variables

	private String idEntity;
	private String filter;
	private String library;
	private String endpointDomain;
	private String endpointToken;
	private String password;
	private String user;

	private InputStream inputStream;

	// Private constructor to maintain a single instance
	private ConfigAlfreso() {
		try {
			initProperties();
		} catch (IOException e) {
			if (logger.isDebugEnabled()) {
				logger.debug("Error obtaining the configuration: " + e);
			}
		}
	}

	public static ConfigAlfreso getInstance() {
		if (configAlfreso == null) {
			configAlfreso = new ConfigAlfreso();
		}
		return configAlfreso;
	}

	public void initProperties() throws IOException {
		if (logger.isDebugEnabled()) {
			logger.debug("Start initProperties ConfigManager Alfresco");
		}

		try {
			Properties properties = new Properties();
			String pathPropertiesFileName = "notification" + File.separator + "alfresco.properties";

			inputStream = new FileInputStream(pathPropertiesFileName);

			if (inputStream != null) {
				properties.load(inputStream);
			} else {
				throw new FileNotFoundException("property file '" + pathPropertiesFileName + "' not found in the classpath");
			}

			// get the property value and print it out
			idEntity = properties.getProperty("entity.idEntity");
			filter = properties.getProperty("entity.filter");
			library = properties.getProperty("entity.library");
			endpointDomain = properties.getProperty("entity.endpointDomain");
			endpointToken = properties.getProperty("entity.endpointToken");
			password = getPwdCredentials();
			user = properties.getProperty("entity.user");

			if (logger.isDebugEnabled()) {
				logger.debug("idEntity:" + idEntity);
				logger.debug("filter:" + filter);
				logger.debug("library:" + library);
				logger.debug("endpointDomain:" + endpointDomain);
				logger.debug("endpointToken:" + endpointToken);
				logger.debug("user:" + user);

				if (password != null && !password.equals("")) {
					logger.debug("Password found");
				} else {
					logger.debug("Password not found");
				}
			}

			if (logger.isDebugEnabled()) {
				logger.debug("Finished initProperties ConfigManager Alfresco");
			}

		} catch (IOException e) {
			throw new IOException(e);
		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
		}

	}

	private String getPwdCredentials() {
		if (logger.isDebugEnabled()) {
			logger.debug("Start password retrieval");
		}

		String returnValue = null;
		String algnFile = "notification/InboxSharePoint.algncon";

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

	public static ConfigAlfreso getConfigAlfreso() {
		return configAlfreso;
	}

	public static void setConfigAlfreso(ConfigAlfreso configAlfreso) {
		ConfigAlfreso.configAlfreso = configAlfreso;
	}

	public String getIdEntity() {
		return idEntity;
	}

	public void setIdEntity(String idEntity) {
		this.idEntity = idEntity;
	}

	public String getFilter() {
		return filter;
	}

	public void setFilter(String filter) {
		this.filter = filter;
	}

	public String getLibrary() {
		return library;
	}

	public void setLibrary(String library) {
		this.library = library;
	}

	public String getEndpointDomain() {
		return endpointDomain;
	}

	public void setEndpointDomain(String endpointDomain) {
		this.endpointDomain = endpointDomain;
	}

	public String getEndpointToken() {
		return endpointToken;
	}

	public void setEndpointToken(String endpointToken) {
		this.endpointToken = endpointToken;
	}

	public static Logger getLogger() {
		return logger;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

}
