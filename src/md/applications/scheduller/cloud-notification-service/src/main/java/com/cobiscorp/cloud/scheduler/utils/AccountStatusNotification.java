package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.factory.NotificationServiceFactory;
import com.cobiscorp.cloud.notificationservice.model.CustomerAccStatus;
import com.cobiscorp.cloud.notificationservice.service.IServiceBase;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class AccountStatusNotification {

	private static final ILogger logger = LogFactory.getLogger(AccountStatusNotification.class);
	private static String paramExec = "";
	private static final String EXTENSION_ZIP = ".zip";
	private static final String MENSAJE_1 = "Notificacion Estado de Cuenta";
	private static final String MENSAJE_2 = "Contraseña Estado de Cuenta";
	private static final String NOTIF_1 = "EEC_NOTIF";
	private static final String NOTIF_2 = "EEC_PSSWD";

	public static void generateNotification(String parameter, String parameterToPdf) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("AccountStatusNotification.generateNotification - INI");
		}

		try {
			paramExec = parameter;

			File xmlFile = null;
			IServiceBase notificationImpl = NotificationServiceFactory.getClass(paramExec);

			if (logger.isDebugEnabled()) {
				logger.logDebug("Clase= " + notificationImpl.getClass());
				logger.logDebug("Parametros= " + paramExec);
			}
			if (notificationImpl == null) {
				logger.logError("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
				return;
			}

			List<?> objectList = notificationImpl.xmlToDTO(xmlFile);
			for (Object iterator : objectList) {
				CustomerAccStatus customer = (CustomerAccStatus) iterator;
				if (logger.isDebugEnabled()) {
					logger.logDebug("AccountStatusNotification." + " --> filename= " + customer.getFilename());
				}
				customer.setMailSubject(MENSAJE_1);
				sendNotification(notificationImpl.setParameterToSendMail(iterator), returnFullZipFilename(customer.getFilename(), EXTENSION_ZIP), NOTIF_1);

				customer.setMailSubject(MENSAJE_2);
				sendNotification(notificationImpl.setParameterToSendMail(iterator), null, NOTIF_2);
			}

		} catch (Exception ex) {
			logger.logError("ERROR generateNotification-->", ex);
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug("AccountStatusNotification.generateNotification - FIN");
		}
	}

	private static void sendNotification(Map<String, Object> parameters, String zipFilename, String notifType) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa AccStatusNotif.sendNotification");
		}

		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			// Envio de notificacion
			String query = "{ call cob_credito..sp_notifica_estado_cta(?,?,?,?,?,?,?,?) }";
			ConfigManager ds = ConfigManager.getInstance();
			Class.forName(ds.getJdbDriver()).newInstance();
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);

			String emailTO = (String) parameters.get("EMAIL_TO");
			String subject = (String) parameters.get("SUBJECT");
			Integer clientId = (Integer) parameters.get("CLIENT_ID");
			String clientName = (String) parameters.get("CLNT_NAME");

			if (logger.isDebugEnabled()) {
				logger.logDebug("emailTO-->" + emailTO);
				logger.logDebug("subject-->" + subject);
				logger.logDebug("pdfFile-->" + zipFilename);
				logger.logDebug("clientId-->" + clientId);
				logger.logDebug("clientName-->" + clientName);
				logger.logDebug("paramExec-->" + paramExec);
			}
			executeSP.setString(1, emailTO);
			executeSP.setString(2, null);
			executeSP.setString(3, null);
			executeSP.setString(4, subject);
			executeSP.setInt(5, clientId); // funcionarioId
			executeSP.setString(6, clientName); // nombreFuncionario
			executeSP.setString(7, zipFilename);
			executeSP.setString(8, notifType);
			executeSP.execute();

			if (logger.isDebugEnabled()) {
				logger.logDebug("finaliza AccStatusNotif.sendNotification");
			}
		} catch (Exception e) {
			logger.logError("ERROR AccStatusNotif.sendNotification -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.logError("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza AccStatusNotif.sendNotification");
			}
		}
	}

	private static String returnFullZipFilename(String zipFileName, String extension) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa AccStatusNotif.returnFullZipFilename");
		}
		String nombreExport = zipFileName;
		return nombreExport.concat(extension);
	}
}
