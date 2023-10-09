package com.cobiscorp.cobis.notifier.dispatcher.sms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.airmovil.client.NotificationRestClientAirmovil;
import com.cobiscorp.airmovil.client.TokenRestClientAirmovil;
import com.cobiscorp.airmovil.client.dtos.Contact;
import com.cobiscorp.airmovil.client.dtos.NotificationAirmovilResponse;
import com.cobiscorp.airmovil.client.dtos.NotificationHeaderAirmovil;
import com.cobiscorp.airmovil.client.dtos.NotificationRequestAirmovil;
import com.cobiscorp.airmovil.client.dtos.TokenRequestAirmovil;
import com.cobiscorp.airmovil.client.dtos.TokenResponseAirmovil;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.core.dto.COBISNotification;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.DataSms;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.SmsResponse;
import com.cobiscorp.cobis.notifier.dispatcher.sms.impl.SmsSendImpl;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.MobileGatewaySettings;

public class SmsSendAirmovil {

	private static final ILogger logger = LogFactory.getLogger(SmsSendAirmovil.class);

	public String smsTokenGenerate(MobileGatewaySettings mgSettings) {

		logger.logDebug("Start generate token");
		String token = null;
		try {
			TokenRestClientAirmovil trc = new TokenRestClientAirmovil(mgSettings.getServiceUrl());
			TokenRequestAirmovil tokenRequest = new TokenRequestAirmovil();

			tokenRequest.setGrantType(mgSettings.getGrantType());
			tokenRequest.setUsername(mgSettings.getClientId());
			tokenRequest.setPassword(mgSettings.getClientSecret());
			tokenRequest.setUsernameAi(mgSettings.getUserName());
			tokenRequest.setPasswordAi(mgSettings.getPassword());
			
			TokenResponseAirmovil tokenResponse = trc.getToken(tokenRequest);
			token = tokenResponse.getAccessToken();
		} catch (Exception e) {
			logger.logError("The token cannot be obtained", e);
		}

		return token;

	}

	public NotificationAirmovilResponse smsSendMessage(MobileGatewaySettings mgSettings, String token, COBISNotification notification) {

		logger.logInfo("Start method smsSendMessage");

		// Variable
		NotificationAirmovilResponse notificationResponse = null;
		Map<String, Object> map = new HashMap<>();

		// Header
		NotificationHeaderAirmovil header = new NotificationHeaderAirmovil();
		header.setAccesToken(token);
		header.setClientIPAdress(mgSettings.getClientIp());

		// Body
		try {

			String urlSms = mgSettings.getUrlNotification().replace("XXXX", notification.getVars()[1]);
			NotificationRestClientAirmovil notifRest = new NotificationRestClientAirmovil(urlSms);
			// The variable for the id template is nd_var2
			// The variable of the block is nd_var1
			// The variable of the client is nd_var3

			logger.logInfo("Block - nd_var1: " + notification.getVars()[0]);
			logger.logInfo("Template - nd_var2: " + notification.getVars()[1]);
			logger.logInfo("Client - nd_var3: " + notification.getVars()[2]);
			logger.logInfo("Validate BUC - nd_var4: " + notification.getVars()[3]);

			SmsSendImpl impl = new SmsSendImpl();
			SmsResponse smsResponse = impl.getDataSmsResponse(Integer.parseInt(notification.getVars()[0]), notification.getVars()[1], notification.getVars()[2], notification.getVars()[3]);

			// Constructor NotificationRequest(partyIdMask, partyId, cardNum, acctId) partId = Buc
			NotificationRequestAirmovil request = new NotificationRequestAirmovil();

			// Telephone number
			request.setContact(new Contact(notification.getFrom()));
			map.put("aux", smsResponse.getTemplateSms().getBuc());

			if (smsResponse.getDataSms() != null) {

				for (DataSms dataSms2 : smsResponse.getDataSms()) {
					map.put(dataSms2.getKey(), dataSms2.getValue());

				}
			}

			request.setCustomAttributes(map);
			request.setCountry("MEX");

			notificationResponse = notifRest.sendNotification(header, request);

		} catch (Exception e) {
			notification.setStatus("C");
			notification.setErrorInformation("Failure to send sms due to internal server error");
			logger.logError("Fail send sms", e);
		}

		logger.logInfo("End method smsSendMessage");

		return notificationResponse;
	}

	public String getBucFromList(List<DataSms> dataSms) {
		String response = null;

		for (DataSms dataSms2 : dataSms) {
			if (dataSms2.getKey().equalsIgnoreCase("Buc")) {
				response = dataSms2.getValue();
			}
		}

		return response;

	}

}