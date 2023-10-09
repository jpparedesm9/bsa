package com.cobiscorp.cobis.notifier.dispatcher.sms.service;

import java.util.concurrent.Callable;

import com.cobiscorp.airmovil.client.dtos.NotificationAirmovilResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.core.datasource.INotifierDataSource;
import com.cobiscorp.cobis.notifier.core.dto.COBISNotification;
import com.cobiscorp.cobis.notifier.core.dto.Content;
import com.cobiscorp.cobis.notifier.core.dto.sms.SmsContent;
import com.cobiscorp.cobis.notifier.dispatcher.sms.SmsSendAirmovil;
import com.cobiscorp.cobis.notifier.dispatcher.sms.exceptions.InvalidContentException;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.DefaultSenderSettings;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.MobileGatewaySettings;

public class MobileGatewayClient implements Callable<Boolean>  {

	private static final ILogger logger = LogFactory.getLogger(MobileGatewayClient.class);
	private static final String ENCODING = "UTF-8";

	private MobileGatewaySettings mgSettings;
	private DefaultSenderSettings senderSettings;
	private SmsContent smsContent;
	private INotifierDataSource dataSource;

	public MobileGatewayClient(MobileGatewaySettings mgSettings, DefaultSenderSettings senderSettings, Content content, INotifierDataSource dataSource) throws InvalidContentException {
		this.mgSettings = mgSettings;
		this.senderSettings = senderSettings;
		this.dataSource = dataSource;

		try {
			logger.logDebug("mgSettings: " + mgSettings.toString());
			logger.logDebug("senderSettings: " + senderSettings.toString());
			logger.logDebug("content: " + content.toString());

			this.smsContent = (SmsContent) content;
		} catch (ClassCastException e) {
			throw new InvalidContentException("Unable to get an SmsContent object from the supplied Content object", e);
		}
	}

	@Override
	public Boolean call() throws Exception {
		Boolean stateSent = false;
		Thread.currentThread().setContextClassLoader(getClass().getClassLoader());

		COBISNotification notification = (COBISNotification) smsContent.getNotification();
		String token = null;
		NotificationAirmovilResponse notificationResponse = new NotificationAirmovilResponse();

		try {

			logger.logDebug("Start sending sms");
			notification.setStatus("C");
			SmsSendAirmovil smsSend = new SmsSendAirmovil();
			token = smsSend.smsTokenGenerate(mgSettings);
			if (token != null) {
				logger.logDebug("notification: " + notification.toString());
				
				notificationResponse = smsSend.smsSendMessage(mgSettings, token, notification);
				if (notificationResponse != null) {

					if (notificationResponse.getStatus() == 3) {
						notification.setStatus("F");
						stateSent = true;
						notification.setErrorInformation("SMS ENVIADO CORRECTAMENTE");
					} else {
						StringBuilder errInformation = new StringBuilder();
						errInformation.append("Code Error: ");
						errInformation.append(notificationResponse.getStatus());
						errInformation.append(" Message:");
						String message = errorMessage(notificationResponse.getStatus());
						errInformation.append(message);

						
						notification.setErrorInformation(errInformation.toString());
					}
				}

			} else {
				notification.setErrorInformation("The token cannot be obtained.");
			}

			logger.logDebug("Sending of sms ends");

		} catch (Exception e) {
			logger.logError("Error exception not send sms", e);
			notification.setStatus("C");
			notification.setErrorInformation("The token cannot be obtained.");			
		} finally {
			dataSource.updateNotificationStatus(notification);
			smsContent = null;
			notification = null;
		}
		
		return stateSent;
	}

	public void setLogLevel(String logLevel) {
		logger.setLevel(logLevel);
	}

	public String errorMessage(int codError) {
		String messageError = null;

		if (codError == 10)
			messageError = "Número invalido";
		else if (codError == 500)
			messageError = "Ip no permitida";
		else if (codError == 501)
			messageError = "Plantilla inactiva";
		else if (codError == 502)
			messageError = "La plantilla no existe";
		else if (codError == -3)
			messageError = "Usuario o template no asignado";
		else if (codError == 101)
			messageError = "Falta de saldo SMS en el servicio";
		else if (codError == 504)
			messageError = "Longitud del mensaje excede los caracteres permitidos";
		else if (codError == 503)
			messageError = "Parametro de template requerido";
		else if (codError == 504)
			messageError = "Longitud del mensaje excede los caracteres permitidos";
		else if (codError == 50)
			messageError = "Error no se pudo encolar el mensaje";
		else if (codError == 5)
			messageError = "Error no se pudo enviar el mensaje";
		else if (codError == 3)
			messageError = "Mensaje enviado correctamente";

		return messageError;

	}
}
