package com.cobiscorp.cobis.assets.commons.sessions;

import java.util.Map;

import com.cobiscorp.cobis.assets.commons.parameters.SessionConstants;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

public class AssetsSessionManager {

	private static final ILogger logger = LogFactory
			.getLogger(AssetsSessionManager.class);

	private AssetsSessionManager() {
	}

	public static void saveLoan(String idInstance, Object loan) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("AssetsSessionManager>>>>>>>");
			logger.logDebug("Mapeo Campos Loan>>>>>>>" + idInstance);
		}

		Map<String, Object> session = SessionManager.getSession();

		session.put(SessionConstants.LOAN_KEY.concat(idInstance), loan);

	}

	public static Object getLoan(String idInstance) {
		Map<String, Object> session = SessionManager.getSession();

		return session.get(SessionConstants.LOAN_KEY.concat(idInstance));

	}

	public static void saveLoanRefinance(String idInstance,
			Object refinanceLoansItems) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("AssetsSessionManager>>>>>>>");
			logger.logDebug("Mapeo Campos Loan>>>>>>>" + idInstance);
		}
		Map<String, Object> session = SessionManager.getSession();
		session.put(SessionConstants.LOAN_REFINANCE_KEY.concat(idInstance),
				refinanceLoansItems);
	}

	public static Object getLoanRefinance(String idInstance) {
		Map<String, Object> session = SessionManager.getSession();
		return session.get(SessionConstants.LOAN_REFINANCE_KEY
				.concat(idInstance));
	}

}
