package com.cobis.cloud.sofom.riskcompliance.regulationscompliance.batch.generate;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto.RegulatoryComplianceResponseDTO;
import cobiscorp.ecobis.integrationengine.commons.dto.FileTransferTx;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;
import cobiscorp.ecobis.integrationengine.process.notification.IServicesIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.Target;

public class RegulatoryComplianceGenerateImpl implements IServicesIntegration {
	
	private ILogger logger = LogFactory
			.getLogger(RegulatoryComplianceGenerateImpl.class);
	private CobisStoredProcedureUtils cobisStoredProcedureUtils;

	public void setCobisStoredProcedureUtils(
			CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
	}

	public Object[] Query(HashMap<String, Object> request,
			Map<String, String> properties, IntegrationContext ctx)
			throws EngineFinalException {
		logger.logInfo("Se inició la consulta del servicio BlackListResponseGenerateImpl");
		return this.executeQuery(ctx);
	}

	public Object Insert(HashMap<String, Object> request, IntegrationContext ctx) {
		logger.logInfo("Se inició el insert del servicio BlackListResponseGenerateImpl");
		// TODO Ingresar el código de insert
		logger.logInfo("Se terminó el insert del servicio BlackListResponseGenerateImpl");
		return new Object();
	}

	public boolean Update(HashMap<String, Object> request,
			Map<String, String> properties, IntegrationContext ctx,
			boolean updateStatus) throws EngineFinalException {
		logger.logInfo("Se inició el update del servicio BlackListResponseGenerateImpl");
		// TODO Ingresar el código de update
		logger.logInfo("Se terminó el update del servicio BlackListResponseGenerateImpl");
		return true;
	}

	public HashMap<String, Object> getObjects(Object objectRequest) {
		logger.logInfo("Se inició el mapeo getObjects del servicio BlackListResponseGenerateImpl");
		HashMap<String, Object> objs = new HashMap<String, Object>();
		objs.put("BlackListResponse", (RegulatoryComplianceResponseDTO) objectRequest);
		return objs;
	}

	public HashMap<String, Object> getPreUpdateObjects(Object objectRequest,
			Object ctx, boolean updateStatus) throws EngineFinalException {
		logger.logInfo("Se inició el mapeo antes de update del servicio BlackListResponseGenerateImpl");
		// TODO Ingresar el código de mapeo antes del update
		logger.logInfo("Se terminó el mapeo antes de update  del servicio BlackListResponseGenerateImpl");
		return new HashMap<String, Object>();
	}

	public HashMap<String, Object> getPreInsertObjects(Object objectRequest) {
		logger.logInfo("Se inició el mapeo antes de insert del servicio BlackListResponseGenerateImpl");
		// TODO Ingresar el código de mapeo antes del insert
		logger.logInfo("Se terminó el mapeo antes de insert  del servicio BlackListResponseGenerateImpl");
		return new HashMap<String, Object>();
	}

	public HashMap<String, Object> getLastObject(
			HashMap<String, Object> request, Object objectRequest) {
		logger.logInfo("Se inició el mapeo antes del último registro del servicio ServicesTestGenerateImpl");
		// TODO Ingresar el código de mapeo del ultimo registro para paginacion
		logger.logInfo("Se terminó el mapeo antes del último registro  del servicio ServicesTestGenerateImpl");
		return new HashMap<String, Object>();
	}

	public FileTransferTx getFileTransferTx(
			FileTransferTx fileTransferTxRequest, Object objectRequest) {
		RegulatoryComplianceResponseDTO wBlackListResponse = (RegulatoryComplianceResponseDTO) objectRequest;
		fileTransferTxRequest.setTransactionId(wBlackListResponse.getId());
		return fileTransferTxRequest;
	}

	public RegulatoryComplianceResponseDTO[] executeQuery(IntegrationContext aContext) {
		CobisStoredProcedure wSp = cobisStoredProcedureUtils
				.getStoredProcedureInstance();

		wSp.setDatabase("cob_credito");
		wSp.setName("sp_ilistas_negras");
		wSp.setSkipResultsProcessing(false);
		wSp.setSkipUndeclaredResults(false);

		cobisStoredProcedureUtils.setContextParameters(aContext.getContext(),
				Target.TARGET_CENTRAL, wSp);

		//TODO: se deben añadir los parámetros de entrada y de salida de acuerdo al sp
		wSp.addInParam("@i_operacion", Types.CHAR, "A");

		if (logger.isInfoEnabled()) {
			logger.logInfo("Executing sp_ilistas_negras");
		}

		// Se define la forma de procesar los resultsets
		wSp.addResultSetMapper("list", new CobisRowMapper<RegulatoryComplianceResponseDTO>() {
			public RegulatoryComplianceResponseDTO mapRow(ResultSet aRs, int numRow)
					throws SQLException {
				RegulatoryComplianceResponseDTO wBlackListResponse = new RegulatoryComplianceResponseDTO();
				//TODO: añadir los parámetros de acuerdo al objeto y a la cabecera de la consulta
				wBlackListResponse.setIdList(aRs.getString("idList"));
				wBlackListResponse.setName(aRs.getString("name"));
				wBlackListResponse.setId(aRs.getInt("ID"));
				return wBlackListResponse;
			}
		});

		// Ejecucion del SP
		Map<String, Object> resultMap = wSp.execute();

		Integer returnCode = (Integer) resultMap.get("RETURNCODE");
		logger.logDebug("queryRatesByPayer returnCode:" + returnCode);
		if (returnCode == 0) {
			@SuppressWarnings("unchecked")
			List<RegulatoryComplianceResponseDTO> list = (List<RegulatoryComplianceResponseDTO>) resultMap.get("list");
			if (list == null || list.size() == 0) {
				return null;
			} else {
				return list.toArray(new RegulatoryComplianceResponseDTO[list.size()]);
			}
		}
		return null;

	}

}
