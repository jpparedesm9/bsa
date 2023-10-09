package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaReporteReintegros  implements Job {
    private static final Logger logger = Logger.getLogger(CopiaReporteReintegros.class);
    private static final String messageOk = "Copia de Reporte Reintegros Exitosa!";
	@Override
	public void execute(JobExecutionContext jobExecutionContext)
			throws JobExecutionException {
		 CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYRR);
	        try {
	            if (logger.isDebugEnabled()) {
	                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
	            }
	            copiaReporteReinte(copyFileJob);
	        } catch (Exception ex) {
	            logger.error("Error al copiar Reporte Reintegros: ", ex);
	            //copyFileJob.sendMail(ex.getMessage());
	        }
		
	}
	
    private void copiaReporteReinte(CopyFileJob copyFileJob) {
        FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToDestinationAndHistoryandError();

        if (fileExchangeResponse.isSuccess()) {
            logger.info(messageOk);
            logger.debug("messageOk: "+messageOk);
            //copyFileJob.sendMail(messageOk);
        } else {
            throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
        }
    }

}
