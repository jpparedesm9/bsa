package com.cobiscorp.ecobis.assets.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;

import com.cobiscorp.cobis.commons.configuration.COBISGeneralConfiguration;
import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.commons.utils.ConfigurationReader;
import com.cobiscorp.ecobis.assets.dto.StructureDTO;

public class ReadConfigurationFile {
	private static final ILogger logger = LogFactory.getLogger(ReadConfigurationFile.class);

	public List<Map<String, StructureDTO>> readConfigFile(String configFile, String operator) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start readConfigFile in ReadConfigurationFile class");
		}

		String serviceConfigFile = getServiceConfigFile(configFile);
		IConfigurationReader configurationReader = new ConfigurationReader(serviceConfigFile);

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finish readConfigFile in ReadConfigurationFile class");
		}

		if (configurationReader.getDocument() != null) {

			return readNodesFromFile(configurationReader.getDocument().getRootElement(), new ArrayList<Map<String, StructureDTO>>(), operator);
		}

		return new ArrayList<Map<String, StructureDTO>>();
	}

	private String getServiceConfigFile(String configFile) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start getServiceConfigFile in ReadConfigurationFile class");
		}

		String cobisHome = COBISGeneralConfiguration.getEnvironmentVariable("COBIS_HOME", 0);
		StringBuilder url = new StringBuilder(cobisHome);
		url.append("/CTS_MF");
		url.append(configFile);

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finish getServiceConfigFile in ReadConfigurationFile class");
		}

		return url.toString();
	}

	public List<Map<String, StructureDTO>> readNodesFromFile(Element root, List<Map<String, StructureDTO>> valuesList, String operator) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start readNodesFromFile  in ReadConfigurationFile class");
		}

		logger.logDebug("root:" + root);
		logger.logDebug("operator:" + operator);
		// iterate through child elements of root
		if (root.elementIterator() != null) {
			for (Iterator i = root.elementIterator(); i.hasNext();) {
				Map<String, StructureDTO> values = new HashMap<String, StructureDTO>();
				Element element = (Element) i.next();

				if (operator == null) {
					if (element.attributeValue("default") != null && "true".equals(element.attributeValue("default"))) {
						operator = element.attributeValue("name");
					}
				}

				if (element.attributes() != null && element.attributes().size() > 0 && element.getParent() != null && operator.equals(element.getParent().attributeValue("name"))) {
					if (element.attributeValue("name") != null && element.attributeValue("value") != null && element.attributeValue("type") != null
							&& element.attributeValue("format") != null && element.attributeValue("regularExp") != null) {
						if (logger.isDebugEnabled()) {
							logger.logDebug("Node name:" + element.attributeValue("name"));
							logger.logDebug("Node value:" + element.attributeValue("value"));
							logger.logDebug("Node type:" + element.attributeValue("type"));
						}
						StructureDTO structure = new StructureDTO();
						structure.setValue(element.attributeValue("value"));
						structure.setType(element.attributeValue("type"));

						if (element.attributeValue("type").equals("F")) {

							if (element.attributeValue("groupSeparator") == null || "".equals(element.attributeValue("groupSeparator"))) {
								throw new Exception("El campo " + element.attributeValue("name")
										+ " en el archivo de configuración no tiene definido caracter para separador de grupo.");
							} else {
								structure.setGroupSeparator(element.attributeValue("groupSeparator").charAt(0));
								
							}
							if (element.attributeValue("decimalSeparator") == null || "".equals(element.attributeValue("groupSeparator").trim())) {
								throw new Exception("El campo " + element.attributeValue("name")
										+ " en el archivo de configuración no tiene definido caracter para separador de decimales");
							} else {
								structure.setDecimalSeparator(element.attributeValue("decimalSeparator").charAt(0));
				
							}
						}
						structure.setFormat(element.attributeValue("format"));
						structure.setRegularExp(element.attributeValue("regularExp"));
						values.put(element.attributeValue("name"), structure);
						valuesList.add(values);

					} else {
						throw new Exception("El archivo de configuración no tiene definido todos atributos de parametrización.");
					}
				}

				readNodesFromFile(element, valuesList, operator);

			}
		}

		// logger.logDebug("values" + valuesList);

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finish readNodesFromFile in ReadConfigurationFile class");
		}
		return valuesList;
	}

}
