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

public class ExtraccionReporteReintegros extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(ExtraccionReporteReintegros.class);
	
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
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa execute");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			cn = ConnectionManager.newConnection();
			
			executeNotification(cn, executeSP,"I");
			executeNotification(cn, executeSP,"G");
			
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
	
	public void  executeNotification(Connection cn, CallableStatement executeSP, String operation) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification");
		}
		String query = "{ call cob_cartera..sp_reporte_reintegros(?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			executeSP.setString(2, null);
			boolean ejecucion = executeSP.execute();			
			LOGGER.debug("INGRESO AL METODO : "+ query + "fue " + ejecucion);
			LOGGER.debug("Operación : "+ operation);
			
		} catch(SQLException es){
			LOGGER.error("ERROR sqlException:",es);
			throw es;
		}catch (Exception ex) {
			LOGGER.error("ERROR executeNotification -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification");
			}
		}

	}
	
	
}
