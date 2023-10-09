package com.cobiscorp.cobis.assets.commons.utils;

import java.util.List;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.LoanInstanceSession;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;

public abstract class Function {

	private static final ILogger logger = LogFactory.getLogger(LoanInstanceSession.class);

	public static String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = Parameter.EMPTY_VALUE;
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}
}