package com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.generate;

import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.FileTransferTx;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.notification.IServicesIntegration;
import com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.dto.DirectDebitMandateRequest;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DirectDebitMandateRequestImpl implements IServicesIntegration {

    private ILogger logger = LogFactory
            .getLogger(DirectDebitMandateRequestImpl.class);
    private CobisStoredProcedureUtils cobisStoredProcedureUtils;

    public void setCobisStoredProcedureUtils(
            CobisStoredProcedureUtils cobisStoredProcedureUtils) {
        this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
    }

    public Object[] Query(HashMap<String, Object> request,
                          Map<String, String> properties, IntegrationContext ctx)
            throws EngineFinalException {
        logger.logInfo("Se inició la consulta del servicio DirectDebitMandateRequestImpl");
        return this.executeQuery(ctx);
    }

    public Object Insert(HashMap<String, Object> request, IntegrationContext ctx) {
        logger.logInfo("Se inició el insert del servicio DirectDebitMandateRequestImpl");

        logger.logInfo("Se terminó el insert del servicio DirectDebitMandateRequestImpl");
        return new Object();
    }

    public boolean Update(HashMap<String, Object> request,
                          Map<String, String> properties, IntegrationContext ctx,
                          boolean updateStatus) throws EngineFinalException {
        logger.logInfo("Se inició el update del servicio DirectDebitMandateRequestImpl");

        logger.logInfo("Se terminó el update del servicio DirectDebitMandateRequestImpl");
        return true;
    }

    public HashMap<String, Object> getObjects(Object objectRequest) {
        logger.logInfo("Se inició el mapeo getObjects del servicio DirectDebitMandateRequestImpl");
        HashMap<String, Object> objs = new HashMap<String, Object>();
        objs.put("DirectDebitMandate", (DirectDebitMandateRequest) objectRequest);
        return objs;
    }

    public HashMap<String, Object> getPreUpdateObjects(Object objectRequest,
                                                       Object ctx, boolean updateStatus) throws EngineFinalException {
        logger.logInfo("Se inició el mapeo antes de update del servicio DirectDebitMandateRequestImpl");

        logger.logInfo("Se terminó el mapeo antes de update  del servicio DirectDebitMandateRequestImpl");
        return new HashMap<String, Object>();
    }

    public HashMap<String, Object> getPreInsertObjects(Object objectRequest) {
        logger.logInfo("Se inició el mapeo antes de insert del servicio DirectDebitMandateRequestImpl");

        logger.logInfo("Se terminó el mapeo antes de insert  del servicio DirectDebitMandateRequestImpl");
        return new HashMap<String, Object>();
    }

    public HashMap<String, Object> getLastObject(
            HashMap<String, Object> request, Object objectRequest) {
        logger.logInfo("Se inició el mapeo antes del último registro del servicio ServicesTestGenerateImpl");

        logger.logInfo("Se terminó el mapeo antes del último registro  del servicio ServicesTestGenerateImpl");
        return new HashMap<String, Object>();
    }

    public FileTransferTx getFileTransferTx(
            FileTransferTx fileTransferTxRequest, Object objectRequest) {
        DirectDebitMandateRequest wDirectDebitMandate = (DirectDebitMandateRequest) objectRequest;
        fileTransferTxRequest.setTransactionId(Integer.parseInt("0"));
        return fileTransferTxRequest;
    }

    public DirectDebitMandateRequest[] executeQuery(IntegrationContext aContext) {
        CobisStoredProcedure wSp = cobisStoredProcedureUtils
                .getStoredProcedureInstance();

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_santander_gen_orden_ret");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_santander_gen_orden_ret");
        }

        // Se define la forma de procesar los resultsets
        wSp.addResultSetMapper("list", new CobisRowMapper<DirectDebitMandateRequest>() {
            public DirectDebitMandateRequest mapRow(ResultSet aRs, int numRow)
                    throws SQLException {
                DirectDebitMandateRequest wDirectDebitMandate = new DirectDebitMandateRequest();
                wDirectDebitMandate.setDetail(aRs.getString("linea_dato"));
                return wDirectDebitMandate;
            }
        });

        // Ejecucion del SP
        Map<String, Object> resultMap = wSp.execute();

        Integer returnCode = (Integer) resultMap.get("RETURNCODE");
        logger.logDebug("executeQuery returnCode:" + returnCode);
        if (returnCode == 0) {
            @SuppressWarnings("unchecked")
            List<DirectDebitMandateRequest> list = (List<DirectDebitMandateRequest>) resultMap.get("list");
            if (list == null || list.size() == 0) {
                return null;
            } else {
                logger.logDebug("list.size:" + list.size());
                logger.logDebug("list:" + list.toString());
                return list.toArray(new DirectDebitMandateRequest[list.size()]);
            }
        }
        return null;

    }

}
