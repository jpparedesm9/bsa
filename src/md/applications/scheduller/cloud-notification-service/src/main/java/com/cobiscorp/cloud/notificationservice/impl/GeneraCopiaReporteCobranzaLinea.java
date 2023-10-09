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

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class GeneraCopiaReporteCobranzaLinea extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(GeneraCopiaReporteCobranzaLinea.class);

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
			LOGGER.debug("-->>Reporte Cobranza En LInea-JobName: " + context.getJobDetail().getName());
			executeByTransaction(context);

		} catch (Exception ex) {
			LOGGER.error("Exception Reporte Cobranza En LInea: ", ex);
		}

	}

	public void executeByTransaction(JobExecutionContext arg0) throws Exception {
		if (LOGGER.isDebugEnabled())
			LOGGER.debug("Ingresa executeByTransaction Cobranza En LInea");

		CopyFileJob copyFileJob = null;
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			cn = ConnectionManager.newConnection();
			// Cálculos y operaciones para obtener data para el SP
			if (LOGGER.isDebugEnabled())
				LOGGER.debug("Empieza operación I en  cob_cartera..sp_reporte_cobranzas_linea");

			// Generación de Reporte
			String quer1 = "{ call cob_cartera..sp_reporte_cobranzas_linea(?) }";
			executeSP = cn.prepareCall(quer1);
			executeSP.setString(1, null);
			executeSP.execute();

			copyFileJob = new CopyFileJob(FileJob.Job.GCRCOLI);
			moveReport(copyFileJob);

			if (LOGGER.isDebugEnabled())
				LOGGER.debug("Finaliza operación I en  cob_cartera..sp_reporte_cobranzas_linea");

		} catch (Exception ex) {
			LOGGER.error("ERROR executeByTransaction Cobranza En LInea -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.debug("Finaliza executeByTransaction Cobranza En LInea");
		}
	}

	private void moveReport(CopyFileJob copyFileJob) {
		FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToDestinationAndHistory();

		if (fileExchangeResponse.isSuccess()) {
			LOGGER.debug("Finaliza executeByTransaction Cobranza En LInea");
		} else {
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}
}
