package com.cobiscorp.cloud.notificationservice.impl;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaArcMcCobis  implements Job {
    private static final Logger logger = Logger.getLogger(CopiaArcMcCobis.class);
    private static final String messageOk = "Copia de Reporte Cifrado de Mc Collect a Cobis Exitosa!";
	@Override
	public void execute(JobExecutionContext jobExecutionContext)
			throws JobExecutionException {
		 CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CAMCW);
	        try {
	            if (logger.isDebugEnabled()) {
	                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
	            }
	            extractInsuranceReports(copyFileJob);
	        } catch (Exception ex) {
	            logger.error("Error al copiar Reporte de Mc Collect a Cobis: ", ex);
	        }
		
	}
	
    private void extractInsuranceReports(CopyFileJob copyFileJob) {
        FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToDestinationAndHistorySource();

        if (fileExchangeResponse.isSuccess()) {
            logger.info(messageOk);
            logger.debug("messageOk: "+messageOk);
        } else {
	    throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
	}
    }

}
