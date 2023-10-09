package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.g11n.bo.L10NInfo;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

public class SessionContext {
	
	private static final ILogger logger = LogFactory.getLogger(SessionContext.class);
	public final static int DATE100 = 100;
	public final static int DATE101 = 101;
	public final static int DATE103 = 103;
	public final static int DATE105 = 105;
	public final static int DATE110 = 110;
	public final static int DATE111 = 111;
	public final static String PATTERN_DATE100 = "MMM dd yyyy hh:mmaaa"; // Jan 11 2016 9:46AM
	public final static String PATTERN_DATE101 = "MM/dd/yyyy";
	public final static String PATTERN_DATE103 = "dd/MM/yyyy";
	public final static String PATTERN_DATE105 = "dd-MM-yyyy";
	public final static String PATTERN_DATE110 = "MM-dd-yyyy";
	public final static String PATTERN_DATE111 = "yyyy/MM/dd";

	public static int getFormatDate() {
		logger.logDebug("--->getFormatDate");
		Map<String, Object> session = SessionManager.getSession();
		logger.logDebug("--->session"+session);
		L10NInfo clientLocalizationInformation = (L10NInfo) session.get(L10NInfo.CLIENT_LOCALIZATION_INFORMATION);
		String dateFormat = clientLocalizationInformation == null ? null : clientLocalizationInformation.getDateFormat();
		if(dateFormat == null)
			return DATE101;
		if (dateFormat.equals(SessionContext.PATTERN_DATE101))
			return DATE101;
		if (dateFormat.equals(SessionContext.PATTERN_DATE103))
			return DATE103;
		if (dateFormat.equals(SessionContext.PATTERN_DATE111))
			return DATE111;
		if (dateFormat.equals(SessionContext.PATTERN_DATE100))
			return DATE100;
		if (dateFormat.equals(SessionContext.PATTERN_DATE105))
			return DATE105;
		if (dateFormat.equals(SessionContext.PATTERN_DATE110))
			return DATE110;
		return DATE101;
	}

	public static String getPatternDate() {
		Map<String, Object> session = SessionManager.getSession();
		L10NInfo clientLocalizationInformation = (L10NInfo) session.get(L10NInfo.CLIENT_LOCALIZATION_INFORMATION);
		if(clientLocalizationInformation==null){
			if(logger.isDebugEnabled()){
				logger.logDebug("clientLocalizationInformation is null");
			}
			return SessionContext.PATTERN_DATE101;
		}
		return clientLocalizationInformation.getDateFormat();
	}
}
