package com.cobiscorp.cloud.notificationservice.impl;

import com.cobiscorp.cloud.scheduler.utils.Email;
import com.cobiscorp.cloud.scheduler.utils.FileExchangeJob;
import com.cobiscorp.cloud.scheduler.utils.FileUtil;
import com.cobiscorp.cloud.scheduler.utils.UploadFileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.io.File;
import java.util.List;
import java.util.Map;

public class CargaXmlComplementoConectorC extends NotificationGeneric implements Job {
    private static final Logger LOGGER = Logger.getLogger(CargaXmlComplementoConectorC.class);
    private static final String messageOk = "CARGA EXITOSA AL FTP INTERFACTURA COMPLEMENTO !!";
    private static String from = null;
    private static String to = null;
    private static String cc = null;
    private static String subject = null;
    private static String attachment = null;
    private static final String suprimError = "COBISInfrastructureRuntimeException:";

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
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            }
            loadInsuranceReports();
        } catch (Exception ex) {
            LOGGER.error("Error al ejecutar Carga al Ftp Interfactura Complemento: ", ex);
            Email.send(from, to, cc, subject, ex.getMessage(), attachment);
        }
    }

    private void loadInsuranceReports() {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("Inicia loadInsuranceReports para Carga de xml Complemento");
        }

        FileExchangeResponse fileExchangeResponse;

        UploadFileJob uploadFileJob = new UploadFileJob(FileExchangeJob.Job.CAZCOCA);

        fileExchangeResponse = uploadFileJob.getConfiguration();

        from = uploadFileJob.getFrom();
        to = uploadFileJob.getTo();
        cc = uploadFileJob.getCc();
        subject = uploadFileJob.getSubject();
        attachment = uploadFileJob.getAttachment();
        
        LOGGER.debug("from: " + from);
        LOGGER.debug("to: "   + to);
        LOGGER.debug("cc: "   + cc);
        LOGGER.debug("subject: "    + subject);
        LOGGER.debug("attachment: " + attachment);

        if (fileExchangeResponse.isSuccess()) {

            Integer retry = 1;
            String errorSend = null;

            while (retry <= uploadFileJob.getRetryUpload()) {
                LOGGER.debug("Intento de carga de Interfactura Complemento #" + retry);

                try {
                    if (fileExchangeResponse.isSuccess()) {
                        uploadFileJob.uploadFilesPattern();
                        break;
                    }
                } catch (Exception e) {
                    LOGGER.error("Intento de carga Interfactura Complemento1 #" + retry + " fallido.");
                    if (retry == uploadFileJob.getRetryUpload()) {
                        LOGGER.debug("Error al intentar uploadFiles: " + e.toString());
                        errorSend = e.toString().substring(e.toString().indexOf(suprimError) + suprimError.length(), e.toString().length());
                        throw new COBISInfrastructureRuntimeException(errorSend);
                    }
                }
                retry++;
            }
        }

        if (fileExchangeResponse.isSuccess()) {
            LOGGER.info(messageOk);
            //Email.send(from, to, cc, subject, messageOk, attachment);
        } else {
            throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
        }
    }
}
