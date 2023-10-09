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
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaReportesODS extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CopiaReportesODS.class);
    private static final String messageOk = "COPIA EXITOSA ARCHIVOS REPORTES ODS FILESHARE!!";
    private static String from = null;
    private static String to = null;
    private static String cc = null;
    private static String subject = null;
    private static String attachment = null;

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
		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYODS);
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			extractInsuranceReports(copyFileJob);
		} catch (Exception ex) {
			LOGGER.error("Error al copiar Reportes ODS FileShare: ", ex);
		}
    }
    
	private void extractInsuranceReports(CopyFileJob copyFileJob) {
		FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToDestinationAndHistoryandError();
		if (fileExchangeResponse.isSuccess()) {
			LOGGER.info(messageOk);
			LOGGER.debug("messageOk: " + messageOk);
            if (from != null && !"".equals(from)) {
            	Email.send(from, to, cc, subject, messageOk, attachment);	
            }
		} else {
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}

}
