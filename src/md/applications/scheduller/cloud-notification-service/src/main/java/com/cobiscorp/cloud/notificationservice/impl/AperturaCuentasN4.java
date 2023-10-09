package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class AperturaCuentasN4 extends NotificationGeneric implements Job {
	
	private static final Logger LOGGER = Logger.getLogger(AperturaCuentasN4.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + context.getJobDetail().getName());

			executeByTransaction(context);
		} catch (Exception ex) {
			LOGGER.error("Exception: ", ex);
		}
		
	}
	
	public void executeByTransaction(JobExecutionContext arg0) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByTransaction");
		}
		String query = "{ call cob_conta_super..sp_rpt_apertura_cuentas() }";

		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			executeSP.execute();
		} catch (Exception ex) {
			LOGGER.error("ERROR executeByTransaction -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction");
			}
		}
	}
	


}
