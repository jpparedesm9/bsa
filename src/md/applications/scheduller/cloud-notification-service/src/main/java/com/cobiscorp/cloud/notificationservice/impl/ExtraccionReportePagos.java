package com.cobiscorp.cloud.notificationservice.impl;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.io.File;
import java.util.List;
import java.util.Map;

public class ExtraccionReportePagos extends NotificationGeneric implements Job {
    private static final Logger logger = Logger.getLogger(ExtraccionReportePagos.class);
    private static final String messageOk = "EXTRACCION EXITOSA DE REPORTES DE PAGOS!!";

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
        CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.XTRRP);
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            }
            extractInsuranceReports(copyFileJob);
        } catch (Exception ex) {
            logger.error("Error al ejecutar la Extracción de Reportes de Pagos: ", ex);
            copyFileJob.sendMail(ex.getMessage());
        }
    }

    private void extractInsuranceReports(CopyFileJob copyFileJob) {
        FileExchangeResponse fileExchangeResponse = copyFileJob.copyFiles();

        if (fileExchangeResponse.isSuccess()) {
            logger.info(messageOk);
            copyFileJob.sendMail(messageOk);
        } else {
            throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
        }
    }

}
