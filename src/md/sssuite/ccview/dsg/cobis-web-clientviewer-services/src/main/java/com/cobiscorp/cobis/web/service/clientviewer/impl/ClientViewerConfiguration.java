package com.cobiscorp.cobis.web.service.clientviewer.impl;

import java.util.Properties;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.service.clientviewer.IClientViewerConfiguration;

public class ClientViewerConfiguration implements IClientViewerConfiguration {

	private static final ILogger logger = LogFactory
			.getLogger(ClientViewerConfiguration.class);
	private static boolean useLocalResources = false;
	private static String localResourcesBaseDirectory = null;
	private static String ctsServerName = null;

	@Override
	public void loadConfiguration(IConfigurationReader reader) {
		String value;
		Properties properties = reader.getProperties("//property");
		if (logger.isDebugEnabled())
			logger.logDebug("Inicia loadConfiguration con propiedades: "
					+ properties);
		value = (String) properties.get("useLocalResources");
		if ((value != null) && (value.equalsIgnoreCase("true")))
			useLocalResources = true;
		localResourcesBaseDirectory = (String) properties
				.get("localResourcesBaseDirectory");
		ctsServerName = (String) properties.get("ctsServerName");
	}

	public static boolean getUseLocalResources() {
		return useLocalResources;
	}

	public static String getLocalResourcesBaseDirectory() {
		return localResourcesBaseDirectory;
	}

	public static String getCtsServerName() {
		return ctsServerName;
	}

}
