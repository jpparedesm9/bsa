package com.cobiscorp.cloud.notificationservice.impl;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.io.IOException;

public class CopiaEstadoCuentaInterfacturaProcesados implements Job {
    private static final Logger logger = Logger.getLogger(CopiaEstadoCuentaInterfacturaProcesados.class);
    private static final String messageOk = "Copia de Archivos de Estado de Cuenta Interfactura Procesados Exitosamente!";

    @Override
    public void execute(JobExecutionContext jobExecutionContext)
            throws JobExecutionException {
        if (logger.isDebugEnabled()) {
            logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            logger.debug("Inicia copia de archivos de Interfactura Procesados");
        }

        CopyFileJob copyFileJob = null;

        try {
            copyFileJob = new CopyFileJob(FileJob.Job.CPYIFP);
            getSignedInvoices(copyFileJob);
        } catch (Exception ex) {
            logger.error("Error al copiar archivos de interfactura Procesados: ", ex);
        }
    }

    private void getSignedInvoices(CopyFileJob copyFileJob) throws IOException {
        FileExchangeResponse fileExchangeResponse = copyFileJob.moveFiles();

        if (fileExchangeResponse.isSuccess()) {
            logger.info(messageOk);
        } else {
            throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
        }
    }

}
