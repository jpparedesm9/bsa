package com.cobiscorp.ecobis.cobiscloudonboard.util.config.reader;

import java.util.HashMap;
import java.util.Map;

import org.dom4j.Node;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudonboard.util.config.IBioOnboardingConfiguration;
import com.cobiscorp.ecobis.cobiscloudonboard.util.constants.Parameter;

@Component
@Service({ IBioOnboardingConfiguration.class })
public class BioOnboardingConfiguration implements IBioOnboardingConfiguration {
	private static ILogger LOGGER = LogFactory.getLogger(BioOnboardingConfiguration.class);
	protected static Map<String, String> urlFromXML = new HashMap<String, String>();
	private static String BIOONBOARD_CONFIG = "//configs/config[@name='bioonboarding']";
	private static String BIOMETRIC_RENAPO = "//configs/config[@name='renapo']";
	private static String FINGERID_CONFIG = "//configs/config[@name='fingerid']";

	@Override
	public void loadConfiguration(IConfigurationReader reader) {
		LOGGER.logDebug(">>> Start loadConfiguration BioOnboarding");

		// Sección para obtener las URl del archivo de configuración
		Node nodeAccessOauthToken = reader.getNode(BIOONBOARD_CONFIG + "/property[@name='urlAccessOauthToken']");
		Node nodeGenerateOpaqueToken = reader.getNode(BIOONBOARD_CONFIG + "/property[@name='urlGenerateOpaqueToken']");
		Node nodeValidateOpaqueToken = reader.getNode(BIOONBOARD_CONFIG + "/property[@name='urlValidateOpaqueToken']");
		Node nodeAccessOauthTokeRenapo = reader.getNode(BIOMETRIC_RENAPO + "/property[@name='urlAccessOauthTokenR']");
		Node nodeRenapoByCurp = reader.getNode(BIOMETRIC_RENAPO + "/property[@name='urlRenapoByCurp']");
		Node nodeAccessOauthTokenFI = reader.getNode(FINGERID_CONFIG + "/property[@name='urlAccessOauthToken']");
		Node nodeGenerateOpaqueTokenFI = reader.getNode(FINGERID_CONFIG + "/property[@name='urlGenerateOpaqueToken']");
		Node nodeValidateOpaqueTokenFI = reader.getNode(FINGERID_CONFIG + "/property[@name='urlValidateOpaqueToken']");

		// Seteo de datos al mapa
		urlFromXML.put("urlAccessOauthToken", reader.getProperty(nodeAccessOauthToken, Parameter.VALUE));
		urlFromXML.put("urlGenerateOpaqueToken", reader.getProperty(nodeGenerateOpaqueToken, Parameter.VALUE));
		urlFromXML.put("urlValidateOpaqueToken", reader.getProperty(nodeValidateOpaqueToken, Parameter.VALUE));
		urlFromXML.put("urlAccessOauthTokenR", reader.getProperty(nodeAccessOauthTokeRenapo, Parameter.VALUE));
		urlFromXML.put("urlRenapoByCurp", reader.getProperty(nodeRenapoByCurp, Parameter.VALUE));
		urlFromXML.put("urlAccessOauthTokenFI", reader.getProperty(nodeAccessOauthTokenFI, Parameter.VALUE));
		urlFromXML.put("urlGenerateOpaqueTokenFI", reader.getProperty(nodeGenerateOpaqueTokenFI, Parameter.VALUE));
		urlFromXML.put("urlValidateOpaqueTokenFI", reader.getProperty(nodeValidateOpaqueTokenFI, Parameter.VALUE));

		// Sección de datos de cabecera
		Node nodeClientId = reader.getNode(BIOONBOARD_CONFIG + "/headers/header[@name='client_id']");
		Node nodeClientSecret = reader.getNode(BIOONBOARD_CONFIG + "/headers/header[@name='client_secret']");
		Node nodeClientIdRenapo = reader.getNode(BIOMETRIC_RENAPO + "/headers/header[@name='client_id_Renapo']");
		Node nodeClientSecretRenapo = reader
				.getNode(BIOMETRIC_RENAPO + "/headers/header[@name='client_secret_Renapo']");
		Node nodeClientIdFI = reader.getNode(FINGERID_CONFIG + "/headers/header[@name='client_id']");
		Node nodeClientSecretFI = reader.getNode(FINGERID_CONFIG + "/headers/header[@name='client_secret']");

		urlFromXML.put("clientId", reader.getProperty(nodeClientId, Parameter.VALUE));
		urlFromXML.put("clientSecret", reader.getProperty(nodeClientSecret, Parameter.VALUE));
		urlFromXML.put("clientIdRenapo", reader.getProperty(nodeClientIdRenapo, Parameter.VALUE));
		urlFromXML.put("clientSecretRenapo", reader.getProperty(nodeClientSecretRenapo, Parameter.VALUE));
		urlFromXML.put("clientIdFI", reader.getProperty(nodeClientIdFI, Parameter.VALUE));
		urlFromXML.put("clientSecretFI", reader.getProperty(nodeClientSecretFI, Parameter.VALUE));
	
		LOGGER.logDebug("urlFromXML>>" + urlFromXML);
		LOGGER.logDebug(">>> Finish loadConfiguration BioOnboarding");
	}

	public static String getUrlFromXML(String node) {
		return urlFromXML == null ? null : urlFromXML.get(node);

	}

	public static String getConfigValue(String keyValue, String fingerPrefix) {
		return getUrlFromXML(keyValue + fingerPrefix) != null ? getUrlFromXML(keyValue + fingerPrefix).trim() : null;
	}

}
