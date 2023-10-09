package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.scheduler.utils.FileExchangeJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.UploadFileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CargaReporteAlertas extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CargaReporteAlertas.class);
	private static final String messageOk = "CARGA EXITOSA DEL ARCHIVO DE ALERTAS !!";
	private static final String messageOkExtract = "EXTRACCION EXITOSA DE REPORTES DE SEGUROS !!";
	private static String from = null;
	private static String to = null;
	private static String cc = null;
	private static String subject = null;
	private static String attachment = null;
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
			uploadAlertReports();
		} catch (Exception ex) {
			LOGGER.error("Error al ejecutar Carga de Reporte de Alertas: ", ex);
			Email.send(from, to, cc, subject, ex.getMessage(), attachment);
		}
	}

	private void uploadAlertReports() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia uploadAlertReports");
		}

		FileExchangeResponse fileExchangeResponse;
		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.XTRRA);
		
		FileExchangeResponse fileCopyResponse = copyFileJob.unzipFile();
		
		if (fileCopyResponse.isSuccess()) {
            LOGGER.info(messageOkExtract);
        } else {
        	LOGGER.info("NO EXISTE NING\u00daN ARCHIVO PARA DESCOMPRIMIR");
        }
		
		UploadFileJob downloadDirectDebitsJob = new UploadFileJob(FileExchangeJob.Job.CRGRA);
		fileExchangeResponse = downloadDirectDebitsJob.getConfiguration();

		from = downloadDirectDebitsJob.getFrom();
		to = downloadDirectDebitsJob.getTo();
		cc = downloadDirectDebitsJob.getCc();
		subject = downloadDirectDebitsJob.getSubject();
		attachment = downloadDirectDebitsJob.getAttachment();

		Integer retry = 1;
		String errorSend = null;

		try {
			downloadDirectDebitsJob.chageNameUpload();
		} catch (Exception e) {
			LOGGER.error("Intento de carga #" + retry + " fallido.");
			errorSend = e.toString().substring(e.toString().indexOf(suprimError) + suprimError.length(), e.toString().length());
			throw new COBISInfrastructureRuntimeException(errorSend);
		}

		while (retry <= downloadDirectDebitsJob.getRetryUpload()) {
			LOGGER.debug("Intento de carga de Reporte de Alertas #" + retry);

			try {
				if (fileExchangeResponse.isSuccess()) {
					downloadDirectDebitsJob.uploadFiles();
					break;
				}
			} catch (Exception e) {
				LOGGER.error("Intento de carga #" + retry + " fallido.");
				if (retry == downloadDirectDebitsJob.getRetryUpload()) {
					LOGGER.debug("Error al intentar uploadFiles: " + e.toString());
					errorSend = e.toString().substring(e.toString().indexOf(suprimError) + suprimError.length(), e.toString().length());
					throw new COBISInfrastructureRuntimeException(errorSend);
				}
			}
			retry++;
		}

		if (fileExchangeResponse.isSuccess()) {
			LOGGER.info(messageOk);
			Email.send(from, to, cc, subject, messageOk, attachment);
		} else {
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}
}
