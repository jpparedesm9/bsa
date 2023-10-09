package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.io.IOException;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.FileUtil;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class ReporteCoka implements Job {
	private static final Logger LOGGER = Logger.getLogger(ReporteCoka.class);

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("JobName: " + context.getJobDetail().getName());
			LOGGER.debug("Inicia encriptacion y copia de archivo reporte coka");
		}

		CopyFileJob copyFileJob = null;

		try {
			copyFileJob = new CopyFileJob(FileJob.Job.XCRYS);
			encripytAndCopyReport(copyFileJob);
		} catch (Exception ex) {
			LOGGER.error("Error al copiar archivos de interfactura Procesados: ", ex);
		}

	}

	private void encripytAndCopyReport(CopyFileJob copyFileJob) throws IOException {
		try {

			File reportFile = new File(copyFileJob.getSourceFolder() + copyFileJob.getFileNamePattern());
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("FILENAME: " + reportFile.getPath());
			}
			if (!FileUtil.existFile(copyFileJob.getDestinationFolder() + copyFileJob.getFileNamePattern())) {
				copyFileJob.copyFileToWorkFolder(reportFile);
				copyFileJob.encryptRSAAndMoveFile("C:\\Notificador\\notification\\keys\\coka_report.key");
			} else {
				LOGGER.info("EL ARCHIVO: " + copyFileJob.getFileNamePattern()
						+ " YA FUE COPIADO Y ENCRIPTADO, SE ENCUENTRA EN EL DIRECTORIO: "
						+ copyFileJob.getDestinationFolder());
			}

		} catch (Exception e) {
			LOGGER.error("ERROR encripytAndCopyReport -->", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza encripytAndCopyReport");
			}
		}
	}

}
