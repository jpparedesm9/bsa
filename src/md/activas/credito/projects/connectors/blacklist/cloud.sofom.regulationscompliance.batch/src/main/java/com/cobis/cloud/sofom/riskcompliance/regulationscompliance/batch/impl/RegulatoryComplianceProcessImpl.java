package com.cobis.cloud.sofom.riskcompliance.regulationscompliance.batch.impl;

import cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto.RegulatoryComplianceResponseDTO;
import cobiscorp.ecobis.integrationengine.commons.Constants;
import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.service.TransactionExecuter;
import com.cobis.cloud.sofom.riskcompliance.regulationscompliance.batch.process.IRegulatoryComplianceProcess;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;

import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class RegulatoryComplianceProcessImpl extends TransactionExecuter implements IRegulatoryComplianceProcess {

    private static final String DATE_FILE_FORMAT = "yyyyMMdd";
    private ILogger logger = LogFactory.getLogger(RegulatoryComplianceProcessImpl.class);

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
        logger.logInfo("inicio a ejecutar el servicio RegulatoryComplianceProcessImpl");
        RegulatoryComplianceResponseDTO wBlackListResponse = (RegulatoryComplianceResponseDTO) mapaRes
                .get("RegulatoryCompliance");

        int returnCode = executeSPBlackList(context, wBlackListResponse);

        IEResponse response = new IEResponse();

        if (returnCode != 0) {
            response.setSuccess(true);
            response.setTransactionId(String.valueOf(returnCode));
        } else {
            String fileName = context.getProperties().get(Constants.PROPERTY_FILE_NAME);
            String rowNumberString = context.getProperties().get(Constants.PROPERTY_ROW_NUMBER);

            response.setTransactionId(rowNumberString);
            response.setSuccess(false);
            response.setErrorCode(returnCode);
            response.setErrorMessage("RegulatoryCompliance [" + fileName + "]");
            logger.logError(response.getErrorMessage());
        }

        logger.logInfo("Se termina de ejecutar el servicio RegulatoryComplianceProcessImpl");
        return response;
    }

    public int executeSPBlackList(IntegrationContext aContext, RegulatoryComplianceResponseDTO blackList) {
        CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
        Map<String, Object> wResultMap = null;
        Integer wInsertedId;
        Integer returnCode = -1;

        wSp.setDatabase("cob_credito");
        wSp.setName("sp_ilistas_negras");
        wSp.setSkipResultsProcessing(false);
        wSp.setSkipUndeclaredResults(false);

        cobisStoredProcedureUtils.setContextParameters(aContext.getContext(), Target.TARGET_CENTRAL, wSp);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_FILE_FORMAT);
        Date birthDate = null;

        try {
            birthDate = simpleDateFormat.parse(blackList.getBirthDate());

        } catch (ParseException e) {
            logger.logError(e);
        }

        wSp.addInParam("@i_operacion", Types.VARCHAR, "I");
        wSp.addInParam("@i_id_lista", Types.VARCHAR, blackList.getIdList());
        wSp.addInParam("@i_nombre", Types.VARCHAR, blackList.getName());
        wSp.addInParam("@i_apellido_paterno", Types.VARCHAR, blackList.getLastName());
        wSp.addInParam("@i_apellido_materno", Types.VARCHAR, blackList.getMotherLastName());
        wSp.addInParam("@i_curp", Types.VARCHAR, blackList.getCurp());
        wSp.addInParam("@i_rfc", Types.VARCHAR, blackList.getRfc());
        wSp.addInParam("@i_fecha_nac", Types.DATE, birthDate);
        wSp.addInParam("@i_tipo_lista", Types.VARCHAR, blackList.getListType());
        wSp.addInParam("@i_estado", Types.VARCHAR, blackList.getStatus());
        wSp.addInParam("@i_dependencia", Types.VARCHAR, blackList.getDependency());
        wSp.addInParam("@i_puesto", Types.VARCHAR, blackList.getPosition());
        wSp.addInParam("@i_iddispo", Types.VARCHAR, blackList.getIddispo());
        wSp.addInParam("@i_curp_ok", Types.VARCHAR, blackList.getCurpOk());
        wSp.addInParam("@i_id_rel", Types.VARCHAR, blackList.getIdRelation());
        wSp.addInParam("@i_parentesco", Types.VARCHAR, blackList.getRelationship());
        wSp.addInParam("@i_razon_social", Types.VARCHAR, blackList.getBusinessName());
        wSp.addInParam("@i_rfc_moral", Types.VARCHAR, blackList.getMoralRfc());
        wSp.addInParam("@i_num_seg_social", Types.VARCHAR, blackList.getSocialSecurityNumber());
        wSp.addInParam("@i_imss", Types.VARCHAR, blackList.getImss());
        wSp.addInParam("@i_ingresos", Types.VARCHAR, blackList.getIncomes());
        wSp.addInParam("@i_nom_completo", Types.VARCHAR, blackList.getLargeName());
        wSp.addInParam("@i_apellidos", Types.VARCHAR, blackList.getCompleteLastName());
        wSp.addInParam("@i_entidad", Types.VARCHAR, blackList.getEntity());
        wSp.addInParam("@i_sexo", Types.VARCHAR, blackList.getSex());
        wSp.addInParam("@i_area", Types.VARCHAR, blackList.getArea());
        wSp.addInOutParam("@o_id", Types.INTEGER, "0");

        if (logger.isInfoEnabled()) {
            logger.logInfo("Executing sp_ilistas_negras");
        }

        wResultMap = wSp.execute();
        wInsertedId = (Integer) wResultMap.get("@o_id");

        if (wResultMap.get("RETURNCODE") != null) {
            returnCode = (Integer) wResultMap.get("RETURNCODE");
        }

        if (logger.isDebugEnabled()) {
            logger.logDebug("Id Registro: " + wInsertedId);
            logger.logDebug("Codigo de retorno de sp: " + wResultMap.get("RETURNCODE"));
        }
        if (returnCode != 0) {
            return 0;
        } else {
            return wInsertedId;
        }

    }

}
