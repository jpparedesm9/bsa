package com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.tasklet;

import cobiscorp.ecobis.integrationengine.commons.dto.BatchResponse;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineProcessRowException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.Target;

import java.sql.Types;
import java.util.Map;

public class ValidationService implements IValidation {
    private ILogger logger = LogFactory.getLogger(ValidationService.class);

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

    public BatchResponse execute(Context context, String fileName,
                                 String header)
            throws EngineProcessRowException {

        String line = header;
        if (line.equals(null)) {
            throw new EngineProcessRowException(
                    "Error, no se pudo obtener la cabercera del archivo");
        }

        String typeRegister = line.substring(0, 2);
        String sequenceNumber = line.substring(2, 9);
        String operationCode = line.substring(9, 11);
        String bankNumber = line.substring(11, 14);
        String sense = line.substring(14, 15);
        String service = line.substring(15, 16);
        String blockNumber = line.substring(16, 23);
        String presentationDate = line.substring(23, 31);
        String badgeCode = line.substring(31, 33);
        String causeRejection = line.substring(33, 35);
        String modality = line.substring(35, 36);
        String operation = "I";//Modo para la insercion del registro

        if (logger.isTraceEnabled()) {
            logger.logTrace("typeRegister: " + typeRegister);
            logger.logTrace("sequenceNumber: " + sequenceNumber);
            logger.logTrace("operationCode: " + operationCode);
            logger.logTrace("bankNumber: " + bankNumber);
            logger.logTrace("sense: " + sense);
            logger.logTrace("service: " + service);
            logger.logTrace("blockNumber: " + blockNumber);
            logger.logTrace("presentationDate: " + presentationDate);
            logger.logTrace("badgeCode: " + badgeCode);
            logger.logTrace("causeRejection: " + causeRejection);
            logger.logTrace("modality: " + modality);
        }

        logger.logInfo("Transaction Type [DSMBLCK]");
        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap = null;
        int wInsertedId = -1;

        wSp.setDatabase("cob_credito");
        wSp.setName("sp_desembolso_chequeo");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(context, Target.TARGET_CENTRAL, wSp);

        if (logger.isDebugEnabled()) {
            logger.logDebug("wSp: " + wSp);
            logger.logDebug("Entra a setear parametros sp");
        }

        wSp.addInParam("@i_nombre_documento", Types.VARCHAR, fileName);
        wSp.addInParam("@i_tipo_registro", Types.VARCHAR, typeRegister);
        wSp.addInParam("@i_num_secuencia", Types.VARCHAR, sequenceNumber);
        wSp.addInParam("@i_cod_operacion", Types.VARCHAR, operationCode);
        wSp.addInParam("@i_num_banco", Types.VARCHAR, bankNumber);
        wSp.addInParam("@i_sentido", Types.VARCHAR, sense);
        wSp.addInParam("@i_servicio", Types.VARCHAR, service);
        wSp.addInParam("@i_num_bloque", Types.VARCHAR, blockNumber);
        wSp.addInParam("@i_fecha_presentacion", Types.VARCHAR, presentationDate);
        wSp.addInParam("@i_cod_divisa", Types.VARCHAR, badgeCode);
        wSp.addInParam("@i_causa_rechazo", Types.VARCHAR, causeRejection);
        wSp.addInParam("@i_modalidad", Types.VARCHAR, modality);
        wSp.addInParam("@i_operacion", Types.VARCHAR, operation);

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_desembolso_chequeo");
        }

        wResultMap = wSp.execute();
        int returncode = Integer.parseInt(wResultMap.get("RETURNCODE").toString());

        if (logger.isDebugEnabled()) {
            logger.logDebug("Codigo de retorno de sp: "
                    + wResultMap.get("RETURNCODE"));
        }

        BatchResponse batchResponse = new BatchResponse();
        batchResponse.setSuccess(returncode == 0);

        return batchResponse;
    }
}
