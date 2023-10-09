package com.cobiscorp.cloud.notificationservice.impl;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class GenerateArchCifMcCollect implements Job {
    private static final Logger logger = Logger.getLogger(GenerateArchCifMcCollect.class);
    private static final String messageOk = "Genraracion de Reporte Cifrado Mc Collect Exitosa!";

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
	CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.GACMC);
	try {
	    if (logger.isDebugEnabled()) {
		logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
	    }

	    extractInsuranceReports(copyFileJob);
	} catch (Exception ex) {
	    logger.error("Error al generar el  Reporte Cifrado Mc Collect: ", ex);
	}

    }

    private void extractInsuranceReports(CopyFileJob copyFileJob) {

	// Path sourceFolder
	String pathSourceFolder = copyFileJob.getSourceFolder();

	if (pathSourceFolder.equals("") || pathSourceFolder == null) {
	    return;
	}

	if (logger.isDebugEnabled()) {
	    logger.debug("pathSourceFolder: " + pathSourceFolder);
	}

	FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToCryptoAndHistoryandError(pathSourceFolder, ".txt", ".err");

	if (fileExchangeResponse.isSuccess()) {
	    logger.info(messageOk);
	    logger.debug("messageOk: " + messageOk);

	} else {
	    throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
	}
    }

}
