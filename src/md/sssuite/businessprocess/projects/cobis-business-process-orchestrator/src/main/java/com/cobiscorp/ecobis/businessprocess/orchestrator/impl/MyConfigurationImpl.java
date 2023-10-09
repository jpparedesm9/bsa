package com.cobiscorp.ecobis.businessprocess.orchestrator.impl;

import java.util.Properties;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.businessprocess.orchestrator.Constants;
import com.cobiscorp.ecobis.businessprocess.orchestrator.MyConfiguration;

public class MyConfigurationImpl implements MyConfiguration {

	private static final ILogger logger = LogFactory.getLogger(MyConfigurationImpl.class);
	private static Properties properties;

	
	@Override
	public void loadConfiguration(IConfigurationReader configurationReader) {
		// Obtener las propiedades
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso a loadConfiguration - Orchestrator.MyConfigurationImpl");
		}
		properties = configurationReader.getProperties(Constants.CONFIG_PROPERTIES_PATH);
	}

	public static Properties getProperties() {
		return properties;
	}

}
