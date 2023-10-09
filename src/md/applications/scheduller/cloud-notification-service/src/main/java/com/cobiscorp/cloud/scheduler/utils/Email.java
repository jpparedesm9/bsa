package com.cobiscorp.cloud.scheduler.utils;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public abstract class Email {
	private static final Logger logger = Logger.getLogger(Email.class);

	public static void send(String from, String to, String cc, String subject, String body, String attachment) {

		CallableStatement executeSP = null;
		Connection connection = null;

		try {
			try {
				connection = ConnectionManager.newConnection();
			} catch (SQLException e) {
				throw new COBISInfrastructureRuntimeException("No se pudo establecer la conexi\u00f3n a la base de datos", e);
			} catch (Exception e) {
				logger.error("Exception: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se estableci\u00f3 la conexi\u00f3n a la base de datos");
			}

			String query = "{ call cob_credito..sp_envia_correo (?, ?, ?, ?, ?, ?) }";

			try {
				executeSP = connection.prepareCall(query);
			} catch (SQLException e) {
				throw new COBISInfrastructureRuntimeException("No se pudo preparar la sentencia SQL para env\u00edo de correo", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se prepar\u00f3 la sentencia SQL para env\u00edo de correo");
			}

			try {
				executeSP.setString(1, from);
				executeSP.setString(2, to);
				executeSP.setString(3, cc);
				executeSP.setString(4, subject);
				executeSP.setString(5, body);
				executeSP.setString(6, attachment);
			} catch (SQLException e) {
				throw new COBISInfrastructureRuntimeException("No se pudieron incluir los par\u00e1metros a la sentencia SQL para env\u00edo de correo", e);
			}

			try {
				executeSP.execute();
			} catch (SQLException e) {
				throw new COBISInfrastructureRuntimeException("No se pudo ejecutar la sentencia SQL para env\u00edo de correo", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se ejecut\u00f3 la sentencia SQL para env\u00edo de correo");
			}

		} finally {
			try {
				ConnectionManager.saveConnection(connection);
			} catch (Exception e) {
				logger.error("No se pudo cerrar la conexi\u00f3n a la base de datos");
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Termina send");
			}
		}

	}

}
