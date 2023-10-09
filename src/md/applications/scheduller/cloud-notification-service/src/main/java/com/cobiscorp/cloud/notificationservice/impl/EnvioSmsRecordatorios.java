package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class EnvioSmsRecordatorios extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(EnvioSmsRecordatorios.class);

	@Override
	public List<?> xmlToDTO(File inputData) {

		return null;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		return null;
	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa execute");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			LOGGER.debug("JobName: " + context.getJobDetail().getName());
			cn = ConnectionManager.newConnection();

			executeNotification(cn, executeSP);

		} catch (Exception e) {
			// TODO: handle exception
			LOGGER.error("Exception:", e);
		}

		finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				LOGGER.error("Exception:", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza execute");
			}
		}

	}

	public void executeNotification(Connection cn, CallableStatement executeSP) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification");
		}

		String query = "{ call cob_cartera..sp_envio_sms_recordatorios() }";

		try {
			executeSP = cn.prepareCall(query);

			boolean ejecucion = executeSP.execute();

		} catch (SQLException es) {
			LOGGER.error("ERROR sqlException:", es);
			throw es;
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotification -->", ex);
			throw ex;
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification");
			}

		}
	}

}
