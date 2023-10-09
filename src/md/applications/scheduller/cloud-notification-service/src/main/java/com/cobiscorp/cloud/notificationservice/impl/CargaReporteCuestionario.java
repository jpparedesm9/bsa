package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.cobiscorp.cloud.scheduler.utils.FileExchangeJob;
import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.scheduler.utils.UploadFileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

/* REQ#1538743 */
public class CargaReporteCuestionario extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CargaReporteCuestionario.class);
	private static final String messageOk = "CARGA EXITOSA ARCHIVOS REPORTES CUESTIONARIOS!!";
	private static String from = null;
	private static String to = null;
	private static String cc = null;
	private static String subject = null;
	private static String attachment = null;
	private static String message = null;
	private static final String suprimError = "COBISInfrastructureRuntimeException:";

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
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			cargarArchivos();
		} catch (Exception ex) {
			LOGGER.error("Error al ejecutar Carga Reportes Custionarios ", ex);
		}
	}

	private void cargarArchivos() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia CargaReporteCuestionario");
		}
		FileExchangeResponse fileExchangeResponse;
		UploadFileJob uploadFileJob = new UploadFileJob(FileExchangeJob.Job.CARRCU);
		fileExchangeResponse = uploadFileJob.getConfiguration();
		from = uploadFileJob.getFrom();
		to = uploadFileJob.getTo();
		cc = uploadFileJob.getCc();
		subject = uploadFileJob.getSubject();
		attachment = uploadFileJob.getAttachment();
		
		if (fileExchangeResponse.isSuccess()) {
			Integer retry = 1;
			String errorSend = null;
			LOGGER.debug("retry: " + retry + " -> retryUpload: " + uploadFileJob.getRetryUpload());
			while (retry <= uploadFileJob.getRetryUpload()) {
				LOGGER.debug("Intento de carga de Reportes Cuestionarios fileshare #" + retry);
				try {
					if (fileExchangeResponse.isSuccess()) {
						uploadFileJob.uploadFiles();
						break;
					}
				} catch (Exception e) {
					LOGGER.error("Intento de carga reportes Cuestionarios #" + retry + " fallido.");
					if (retry == uploadFileJob.getRetryUpload()) {
						LOGGER.debug("Reportes Cuestionarios: Error al intentar uploadFiles: " + e.toString());
						errorSend = e.toString().substring(e.toString().indexOf(suprimError) + suprimError.length(),
								e.toString().length());
						throw new COBISInfrastructureRuntimeException(errorSend);
					}
				}
				retry++;
			}
		}
		if (fileExchangeResponse.isSuccess()) {
			LOGGER.info(messageOk);
			String texto = null;
			if (to != null && !"".equals(to)) {
				LOGGER.info("Envio mensaje reportes Cuestionarios to: " + to);
			}
		} else {
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}
}
