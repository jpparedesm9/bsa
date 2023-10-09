package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.DownloadFileJob;
import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.scheduler.utils.FileExchangeJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class DescargaDomiciliacion extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(DescargaDomiciliacion.class);
	private static final String messageOk = "DESCARGA EXITOSA DEL ARCHIVO DE DOMICILIACI\u00d3N !!";
	private static String from = null;
	private static String to = null;
	private static String cc = null;
	private static String subject = null;
	private static String attachment = null;
	private static final String suprimError = "[@Exception]-- ErrorCode:80000-- ErrorMessage: null-- com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException:";
	
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
			downloadDirectDebits();
		} catch (Exception ex) {
			LOGGER.error("Error al ejecutar Descarga de Domiciliaci\u00f3n: ",ex);
			Email.send(from, to, cc, subject, ex.getMessage(), attachment);
		}
	}

	private void downloadDirectDebits() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia downloadDirectDebits");
		}

		FileExchangeResponse fileExchangeResponse;

		DownloadFileJob downloadDirectDebitsJob = new DownloadFileJob(FileExchangeJob.Job.DSCDM);

		fileExchangeResponse = downloadDirectDebitsJob.getConfiguration();
		
		from = downloadDirectDebitsJob.getFrom();
		to = downloadDirectDebitsJob.getTo();
		cc = downloadDirectDebitsJob.getCc();
		subject = downloadDirectDebitsJob.getSubject();
		attachment = downloadDirectDebitsJob.getAttachment();
		
		Integer retry = 1;
		String errorSend = null;
		while (retry <= downloadDirectDebitsJob.getRetryDownload()) {
			LOGGER.debug("Intento de descarga de domiciliaci\u00f3n #" + retry);
			try {
				if (fileExchangeResponse.isSuccess()) {
					downloadDirectDebitsJob.downloadFiles();
					break;
				}
			} catch (Exception e) {
				LOGGER.error("Intento de descarga #" + retry + " fallido.");
				if (retry == downloadDirectDebitsJob.getRetryDownload()) {
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
