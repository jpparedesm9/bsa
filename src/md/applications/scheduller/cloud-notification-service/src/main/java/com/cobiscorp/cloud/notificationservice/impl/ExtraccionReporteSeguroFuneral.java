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

public class ExtraccionReporteSeguroFuneral extends NotificationGeneric implements Job {
    private static final Logger logger = Logger.getLogger(ExtraccionReporteSeguroFuneral.class);
    private static final String messageOk = "EXTRACCION EXITOSA DE REPORTES DE SEGUROS FUNERAL!!";

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
        CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.XTRSF);
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            }
            extractInsuranceReports(copyFileJob);
            logger.info("Inicia CPYSFRA");
            CopyFileJob copyFileJobRegulatoryAltas = new CopyFileJob(FileJob.Job.CPYSFRA);
            extractInsuranceReportsRegulatoryAltas(copyFileJobRegulatoryAltas);
            
            logger.info("Inicia CPYSFRB");
            CopyFileJob copyFileJobRegulatoryBajas = new CopyFileJob(FileJob.Job.CPYSFRB);
            extractInsuranceReportsRegulatoryBajas(copyFileJobRegulatoryBajas);
            logger.info("Ejecucion terminada con exito");
        } catch (Exception ex) {
            logger.error("Error al ejecutar la Extracción de Reportes de Seguros Funeral: ", ex);
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
    
    private void extractInsuranceReportsRegulatoryAltas(CopyFileJob copyFileJob) {
    	
    	logger.info("Inicia extractInsuranceReportsRegulatoryAltas");
    	FileExchangeResponse fileCopyResponse = copyFileJob.copyFilesNormal();
    	if (fileCopyResponse.isSuccess()) {
    		logger.info(messageOk);
        } else {
        	logger.info("NO EXISTE NING\u00daN ARCHIVO PARA COPIAR");
        } 	
    }
    
    private void extractInsuranceReportsRegulatoryBajas(CopyFileJob copyFileJob) { 	
    	logger.info("Inicia extractInsuranceReportsRegulatoryBajas");
    	FileExchangeResponse fileCopyResponse = copyFileJob.copyFilesNormal();
    	if (fileCopyResponse.isSuccess()) {
    		logger.info(messageOk);
        } else {
        	logger.info("NO EXISTE NING\u00daN ARCHIVO PARA COPIAR");
        } 	
    }

}
