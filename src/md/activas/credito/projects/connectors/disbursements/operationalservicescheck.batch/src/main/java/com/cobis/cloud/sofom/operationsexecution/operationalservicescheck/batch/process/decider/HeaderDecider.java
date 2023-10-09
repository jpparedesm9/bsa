package com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.process.decider;

import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.BatchResponse;
import com.cobiscorp.cobis.batch.core.BatchServiceExecutor;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.job.flow.FlowExecutionStatus;
import org.springframework.batch.core.job.flow.JobExecutionDecider;

import java.util.List;

public class HeaderDecider implements JobExecutionDecider {
    private static final ILogger logger = LogFactory.getLogger(HeaderDecider.class);

    private BatchServiceExecutor serviceExecutor;

    /**
     * @param serviceExecutor the serviceExecutor to set
     */
    public void setServiceExecutor(BatchServiceExecutor serviceExecutor) {
        logger.logInfo("Setting object serviceExecutor:" + serviceExecutor);
        this.serviceExecutor = serviceExecutor;
    }


    /**
     * Sets the parameter databaseName
     *
     * @param databaseName
     */
    public void setDatabaseName(String databaseName) {
    }

    @SuppressWarnings("unchecked")
    @Override
    public FlowExecutionStatus decide(JobExecution jobExecution, StepExecution stepExecution) {

        logger.logInfo("INIT... FlowExecutionStatus");

        String pathFile = jobExecution.getJobInstance().getJobParameters().getString(Constants.PROPERTY_FILE_NAME);
        String fileName = pathFile.substring((pathFile.lastIndexOf("/") + 1), pathFile.length());
        String TypeJob = jobExecution.getJobInstance().getJobParameters().getString(Constants.JOB_TRANSACTION);
        String causeRejection = null;
        String headerLine = null;
        logger.logDebug("fileName: " + fileName);

        logger.logInfo("TransactionType :" + TypeJob);
        logger.logDebug("getExecutionContext: " + jobExecution.getExecutionContext());
        logger.logDebug("PROPERTY_CONTENT_HEADER: " + jobExecution.getExecutionContext().get(Constants.PROPERTY_CONTENT_HEADER));


        if (jobExecution.getExecutionContext() != null) {
            List<String> headerContent = (List<String>) jobExecution.getExecutionContext().get(cobiscorp.ecobis.integrationengine.commons.Constants.PROPERTY_CONTENT_HEADER);
            for (String line : headerContent) {
                logger.logInfo("HEADER LINE >>>" + line);
                causeRejection = line.substring(33, 35);
                headerLine = line;
            }

            logger.logDebug("causeRejectionPrev: " + causeRejection);
            BatchResponse response = (BatchResponse) this.serviceExecutor.execute("Disbursement.ValidationService", new Object[]{fileName, headerLine}, new Class[]{String.class, String.class});
            logger.logInfo("Response service by BatchServiceExecutor [" + response + "]");
            logger.logInfo("Sending file to NEXT step");
            return new FlowExecutionStatus("NEXT");

        }

        logger.logError("Ending process files");
        return new FlowExecutionStatus("END");
    }
}
