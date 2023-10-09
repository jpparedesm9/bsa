package com.cobiscorp.cobis.notifier.dispatcher.sms.settings;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class SettingsManager {

	private static ILogger logger = LogFactory.getLogger(SettingsManager.class);

	private SettingsManager() {
		throw new IllegalStateException("Utility class");
	}

	public static String loadLogLevel(IConfigurationReader reader) {
		String logLevel = reader.getNode("//sms-dispatcher/log-level").getStringValue();
		logger.setLevel(logLevel);
		return logLevel;
	}

	public static MobileGatewaySettings loadMobileGatewaySettings(IConfigurationReader reader) {
		MobileGatewaySettings mgServer = new MobileGatewaySettings();

		// Server Information
		mgServer.setServiceUrl(reader.getNode("//sms-dispatcher/mobile-gateway/@service-url").getStringValue());
		mgServer.setScope(reader.getNode("//sms-dispatcher/mobile-gateway/@scope").getStringValue());
		mgServer.setGrantType(reader.getNode("//sms-dispatcher/mobile-gateway/@grand-type").getStringValue());
		mgServer.setClientId(reader.getNode("//sms-dispatcher/mobile-gateway/@client-id").getStringValue());
		mgServer.setClientSecret(reader.getNode("//sms-dispatcher/mobile-gateway/@client-secret").getStringValue());
		mgServer.setUserName(reader.getNode("//sms-dispatcher/mobile-gateway/@user-name").getStringValue());
		mgServer.setPassword(reader.getNode("//sms-dispatcher/mobile-gateway/@password").getStringValue());
		mgServer.setToken(reader.getNode("//sms-dispatcher/mobile-gateway/@token").getStringValue());
		mgServer.setUrlNotification(reader.getNode("//sms-dispatcher/mobile-gateway/@url-notification").getStringValue());

		mgServer.setXibmClientId(reader.getNode("//sms-dispatcher/mobile-gateway/@xibm-client").getStringValue());
		mgServer.setChannel(reader.getNode("//sms-dispatcher/mobile-gateway/@channel").getStringValue());
		mgServer.setClientIp(reader.getNode("//sms-dispatcher/mobile-gateway/@client-ip").getStringValue());
		mgServer.setProvider(reader.getNode("//sms-dispatcher/mobile-gateway/@provider").getStringValue());

		return mgServer;
	}

	public static DefaultSenderSettings loadDefaultSenderSettings(IConfigurationReader reader) {
		DefaultSenderSettings senderSettings = new DefaultSenderSettings();

		// Default Sender
		senderSettings.setOriginatingMsisdn(reader.getNode("//sms-dispatcher/default-sender/@originating-msisdn").getStringValue());
		senderSettings.setAlwaysOverrideEnabled(Boolean.parseBoolean(reader.getNode("//sms-dispatcher/default-sender/@always-override").getStringValue()));

		return senderSettings;
	}

	public static ServiceSettings loadServiceSettings(IConfigurationReader reader) {
		ServiceSettings serviceConf = new ServiceSettings();

		serviceConf.setWorkerThreadsNumber(Integer.parseInt(reader.getNode("//sms-dispatcher/service/@worker-threads").getStringValue()));

		return serviceConf;
	}

	public static void updateLogLevel(IConfigurationReader reader, String logLevel) {
		logger.setLevel(logLevel);

		reader.setPropertyNode(reader.getNode("//sms-dispatcher/log-level"), logLevel);
		reader.writeXML();
	}
}
