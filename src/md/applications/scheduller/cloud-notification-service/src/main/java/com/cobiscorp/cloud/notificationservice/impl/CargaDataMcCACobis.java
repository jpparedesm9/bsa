package com.cobiscorp.cloud.notificationservice.impl;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CargaDataMcCACobis  implements Job {
    private static final Logger logger = Logger.getLogger(CargaDataMcCACobis.class);
    private static final String messageOk = "Carga Data Mc COllect a Cobis Exitosa!";
	@Override
	public void execute(JobExecutionContext jobExecutionContext)
			throws JobExecutionException {
		 CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CDMCC);
	        try {
	            if (logger.isDebugEnabled()) {
	                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
	            }
	            extractInsuranceReports(copyFileJob);
	        } catch (Exception ex) {
	            logger.error("Error Carga Data Mc COllect a Cobis: ", ex);
	        }
		
	}
	
    private void extractInsuranceReports(CopyFileJob copyFileJob) {
        FileExchangeResponse fileExchangeResponse = copyFileJob.cargaDataMcCopyFilesAndHistory();
        logger.info("fileExchangeResponse"+fileExchangeResponse);
        if (fileExchangeResponse.isSuccess()) {
            logger.info(messageOk);
            logger.debug("messageOk: "+messageOk);
        } else {
	    throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
	}
    }

}
