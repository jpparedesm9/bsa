package com.cobiscorp.cloud.notificationservice.impl;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaArcCifMcCollect  implements Job {
    private static final Logger logger = Logger.getLogger(CopiaArcCifMcCollect.class);
    private static final String messageOk = "Copia de Reporte Cifrado Mc Collect Exitosa!";
	@Override
	public void execute(JobExecutionContext jobExecutionContext)
			throws JobExecutionException {
		 CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CACMC);
	        try {
	            if (logger.isDebugEnabled()) {
	                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
	            }
	            extractInsuranceReports(copyFileJob);
	        } catch (Exception ex) {
	            logger.error("Error al copiar Reporte Cifrado Mc Collect: ", ex);
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
