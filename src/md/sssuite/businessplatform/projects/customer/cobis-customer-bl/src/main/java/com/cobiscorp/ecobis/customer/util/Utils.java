package com.cobiscorp.ecobis.customer.util;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;

public class Utils {
	private static ILogger logger = LogFactory.getLogger(Utils.class);

	public static IProcedureRequest setHeaderParams(IProcedureRequest wProcedureRequest) {

		Context wContext = ContextManager.getContext();

		if (logger.isTraceEnabled()) {
			logger.logTrace("context to use:" + wContext);
		}
		if (wProcedureRequest != null) {
			wProcedureRequest.addFieldInHeader("isFormatterEnabled", ICOBISTS.HEADER_STRING_TYPE, "false");
			wProcedureRequest.addFieldInHeader("SPExecutorServiceFactoryFilter", ICOBISTS.HEADER_STRING_TYPE, "(service.impl=transactional)");
			CobisSession wSession = (CobisSession) wContext.getSession();
			if (wSession == null) {
				return null;
			} else {
				wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getSession().getSessionId());
				wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_CONTEXT_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getContextId());
				wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_BACK_END_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getSession().getBackEndId());
				wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "central");

				wProcedureRequest.addInputParam("@s_srv", ICTSTypes.SQLVARCHAR, wSession.getServer()); // "wSrv"
				wProcedureRequest.addInputParam("@s_lsrv", ICTSTypes.SQLVARCHAR, wSession.getServer()); // "wSrv"
				wProcedureRequest.addInputParam("@s_user ", ICTSTypes.SQLVARCHAR, wSession.getUser()); // "wUser"
				wProcedureRequest.addInputParam("@s_term", ICTSTypes.SQLVARCHAR, wSession.getTerminal()); // "wTerm"
				wProcedureRequest.addInputParam("@s_date", ICTSTypes.SQLDATETIME, wContext.getProcessDate()); // wDate
				wProcedureRequest.addInputParam("@s_sesn", ICTSTypes.SQLINT4, wContext.getSequencial()); // Integer.toString(sequentialTransaction)
				wProcedureRequest.addInputParam("@s_ssn", ICTSTypes.SQLINT4, wContext.getSequencial()); // Integer.toString(sequentialTransaction)
				wProcedureRequest.addInputParam("@s_ofi", ICTSTypes.SQLINT4, wSession.getOffice()); // "1"
				wProcedureRequest.addInputParam("@s_lsrv", ICTSTypes.SQLVARCHAR, wSession.getServer());
			}
			return wProcedureRequest;
		}
		return wProcedureRequest;
	}
}
