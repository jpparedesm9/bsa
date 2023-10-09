package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class GenerateArchMcCCobis extends NotificationGeneric implements Job {
	
	private static final Logger logger = Logger.getLogger(GenerateArchMcCCobis.class);

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
			logger.debug("JobName: " + context.getJobDetail().getName());

			executeByTransaction(context);
		} catch (Exception ex) {
			logger.error("Exception GenerateArchMcCCobis : ", ex);
		}
		
	}
	
	public void executeByTransaction(JobExecutionContext arg0) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa executeByTransaction Cobranza Mc Collect");
		}
		

		Connection cn = null;
		CallableStatement executeSP = null;
		String internalError=null;

		try {
			try{
			cn = ConnectionManager.newConnection();
			}
			catch (SQLException e) {
				logger.error(e.toString());
				internalError = "No se pudo establecer la conexi\u00f3n a la base de datos A";
			} catch (Exception e) {
				logger.error("Exception: ", e);
				internalError = "No se pudo establecer la conexi\u00f3n a la base de datos B";
			}
				
			String query = "{ ? =call cob_conta_super..sp_rep_cob_cobis_mc() }";
			
			if (internalError == null) {
				try {
					executeSP = cn != null ? cn.prepareCall(query) : null;
				} catch (SQLException e) {
					logger.error(e.toString());
					internalError = "No se pudo preparar la sentencia SQL para cargar Generar el Archivo Mc Collect Cobis";
				}
				if (logger.isDebugEnabled()) {
					logger.debug("Se preparó la sentencia SQL para cargar Generar el Archivo Mc Collect Cobis");
				}
			}
			
			if (internalError == null) {
				try {
					if (executeSP != null) {
						executeSP.registerOutParameter(1, Types.INTEGER);
					}
				} catch (SQLException e) {
					logger.error(e.toString());
					internalError = "No se pudo registrar el valor de retorno del procedimiento SQL";
				}
			}
			
			if (internalError == null) {
				try {
					if (executeSP != null) {
						executeSP.execute();
					}
				} catch (SQLException e) {
					logger.error(e.toString());
					internalError = "No se pudo ejecutar el sp sp_rep_cob_cobis_mc en la base de datos.";
				}
				if (logger.isDebugEnabled()) {
					logger.debug("Se ejecutó el proceso de ejecucion sp_rep_cob_cobis_mc en la base de datos");
				}
			}
			
			if (internalError == null) {
				Integer returnValue = null;
				try {
					if (executeSP != null) {
						logger.debug("executeSP: " + executeSP );
						returnValue = executeSP.getInt(1);
					}
				} catch (SQLException e) {
					logger.error(e.toString());
				}
				if (logger.isDebugEnabled()) {
					logger.debug("Valor de retorno del procedimiento sp_rep_cob_cobis_mc: " + (returnValue != null ? returnValue.toString() : null));
				}

				if (returnValue != null && returnValue != 0) {
					
					internalError = "Error en ejecucion del procedimiento sp_rep_cob_cobis_mc";			
					
				}
			}
		} catch (Exception ex) {
			logger.error("ERROR executeByTransaction GenerateArchMcCCobis -->", ex);
			throw ex;
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
				if (logger.isDebugEnabled()) {
					logger.debug("Finaliza executeByTransaction para GenerateArchMcCCobis");
				}
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión GenerateArchMcCCobis : ", e);
			}
		}
	}
	


}
