package com.cobiscorp.cloud.scheduler.utils;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.notificationservice.model.ResponseRule;

public class ExecuteRule {

	private static final Logger LOGGER = Logger.getLogger(ExecuteRule.class);

	public ResponseRule executeRule(Connection cn, CallableStatement executeSP, String operationType) throws Exception {
		ResponseRule responseRule = new ResponseRule();

		String estadoGENXML = "";
		String timbrarXML = "";
		String generarPdf = "";
		String enviarEmail = "";

		try {
			ResultSet resultAdminReglaRev = executeNotificationGeneral(cn, executeSP, operationType);
			LOGGER.debug("result: " + resultAdminReglaRev);

			while (resultAdminReglaRev.next()) {
				estadoGENXML = resultAdminReglaRev.getString(1);
				timbrarXML = resultAdminReglaRev.getString(2);
				generarPdf = resultAdminReglaRev.getString(3);
				enviarEmail = resultAdminReglaRev.getString(4);
				LOGGER.debug("Resultado de la regla Estado Cuenta -->>operationType:" + operationType + " -- >>estadoGENXML: " + estadoGENXML + " -->>timbrarXML: "
						+ timbrarXML + " -->>generarPdf: " + generarPdf + " -->>enviarEmail: " + enviarEmail);
			}
			responseRule.setEstadoGENXML(estadoGENXML);
			responseRule.setTimbrarXML(timbrarXML);
			responseRule.setGenerarPdf(generarPdf);
			responseRule.setEnviarEmail(enviarEmail);
			responseRule.setTipoOperacion(operationType);
			
		} catch (Exception e) {
			throw e;
		}

		return responseRule;
	}

	public static ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String toperation)
			throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification General Estado de Cuenta");
		}
		
		String query = "{ call cob_conta_super..sp_admin_est_cta(?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, toperation);
			executeSP.execute();
			return executeSP.getResultSet();
			
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotification General regla  -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification General regla ");
			}
		}

	}
}
