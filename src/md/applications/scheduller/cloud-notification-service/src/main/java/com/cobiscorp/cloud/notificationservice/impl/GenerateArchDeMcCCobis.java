package com.cobiscorp.cloud.notificationservice.impl;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class GenerateArchDeMcCCobis implements Job {
    private static final Logger logger = Logger.getLogger(GenerateArchDeMcCCobis.class);
    private static final String messageOk = "Genearacion de Reporte DeCifrado Mc Collect Cobis Exitosa!";

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
	CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.GADMC);
	try {
	    if (logger.isDebugEnabled()) {
		logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
	    }

	    extractInsuranceReports(copyFileJob);
	} catch (Exception ex) {
	    logger.error("Error al generar el  Reporte DeCifrado Mc Collect CObis: ", ex);
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

	FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToDeCryptoAndHistory(pathSourceFolder, ".txt");

	if (fileExchangeResponse.isSuccess()) {
	    logger.info(messageOk);
	    logger.debug("messageOk: " + messageOk);

	} else {
	    throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
	}
    }

}
