package com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.process.impl;

import cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto.DirectDebitMandateResponse;
import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.service.TransactionExecuter;
import com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.process.IDirectDebitMandateProcess;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.Map;


public class DirectDebitMandateProcessImpl extends TransactionExecuter implements IDirectDebitMandateProcess {
    private ILogger logger = LogFactory.getLogger(DirectDebitMandateProcessImpl.class);
    private static final String className = "[DirectDebitMandateProcessImpl]";

    private CobisStoredProcedureUtils cobisStoredProcedureUtils;

    /**
     * Sets the parameter cobisStoredProcedureUtils
     *
     * @param cobisStoredProcedureUtils
     */
    public void setCobisStoredProcedureUtils(
            CobisStoredProcedureUtils cobisStoredProcedureUtils) {
        this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
    }

    /**
     * Sets the parameter databaseName
     *
     * @param databaseName
     */
    public void setDatabaseName(String databaseName) {
    }

    /**
     *
     */
    public IEResponse execute(IntegrationContext context,
                              Map<String, Object> mapaRes) throws EngineFinalException {
        if (logger.isInfoEnabled()) {
            logger.logInfo(className + "Se empezó a ejecutar el servicio DirectDebitMandateProcessImpl");
        }

        DirectDebitMandateResponse wDirectDebitMandate = (DirectDebitMandateResponse) mapaRes.get("DirectDebitMandate");

        String fileName = context.getProperties().get(Constants.PROPERTY_FILE_NAME);
        String rowNumberString = context.getProperties().get(Constants.PROPERTY_ROW_NUMBER);
        String errorMessage = "Error on file [" + fileName + "] on row [" + rowNumberString + "]";

        if (logger.isInfoEnabled()) {
            logger.logInfo("File [" + fileName + "] on row [" + rowNumberString + "]");
            logger.logInfo("wDirectDebitMandate: " + wDirectDebitMandate.toString());
        }

        IEResponse response = new IEResponse();
        response.setSuccess(false);

        try {
            int returnCode = processDirectDebit(context, wDirectDebitMandate);

            if (returnCode == 0) {
                response.setSuccess(true);
            }
        } catch (Exception e) {
            logger.logError(errorMessage, e);
            response.setErrorMessage(e.toString());
        }

        if (logger.isInfoEnabled()) {
            logger.logInfo("Se terminó de ejecutar el servicio DirectDebitMandateProcessImpl");
        }

        return response;
    }

    private int processDirectDebit(IntegrationContext integrationContext, DirectDebitMandateResponse directDebitMandateResponse) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "Transaction Type [COBRO] (processDirectDebit)");
        }

        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap;

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_santander_ing_log_pagos");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(integrationContext.getContext(), Target.TARGET_CENTRAL, wSp);

        String amountFile = directDebitMandateResponse.getAmount();
        BigDecimal amount = new BigDecimal(amountFile.substring(0, 13) + "." + amountFile.substring(13, 15));

        wSp.addInParam("@i_secuencial", Types.INTEGER, Integer.parseInt(directDebitMandateResponse.getSequenceNumber()));
        wSp.addInParam("@i_fecha_gen_orden", Types.VARCHAR, directDebitMandateResponse.getCollectionDate());
        wSp.addInParam("@i_referencia_banco", Types.VARCHAR, directDebitMandateResponse.getServiceReference().trim());
        wSp.addInParam("@i_cuenta", Types.VARCHAR, directDebitMandateResponse.getCustomerAccountNumber());
        wSp.addInParam("@i_monto_pago ", Types.DECIMAL, amount);
        wSp.addInParam("@i_referencia", Types.VARCHAR, directDebitMandateResponse.getReferenceLegend());
        wSp.addInParam("@i_archivo", Types.VARCHAR, integrationContext.getProperties().get(Constants.PROPERTY_FILE_NAME));
        wSp.addInParam("@i_corresponsal", Types.VARCHAR, "SANTANDER");
        wSp.addInParam("@i_resultado", Types.VARCHAR, directDebitMandateResponse.getResult());

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_santander_ing_log_pagos");
        }

        wResultMap = wSp.execute();

        int returnCode = Integer.parseInt(wResultMap.get("RETURNCODE").toString());

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: " + returnCode);
        }

        if (returnCode == 0) {
            returnCode = Integer.parseInt(directDebitMandateResponse.getResult());
        }

        return returnCode;
    }

}
