package com.cobiscorp.cobis.notifier.dispatcher.sms;

import java.util.Date;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.core.dto.COBISNotification;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.DataSms;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.SmsResponse;
import com.cobiscorp.cobis.notifier.dispatcher.sms.impl.SmsSendImpl;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.MobileGatewaySettings;
import com.cobiscorp.notification.client.NotificationRestClient;
import com.cobiscorp.notification.client.TokenRestClient;
import com.cobiscorp.notification.client.dtos.NotificationHeader;
import com.cobiscorp.notification.client.dtos.NotificationRequest;
import com.cobiscorp.notification.client.dtos.NotificationResponse;
import com.cobiscorp.notification.client.dtos.TokenRequest;
import com.cobiscorp.notification.client.dtos.TokenResponse;

public class SmsSend {

	private static final ILogger logger = LogFactory.getLogger(SmsSend.class);

	public String smsTokenGenerate(MobileGatewaySettings mgSettings) {

		logger.logDebug("Start generate token");
		String token = null;
		try {
			TokenRestClient trc = new TokenRestClient(mgSettings.getServiceUrl());
			TokenRequest tokenRequest = new TokenRequest();
			tokenRequest.setScope(mgSettings.getScope());
			tokenRequest.setGrantType(mgSettings.getGrantType());
			tokenRequest.setClientId(mgSettings.getClientId());
			tokenRequest.setClientSecret(mgSettings.getClientSecret());
			tokenRequest.setToken(mgSettings.getToken());
			TokenResponse tokenResponse = trc.getToken(tokenRequest);
			token = tokenResponse.getAccess_token();
		} catch (Exception e) {
			logger.logError("The token cannot be obtained", e);
		}

		return token;

	}

	public NotificationResponse smsSendMessage(MobileGatewaySettings mgSettings, String token, COBISNotification notification) {

		logger.logInfo("Start method smsSendMessage");

		// Variable
		NotificationResponse notificationResponse = null;

		// Header
		NotificationHeader header = new NotificationHeader();
		header.setAccesToken(token);
		header.setXIbmClientId(mgSettings.getXibmClientId());
		header.setChannelId(mgSettings.getChannel());
		header.setClientIPAdress(mgSettings.getClientIp());

		// Body
		try {
			NotificationRestClient notifRest = new NotificationRestClient(mgSettings.getUrlNotification());

			// The variable for the id template is nd_var2
			// The variable of the block is nd_var1
			// The variable of the client is nd_var3

			SmsSendImpl impl = new SmsSendImpl();
			SmsResponse smsResponse = impl.getDataSmsResponse(Integer.parseInt(notification.getVars()[0]), notification.getVars()[1], notification.getVars()[2], notification.getVars()[3]);

			// Constructor NotificationRequest(partyIdMask, partyId, cardNum, acctId) partId = Buc
			NotificationRequest request = new NotificationRequest(null, smsResponse.getTemplateSms().getBuc(), null, null);

			request.setAlertScheduleDt(new Date());

			request.setAlertIdTemplate(smsResponse.getTemplateSms().getPlantilla());
			request.setIdEvent(smsResponse.getTemplateSms().getEvento());

			// The variable for the phone number is nd_from
			request.sePhoneNum(notification.getFrom());

			for (DataSms dataSms2 : smsResponse.getDataSms()) {
				request.addAlertData(dataSms2.getKey(), dataSms2.getValue(), dataSms2.getType());
			}

			notificationResponse = notifRest.sendNotification(header, request);

		} catch (Exception e) {
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