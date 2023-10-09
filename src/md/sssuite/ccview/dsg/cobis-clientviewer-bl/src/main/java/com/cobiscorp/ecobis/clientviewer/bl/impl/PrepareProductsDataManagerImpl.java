package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponseParam;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.bl.PrepareProductsDataManager;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;
import com.cobiscorp.ecobis.platform.utils.tools.FormatDate;

public class PrepareProductsDataManagerImpl implements PrepareProductsDataManager {

	public static final String DATABASE_NAME = "SYBCTS";

	private static ILogger logger = LogFactory.getLogger(PrepareProductsDataManagerImpl.class);

	CobisStoredProcedureUtils cobisStoredProcedureUtils;
	private ISPOrchestrator spOrchestrator;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.PrepareProductsDataManager#
	 * prepareProductsData(java.lang.Integer, java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<String> prepareProductsData(Integer clientId, Integer groupId, String dateFormat) {
		try {
			// String dateFormat = "dd/MM/yyyy";
			FormatDate formatter = new FormatDate();
			List<String> listIds = new ArrayList<String>();

			logger.logDebug(MessageManager.getString("PREPAREPRODUCTSDATAMANAGER.001", "prepareProductsData"));

			IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
			wProcedureRequest.addFieldInHeader("isFormatterEnabled", ICOBISTS.HEADER_STRING_TYPE, "false");
			wProcedureRequest.addFieldInHeader("SPExecutorServiceFactoryFilter", ICOBISTS.HEADER_STRING_TYPE, "(service.impl=object)");

			Context wContext = ContextManager.getContext();
			if (logger.isTraceEnabled()) {
				logger.logTrace("context to use:" + wContext);
			}

			CobisSession wSession = (CobisSession) wContext.getSession();

			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getSession().getSessionId());
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_CONTEXT_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getContextId());
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_BACK_END_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getSession().getBackEndId());
			wProcedureRequest.setSpName("cob_workflow..sp_bp_products");
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "central");

			// Add parameters of business
			logger.logDebug("formatter.getDateFormatter(dateFormat)" + formatter.getDateFormatter(dateFormat));
			wProcedureRequest.addInputParam("@i_operacion", ICTSTypes.SQLVARCHAR, "I");
			wProcedureRequest.addInputParam("@i_cliente", ICTSTypes.SQLINT4, clientId == 0 ? null : String.valueOf(clientId));
			wProcedureRequest.addInputParam("@i_grupo", ICTSTypes.SQLINT4, groupId == 0 ? null : String.valueOf(groupId));
			wProcedureRequest.addInputParam("@i_vista_360", ICTSTypes.SQLCHAR, "S");
			wProcedureRequest.addInputParam("@i_act_can", ICTSTypes.SQLCHAR, "N");

			wProcedureRequest.addInputParam("@i_formato_fecha", ICTSTypes.SQLINT4, String.valueOf(formatter.getDateFormatter(dateFormat)));
			// Define as return the ResultSet

			wProcedureRequest.addInputParam("@s_sesn", ICTSTypes.SQLINT4, wContext.getSequencial());
			wProcedureRequest.addInputParam("@s_ssn", ICTSTypes.SQLINT4, wContext.getSequencial());

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(wProcedureRequest, null, null);

			logger.logDebug("<<<<<<<<<< wProcedureResponseAS prepareProductsData >>>>>>>>>> " + wProcedureResponseAS);

			if (wProcedureResponseAS != null) {
				wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

				IResultSetBlock resulSetBlock = wProcedureResponseAS.getResultSet(1);// 1

				if (resulSetBlock != null) {
					logger.logDebug("------prepareProductsData RESULTSET 0---->" + resulSetBlock.toString());
					IResultSetData resultSetData = resulSetBlock.getData();
					logger.logDebug("------prepareProductsData RESULTSETDATA---->" + resulSetBlock.getData());
					logger.logDebug("------prepareProductsData NUMERO DE REGISTROS---->" + resultSetData.getRowsNumber());

					logger.logDebug("prepareProductsData SPID" + resultSetData.getRow(1).getRowData(1).getValue());
					logger.logDebug("prepareProductsData SESN" + resultSetData.getRow(1).getRowData(2).getValue());

					listIds.add(String.valueOf(resultSetData.getRow(1).getRowData(1).getValue()));
					listIds.add(String.valueOf(resultSetData.getRow(1).getRowData(2).getValue()));
				}
			}

			return listIds;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PREPAREPRODUCTSDATAMANAGER.003"), ex);
			throw new BusinessException(7300024, "An error occurred at getting the product data.");
		} finally {
			logger.logDebug(MessageManager.getString("PREPAREPRODUCTSDATAMANAGER.002", "prepareProductsData"));
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.PrepareProductsDataManager#
	 * prepareProductsData(java.lang.Integer, java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<String> prepareProductsDataHistory(Integer clientId, Integer groupId, String dateFormat) {
		try {
			FormatDate formatter = new FormatDate();
			logger.logDebug(MessageManager.getString("PREPAREPRODUCTSDATAMANAGER.001", "prepareProductsDataHistory"));

			// Method for search item
			CobisStoredProcedure storedProcedure = this.cobisStoredProcedureUtils.getStoredProcedureInstance(DATABASE_NAME);
			storedProcedure.setDatabase("cob_workflow");
			storedProcedure.setName("sp_bp_products");
			storedProcedure.setSkipUndeclaredResults(true);

			this.cobisStoredProcedureUtils.setContextParameters(DATABASE_NAME, storedProcedure);
			logger.logDebug("formatter.getDateFormatter(dateFormat)" + formatter.getDateFormatter(dateFormat));

			// Add parameters of business
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "I");
			storedProcedure.addInParam("@i_cliente", Types.INTEGER, clientId);
			storedProcedure.addInParam("@i_grupo", Types.INTEGER, groupId);
			storedProcedure.addInParam("@i_vista_360", Types.CHAR, "S");
			storedProcedure.addInParam("@i_act_can", Types.CHAR, "S");
			storedProcedure.addInParam("@i_formato_fecha", Types.INTEGER, formatter.getDateFormatter(dateFormat));

			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("IDS", new CobisRowMapper<Map<String, String>>() {
				public Map<String, String> mapRow(ResultSet rs, int rowNum) throws SQLException {
					Map<String, String> ids = new HashMap<String, String>();
					ids.put("SPID", rs.getString("SPID"));
					ids.put("SESN", rs.getString("SESN"));
					return ids;
				}
			});

			Map<String, Object> resultMap = storedProcedure.execute();

			List<String> listIds = new ArrayList<String>();
			listIds.add(((Map<String, String>) ((List<Map<String, String>>) resultMap.get("IDS")).get(0)).get("SPID"));
			listIds.add(((Map<String, String>) ((List<Map<String, String>>) resultMap.get("IDS")).get(0)).get("SESN"));

			return listIds;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PREPAREPRODUCTSDATAMANAGER.003"), ex);
			throw new BusinessException(7300025, "An error occurred at getting product data history.");
		} finally {
			logger.logDebug(MessageManager.getString("PREPAREPRODUCTSDATAMANAGER.002", "prepareProductsDataHistory"));
		}

	}

	public CobisStoredProcedureUtils getCobisStoredProcedureUtils() {
		return cobisStoredProcedureUtils;
	}

	public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
