package com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.process.impl;

import cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto.DisbursementResponse;
import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.service.TransactionExecuter;
import com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.process.IDisbursementCheckProcess;
import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;

import java.sql.Types;
import java.util.Map;

public class DisbursementCheckProcessImpl extends TransactionExecuter implements IDisbursementCheckProcess {
    private ILogger logger = LogFactory.getLogger(DisbursementCheckProcessImpl.class);

    private ICacheManager cacheManager;

    public void setCacheManager(ICacheManager aCacheManager) {
        this.cacheManager = aCacheManager;
    }

    public ICacheManager getCacheManager() {
        return this.cacheManager;
    }

    private CobisStoredProcedureUtils cobisStoredProcedureUtils;

    /**
     * Sets the parameter cobisStoredProcedureUtils
     *
     * @param cobisStoredProcedureUtils
     */
    public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
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

    public IEResponse execute(IntegrationContext context, Map<String, Object> mapaRes) throws EngineFinalException {

        if (logger.isDebugEnabled()) {
            logger.logDebug("Entra a DisbursementCheckProcessImpl");

            logger.logDebug("context.getContext(): " + context.getContext().getContextId());
            logger.logDebug("getEntity: " + context.getEntity());
            logger.logDebug("getProperties: " + context.getProperties());
            logger.logDebug("getAplication: " + context.getAplication());
            logger.logDebug("mapaRes" + mapaRes);
        }

        logger.logInfo("Se empezó a ejecutar el servicio DisbursementCheckProcessImpl");
        DisbursementResponse wDisbursement = (DisbursementResponse) mapaRes.get("Disbursement");

        String fileName = context.getProperties().get(Constants.PROPERTY_FILE_NAME);
        String rowNumberString = context.getProperties().get(Constants.PROPERTY_ROW_NUMBER);

        IEResponse response = new IEResponse();

        logger.logInfo("File [" + fileName + "] on row [" + rowNumberString + "]");
        logger.logInfo("wDisbursement: " + wDisbursement.toString());

        String returnCode = "";
        try {
            returnCode = executeSpDisbursement(context, wDisbursement, mapaRes);
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

    private String executeSpDisbursement(IntegrationContext aContext, DisbursementResponse aDisbursement,
                                         Map<String, Object> mapaRes) {

        String fileName = aContext.getProperties().get(Constants.PROPERTY_FILE_NAME);
        if (logger.isDebugEnabled()) {
            logger.logDebug("fileName: " + fileName);
        }

        String causeRejection = getCauseRejection(aContext, fileName, mapaRes);
        if (logger.isDebugEnabled()) {
            logger.logDebug("causeRejection: " + causeRejection);
            logger.logInfo("Transaction Type [DSMBLCK]");
        }
        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap = null;

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_ingresar_resultado_desembolso");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        wSp.addInParam("@i_operacion", Types.VARCHAR, "I");
        wSp.addInParam("@i_rd_nombre_archivo", Types.VARCHAR, fileName);
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
        String causa_rechazo = !causeRejection.equals("00") ? causeRejection : aDisbursement.getRefundReason();
        wSp.addInParam("@i_rd_causa_rechazo", Types.VARCHAR, causa_rechazo);
        wSp.addInParam("@i_rd_descripcion_referencia", Types.VARCHAR, aDisbursement.getPaymentReferenceDescription());

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_ingresar_resultado_desembolso");
        }

        wResultMap = wSp.execute();
        int returncode = Integer.parseInt(wResultMap.get("RETURNCODE").toString());

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
        }

        if (returncode != 0)
            return String.valueOf(returncode);
        else
            return causa_rechazo;

    }

    private String getCauseRejection(IntegrationContext context, String fileName, Map<String, Object> mapRes) {
        ICache wCache = cacheManager.getCache("DisbursementCheckInfo");
        if (wCache == null) {
            throw new IllegalStateException("Cache with DisbursementCheckInfo should be configured in $COBIS_HOME/CTS_MF/services-as/cache/cts-cache.xml");
        }

        if (!wCache.isKeyInCache(fileName)) {
            CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
            Map<String, Object> wResultMap = null;

            wSp.setDatabase("cob_credito");
            wSp.setName("sp_desembolso_chequeo");
            wSp.setSkipResultsProcessing(false);
            wSp.setSkipUndeclaredResults(false);

            cobisStoredProcedureUtils.setContextParameters(context.getContext(), Target.TARGET_CENTRAL, wSp);

            if (logger.isDebugEnabled()) {
                logger.logDebug("wSp: " + wSp);
                logger.logDebug("Entra a setear parametros sp");
            }
            wSp.addInParam("@i_nombre_documento", Types.VARCHAR, fileName);
            wSp.addInParam("@i_operacion", Types.VARCHAR, "Q");
            wSp.addInOutParam("@o_causa_rechazo", Types.VARCHAR, "00");
            wResultMap = wSp.execute();

            if (logger.isDebugEnabled()) {
                logger.logDebug("Codigo de retorno de sp consulta: " + wResultMap.get("RETURNCODE"));
            }
            String returncode = wResultMap.get("RETURNCODE").toString();

            String causeRejection;
            if (!returncode.contentEquals("0")) {
                causeRejection = "XX";
                logger.logError("No fue posible obtener resultado de chequeo de archivo de Desembolso");
            } else {
                causeRejection = wResultMap.get("@o_causa_rechazo").toString();
                if (logger.isDebugEnabled()) {
                    logger.logDebug("@o_causa_rechazo: " + causeRejection);
                }
            }

            wCache.put(fileName, causeRejection);
        }

        return wCache.get(fileName).toString();
    }

}
