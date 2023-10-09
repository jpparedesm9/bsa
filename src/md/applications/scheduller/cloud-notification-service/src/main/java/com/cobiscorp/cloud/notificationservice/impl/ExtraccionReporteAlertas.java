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
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class ExtraccionReporteAlertas extends NotificationGeneric implements Job {
    private static final Logger logger = Logger.getLogger(ExtraccionReporteAlertas.class);
    private static final String messageOk = "EXTRACCION EXITOSA DE REPORTES DE ALERTAS!!";

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
        CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.XTRRA);
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            }
            
             try {
            	   extractInsuranceReports(copyFileJob);
                 } catch (COBISInfrastructureRuntimeException e) {
                logger.debug("ErrorCOBISInfrastructureRuntimeException en XTRRA : "+e.toString());
                 }
            logger.info("Inicia copia de archivos a FTP de Cobis Job CPYRAF");
            CopyFileJob copyFileJobRegulatoryAltas = new CopyFileJob(FileJob.Job.CPYRAF);
            extractInsuranceReportAlerts(copyFileJobRegulatoryAltas);

        } catch (Exception ex) {
            logger.error("Error al ejecutar la Extracción de Reportes y copia de Alertas: ", ex);
        }
    }

    private void extractInsuranceReports(CopyFileJob copyFileJob) {
    	FileExchangeResponse fileCopyResponse = copyFileJob.unzipFile();
    	if (fileCopyResponse.isSuccess()) {
    		logger.info(messageOk);
        } else {
        	logger.info("NO EXISTE NING\u00daN ARCHIVO PARA DESCOMPRIMIR");
        } 	
    }
    
    private void extractInsuranceReportAlerts(CopyFileJob copyFileJob) {
    	
    	logger.info("Inicia extractInsuranceReportAlerts");
    	FileExchangeResponse fileCopyResponse = copyFileJob.copyFilesToDestinationAndHistory();
    	if (fileCopyResponse.isSuccess()) {
    		logger.info(messageOk);
        } else {
        	logger.info("NO EXISTE NING\u00daN ARCHIVO de alertas para Copiar");
        } 	
    }
}
