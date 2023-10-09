package com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.generate;

import cobiscorp.ecobis.integrationengine.commons.dto.FileTransferTx;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.notification.IServicesIntegration;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto.DisbursementHeaderRequest;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto.DisbursementRequest;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto.DisbursementSummaryRequest;
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

public class DisbursementRequestImpl implements IServicesIntegration {

    private IntegrationContext integrationContext;

    private ILogger logger = LogFactory
            .getLogger(DisbursementRequestImpl.class);
    private CobisStoredProcedureUtils cobisStoredProcedureUtils;

    public void setCobisStoredProcedureUtils(
            CobisStoredProcedureUtils cobisStoredProcedureUtils) {
        this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
    }

    public Object[] Query(HashMap<String, Object> request,
                          Map<String, String> properties, IntegrationContext ctx)
            throws EngineFinalException {
        logger.logInfo("Se inició la consulta del servicio DisbursementRequestImpl");
        this.integrationContext = ctx;
        return this.executeQuery(ctx);
    }

    public Object Insert(HashMap<String, Object> request, IntegrationContext ctx) {
        logger.logInfo("Se inició el insert del servicio DisbursementRequestImpl");
        // TODO Ingresar el código de insert
        logger.logInfo("Se terminó el insert del servicio DisbursementRequestImpl");
        return new Object();
    }

    public boolean Update(HashMap<String, Object> request,
                          Map<String, String> properties, IntegrationContext ctx,
                          boolean updateStatus) throws EngineFinalException {
        logger.logInfo("Se inició el update del servicio DisbursementRequestImpl");
        // TODO Ingresar el código de update
        logger.logInfo("Se terminó el update del servicio DisbursementRequestImpl");
        return true;
    }

    public HashMap<String, Object> getObjects(Object objectRequest) {
        logger.logInfo("Se inició el mapeo getObjects del servicio DisbursementRequestImpl");
        HashMap<String, Object> objs = new HashMap<String, Object>();

        DisbursementHeaderRequest disbursementHeaderRequest = new DisbursementHeaderRequest(integrationContext.getProperties().get("DisbursementHeaderInformation"));
        DisbursementSummaryRequest disbursementSummaryRequest = new DisbursementSummaryRequest(integrationContext.getProperties().get("DisbursementSummaryInformation"));

        objs.put("DisbursementHeader", disbursementHeaderRequest);
        objs.put("Disbursement", (DisbursementRequest) objectRequest);
        objs.put("DisbursementSummary", disbursementSummaryRequest);

        return objs;
    }

    public HashMap<String, Object> getPreUpdateObjects(Object objectRequest,
                                                       Object ctx, boolean updateStatus) throws EngineFinalException {
        logger.logInfo("Se inició el mapeo antes de update del servicio DisbursementRequestImpl");
        // TODO Ingresar el código de mapeo antes del update
        logger.logInfo("Se terminó el mapeo antes de update  del servicio DisbursementRequestImpl");
        return new HashMap<String, Object>();
    }

    public HashMap<String, Object> getPreInsertObjects(Object objectRequest) {
        logger.logInfo("Se inició el mapeo antes de insert del servicio DisbursementRequestImpl");
        // TODO Ingresar el código de mapeo antes del insert
        logger.logInfo("Se terminó el mapeo antes de insert  del servicio DisbursementRequestImpl");
        return new HashMap<String, Object>();
    }

    public HashMap<String, Object> getLastObject(
            HashMap<String, Object> request, Object objectRequest) {
        logger.logInfo("Se inició el mapeo antes del último registro del servicio DisbursementRequestImpl");
        // TODO Ingresar el código de mapeo del ultimo registro para paginacion
        logger.logInfo("Se terminó el mapeo antes del último registro  del servicio DisbursementRequestImpl");
        return new HashMap<String, Object>();
    }

    public FileTransferTx getFileTransferTx(
            FileTransferTx fileTransferTxRequest, Object objectRequest) {
        DisbursementRequest wDisbursement = (DisbursementRequest) objectRequest;
        fileTransferTxRequest.setTransactionId(Integer.parseInt("0"));
        return fileTransferTxRequest;
    }

    public DisbursementRequest[] executeQuery(IntegrationContext aContext) {
        CobisStoredProcedure wSp = cobisStoredProcedureUtils
                .getStoredProcedureInstance();

        wSp.setDatabase("cob_cartera");
        wSp.setName("sp_santander_gen_orden_dep");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_santander_gen_orden_dep");
        }

        // Se define la forma de procesar los resultsets
        wSp.addResultSetMapper("list", new CobisRowMapper<DisbursementRequest>() {
            public DisbursementRequest mapRow(ResultSet aRs, int numRow)
                    throws SQLException {
                DisbursementRequest wDisbursement = new DisbursementRequest();
                wDisbursement.setDetail(aRs.getString("linea_dato"));
                return wDisbursement;
            }
        });

        // Ejecucion del SP
        Map<String, Object> resultMap = wSp.execute();

        Integer returnCode = (Integer) resultMap.get("RETURNCODE");
        logger.logDebug("executeQuery returnCode:" + returnCode);
        if (returnCode == 0) {
            @SuppressWarnings("unchecked")
            List<DisbursementRequest> list = (List<DisbursementRequest>) resultMap.get("list");

            if (list == null || list.size() == 0) {
                return null;
            } else {
                aContext.getProperties().put("DisbursementHeaderInformation", list.get(0).getDetail());
                aContext.getProperties().put("DisbursementSummaryInformation", list.get(list.size() - 1).getDetail());

                logger.logDebug("list.size antes:" + list.size());

                list.remove(list.size() - 1);
                list.remove(0);

                logger.logDebug("list.size despues:" + list.size());
                logger.logDebug("list:" + list.toString());
                return list.toArray(new DisbursementRequest[list.size()]);
            }
        }
        return null;

    }

}
