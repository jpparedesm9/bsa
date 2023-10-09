package com.cobiscorp.ecobis.fpm.interceptors.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.dom4j.Node;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class DefaultValuesManager implements IDefaultValuesManager {

	// region fields
	private static final ILogger logger = LogFactory
			.getLogger(DefaultValuesManager.class);

	/** Mapa para la configuracion de extractores */
	private static Map<String, String> defaultValuesList;

	
	public void loadConfiguration(IConfigurationReader reader) {
		try {

			logger.logDebug(MessageManager.getString(
					"DEFAULTVALUESMANAGER.001", "loadConfiguration"));

			defaultValuesList = new HashMap<String, String>();
			List<Node> defaultValues = reader
					.getNodeList(PATH_DEFAULT_VALUES);
			String defaultVName = null;
			String defaultVValue = null;
			for (Node dValue : defaultValues) {
				defaultVName = reader.getProperty(dValue, "name");
				defaultVValue = reader.getProperty(dValue, "value");
				defaultValuesList.put(defaultVName, defaultVValue);
				logger.logInfo("[defaultValue] name:" + defaultVName
						+ ", value:" + defaultVValue);

			}
		}

		catch (Exception e) {
			logger.logError(
					MessageManager.getString("DEFAULTVALUESMANAGER.003"), e);

			throw new BusinessException(6900001,
					"'Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {

			logger.logDebug(MessageManager.getString(
					"DEFAULTVALUESMANAGER.002", "loadConfiguration"));
		}
	}
	
	public Map<String, String> getDefaultValues() {
		try {

			logger.logDebug(MessageManager.getString(
					"DEFAULTVALUESMANAGER.001", "getDefaultValues"));
			return defaultValuesList;
		}

		catch (Exception e) {
			logger.logError(
					MessageManager.getString("DEFAULTVALUESMANAGER.003"), e);

			throw new BusinessException(6900001,
					"'Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {

			logger.logDebug(MessageManager.getString(
					"DEFAULTVALUESMANAGER.002", "getDefaultValues"));
		}
	}

	public String getDefaultValue(String nameParameter) {
		try {

			logger.logDebug(MessageManager.getString(
					"DEFAULTVALUESMANAGER.001", "getDefaultValue"));
			String value = null;
			Iterator<Entry<String, String>> itr = defaultValuesList.entrySet()
					.iterator();

			while (itr.hasNext()) {
				Map.Entry<String, String> ent = (Map.Entry<String, String>) itr
						.next();
				if (ent.getKey().toString().trim().equals(nameParameter)) {
					value = ent.getValue();

				}
			}

			return value;
		}

		catch (Exception e) {
			logger.logError(
					MessageManager.getString("DEFAULTVALUESMANAGER.003"), e);

			throw new BusinessException(6900001,
					"'Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {

			logger.logDebug(MessageManager.getString(
					"DEFAULTVALUESMANAGER.002", "getDefaultValue"));
		}
	}

}
