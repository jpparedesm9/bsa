package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.DownloadMultiFileJob;
import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.scheduler.utils.FileExchangeJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class DescargaFacturacionTimbConectorA extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(DescargaFacturacionTimbConectorA.class);
	private static final String messageOk = "DESCARGA EXITOSA DEL ARCHIVO DE FACTURACION !!";
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
			LOGGER.error("Error al ejecutar Descarga de Facturación: ", ex);
			Email.send(from, to, cc, subject, ex.getMessage(), attachment);
		}
	}

	private void downloadDirectDebits() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia downloadDirectDebits");
		}

		FileExchangeResponse fileExchangeResponse;

		DownloadMultiFileJob downloadDirectDebitsJob = new DownloadMultiFileJob(FileExchangeJob.Job.DAFACCA);

		fileExchangeResponse = downloadDirectDebitsJob.getConfiguration();

		from = downloadDirectDebitsJob.getFrom();
		to = downloadDirectDebitsJob.getTo();
		cc = downloadDirectDebitsJob.getCc();
		subject = downloadDirectDebitsJob.getSubject();
		attachment = downloadDirectDebitsJob.getAttachment();

		LOGGER.debug("from: " + from);
		LOGGER.debug("to: " + to);
		LOGGER.debug("cc: " + cc);
		LOGGER.debug("subject: " + subject);
		LOGGER.debug("attachment: " + attachment);

		Integer retry = 1;
		String errorSend = null;
		while (retry <= downloadDirectDebitsJob.getRetryDownload()) {
			LOGGER.debug("Descarga de facturación - intento #" + retry);
			try {
				if (fileExchangeResponse.isSuccess()) {
					downloadDirectDebitsJob.downloadFiles(true);
					break;
				}
			} catch (Exception e) {
				LOGGER.error("Descarga de facturación - intento #" + retry + " fallido.");
				if (retry == downloadDirectDebitsJob.getRetryDownload()) {
					errorSend = e.toString().substring(e.toString().indexOf(suprimError) + suprimError.length(), e.toString().length());
					throw new COBISInfrastructureRuntimeException(errorSend);
				}
			}
			retry++;
		}

		if (fileExchangeResponse.isSuccess()) {
			LOGGER.info(messageOk);
			// Email.send(from, to, cc, subject, messageOk, attachment);
		} else {
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}
}
