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

public class CustomerAndProspectInventory extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CustomerAndProspectInventory.class);

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
         if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("JobName: " + context.getJobDetail().getName());
         }
			executeReport(context);
		} catch (Exception ex) {
			LOGGER.error("Exception: " + ex);
		}
	}

	private void executeReport(JobExecutionContext context) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ejecuta reporte de IS - Inventario Clientes");
		}
		Connection cn = null;
		CallableStatement executeSP = null;		
		String query = "{ call cob_conta_super..sp_rpt_inv_clientes_prosp() }";
		try {
			cn = ConnectionManager.newConnection();
			executeSP = cn.prepareCall(query);
			boolean hasResults = executeSP.execute();
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Estado Ejecucion IS_2 = " + hasResults);
			}
		} catch (Exception e) {
			LOGGER.error("ERROR executeReport reporte de IS - Inventario Clientes -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeReport reporte de IS - Inventario Clientes");
			}
		}

	}
}
