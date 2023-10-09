package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class CobranzaMcCollect extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(CobranzaMcCollect.class);

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
			LOGGER.error("Exception Cobranza Mc Collect: ", ex);
		}

	}

	public void executeByTransaction(JobExecutionContext arg0) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByTransaction Cobranza Mc Collect");
		}

		Connection cn = null;
		CallableStatement executeSP = null;

		try {
			cn = ConnectionManager.newConnection();
			// Cálculos y operaciones para obtener data para el SP
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Empieza operación I en  cob_cartera..sp_reporte_cobranza");
			}
			String query1 = "{ call cob_cartera..sp_reporte_cobranza(?,?,?) }";
			executeSP = cn.prepareCall(query1);
			executeSP.setEscapeProcessing(true);
			executeSP.setString(1, null);
			executeSP.setString(2, null);
			executeSP.setString(3, "I");
			executeSP.execute();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza operación I en  cob_cartera..sp_reporte_cobranza");
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Empieza operación F en  cob_cartera..sp_reporte_cobranza");
			}
			// Generación de Reporte
			String query2 = "{ call cob_cartera..sp_reporte_cobranza(?,?,?) }";
			executeSP = cn.prepareCall(query2);
			executeSP.setString(1, null);
			executeSP.setString(2, null);
			executeSP.setString(3, "F");
			executeSP.execute();
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza operación F en  cob_cartera..sp_reporte_cobranza");
			}
		} catch (Exception ex) {
			LOGGER.error("ERROR executeByTransaction Cobranza Mc Collect -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction Cobranza Mc Collect");
			}
		}
	}

}
