package com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.process.impl;

import cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto.DisbursementResponse;
import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.service.TransactionExecuter;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.process.IDisbursementProcess;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;

import java.sql.Types;
import java.util.Map;


public class DisbursementProcessImpl extends TransactionExecuter implements IDisbursementProcess {

    private ILogger logger = LogFactory.getLogger(DisbursementProcessImpl.class);

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
        logger.logInfo("Se empezó a ejecutar el servicio DisbursementProcessImpl");
        DisbursementResponse wDisbursement = (DisbursementResponse) mapaRes.get("Disbursement");

        String fileName = context.getProperties().get(Constants.PROPERTY_FILE_NAME);
        String rowNumberString = context.getProperties().get(Constants.PROPERTY_ROW_NUMBER);

        IEResponse response = new IEResponse();

        logger.logInfo("File [" + fileName + "] on row [" + rowNumberString + "]");
        logger.logInfo("wDisbursement: " + wDisbursement.toString());

        String returnCode = "";
        try {
            returnCode = executeSpDisbursement(context, wDisbursement);
        } catch (Exception e) {
            response.setSuccess(false);
            logger.logError("Error on file [" + fileName + "] on row [" + rowNumberString + "]", e);
        }

        if (returnCode.equals("00")) {
            response.setSuccess(true);
        }

        logger.logInfo("Se terminó de ejecutar el servicio DisbursementProcessImpl");
        return response;
    }

    public String executeSpDisbursement(IntegrationContext aContext,
                                        DisbursementResponse aDisbursement) {
        logger.logInfo("Transaction Type [DSMBL]");
        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap = null;
        int wInsertedId = -1;

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_ingresar_resultado_desembolso");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        String fileName = aContext.getProperties().get(Constants.PROPERTY_FILE_NAME);
        wSp.addInParam("@i_operacion", Types.VARCHAR, "U");
        if (logger.isInfoEnabled()) {
            logger.logInfo("File Name" + fileName.replaceAll(".98.out", ".out"));
        }
        wSp.addInParam("@i_rd_nombre_archivo", Types.VARCHAR, fileName.replaceAll(".98.out", ".out"));
        wSp.addInParam("@i_rd_secuencial", Types.VARCHAR, aDisbursement.getSequenceNumber());
        wSp.addInParam("@i_rd_fecha_transferencia", Types.VARCHAR, aDisbursement.getTransferDate());
        wSp.addInParam("@i_rd_monto", Types.VARCHAR, aDisbursement.getAmount());
        wSp.addInParam("@i_rd_cuenta_ordenante", Types.VARCHAR, aDisbursement.getPayerAccountNumber());
        wSp.addInParam("@i_rd_nombre_ordenante", Types.VARCHAR, aDisbursement.getPayerName());
        wSp.addInParam("@i_rd_rfc_ordenante", Types.VARCHAR, aDisbursement.getPayerRFC());
        wSp.addInParam("@i_rd_cuenta_beneficiario", Types.VARCHAR, aDisbursement.getPayeeAccountNumber());
        wSp.addInParam("@i_rd_nombre_beneficiario", Types.VARCHAR, aDisbursement.getPayeeName());
        wSp.addInParam("@i_rd_rfc_beneficiario", Types.VARCHAR, aDisbursement.getPayeeRFC());
        wSp.addInParam("@i_rd_referencia_servicio", Types.VARCHAR, aDisbursement.getServiceReference());
        wSp.addInParam("@i_rd_referencia_ordenante", Types.VARCHAR, aDisbursement.getPayerReferenceLegend());
        wSp.addInParam("@i_rd_motivo_devolucion", Types.VARCHAR, aDisbursement.getRefundReason());
        wSp.addInParam("@i_rd_descripcion_referencia", Types.VARCHAR, aDisbursement.getPaymentReferenceDescription());

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_ingresar_resultado_desembolso");
        }

        wResultMap = wSp.execute();
        int returncode = Integer.parseInt(wResultMap.get("RETURNCODE").toString());

        logger.logDebug("Codigo de retorno de sp: "
                + wResultMap.get("RETURNCODE"));

        if (returncode != 0)
            return String.valueOf(returncode);
        else
            return aDisbursement.getRefundReason();
    }
}
