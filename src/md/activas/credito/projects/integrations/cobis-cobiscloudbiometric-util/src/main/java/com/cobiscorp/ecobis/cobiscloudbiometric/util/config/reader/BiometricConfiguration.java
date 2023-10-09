package com.cobiscorp.ecobis.cobiscloudbiometric.util.config.reader;

import java.util.HashMap;
import java.util.Map;

import org.dom4j.Node;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.config.IBiometricConfiguration;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.constants.Parameter;

@Component
@Service({ IBiometricConfiguration.class })
public class BiometricConfiguration implements IBiometricConfiguration {
	private static ILogger LOGGER = LogFactory.getLogger(BiometricConfiguration.class);
	protected static Map<String, String> urlFromXML = new HashMap<String, String>();
	
	private static String RENAPO_CONFIG = "//configs/config[@name='renapoST']";
	private static String BIOMETRIC_CONFIG = "//configs/config[@name='biometricsST']";

	@Override
	public void loadConfiguration(IConfigurationReader reader) {
		LOGGER.logDebug(">>> Start loadConfiguration");
		
		//obtencion urls
		Node nodeAccessTokenTOpaco = reader.getNode(BIOMETRIC_CONFIG + "/property[@name='urlAccessTokenAccesoTOpaco']");
		Node nodeOpaqueToken = reader.getNode(BIOMETRIC_CONFIG + "/property[@name='urlOpaqueToken']");
		Node nodeAccessTokenRenapo = reader.getNode(RENAPO_CONFIG + "/property[@name='urlAccessTokenAccesoRenapo']");
		Node nodeRenapoToken = reader.getNode(RENAPO_CONFIG + "/property[@name='urlRenapo']");
		
		urlFromXML.put("urlAccessTokenAccesoTOpaco", reader.getProperty(nodeAccessTokenTOpaco, Parameter.VALUE));
		urlFromXML.put("urlOpaqueToken", reader.getProperty(nodeOpaqueToken, Parameter.VALUE));
		urlFromXML.put("urlAccessTokenAccesoRenapo", reader.getProperty(nodeAccessTokenRenapo, Parameter.VALUE));
		urlFromXML.put("urlRenapo", reader.getProperty(nodeRenapoToken, Parameter.VALUE));
		
		
		//obtencion claves usadas en headers servicios rest
		Node nodeClientIdBIO = reader.getNode(BIOMETRIC_CONFIG + "/headers/header[@name='client_id']");
		//Node nodeClientSecretBIO = reader.getNode(BIOMETRIC_CONFIG + "/headers/header[@name='client_secret']");
		urlFromXML.put("clientIdBIO", reader.getProperty(nodeClientIdBIO, Parameter.VALUE));
		//urlFromXML.put("clientSecretBIO", reader.getProperty(nodeClientSecretBIO, Parameter.VALUE));
		
		Node nodeClientIdREN = reader.getNode(RENAPO_CONFIG + "/headers/header[@name='client_id']");
		Node nodeClientSecretREN = reader.getNode(RENAPO_CONFIG + "/headers/header[@name='client_secret']");
		urlFromXML.put("clientIdREN", reader.getProperty(nodeClientIdREN, Parameter.VALUE));
		urlFromXML.put("clientSecretREN", reader.getProperty(nodeClientSecretREN, Parameter.VALUE));

		LOGGER.logDebug("urlFromXML>>" + urlFromXML);
		LOGGER.logDebug(">>> Finish loadConfiguration");

	}

	public static String getUrlFromXML(String node) {
		return urlFromXML == null ? null : urlFromXML.get(node);

	}

}
