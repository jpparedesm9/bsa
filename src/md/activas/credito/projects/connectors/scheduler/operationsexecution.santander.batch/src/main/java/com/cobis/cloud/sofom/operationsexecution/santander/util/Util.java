package com.cobis.cloud.sofom.operationsexecution.santander.util;

import com.cobis.cloud.sofom.operationsexecution.santander.batch.SantanderAccountBucJob;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.security.ContextFactory;
import com.cobiscorp.cobis.cts.security.ServerManager;
import com.cobiscorp.cobis.cts.security.SessionManager;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.cobisv.commons.context.Session;

public class Util {

	private static final ILogger LOGGER = LogFactory.getLogger(Util.class);

	/**
	 * Creates context for execute in CTS
	 * 
	 * @param sessionId
	 * @param backEndId
	 */
	public static String createContext(String sessionId, String backEndId, SessionManager wSessionManager1, ServerManager serverManager, ContextFactory contextFactory) {
		LOGGER.logTrace("Inicia createContext ");

		// FABAD: the session is mandatory
		Session session = wSessionManager1.getSession(sessionId, backEndId);
		try {
			if (LOGGER.isTraceEnabled()) {
				LOGGER.logTrace("Creating temporal context with sessionId: " + sessionId);
			}


			Server server = serverManager.getServerInstance(session);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[server]: " + server);
			}
			Context context = contextFactory.createContext(session, server);
			ContextRepository.setContext(context);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[context]:" + ContextManager.getContext());
			}
			LOGGER.logTrace("finaliza createContext ");
			return context.getContextId();
		} catch (Exception e) {
			LOGGER.logError("Error creating temporal context with sessionId: " + sessionId, e);
		}
		return null;

	}
}
