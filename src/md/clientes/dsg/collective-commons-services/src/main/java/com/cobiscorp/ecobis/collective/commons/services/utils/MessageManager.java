package com.cobiscorp.ecobis.collective.commons.services.utils;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;

public class MessageManager {

	private static final ILogger LOGGER = LogFactory.getLogger(MessageManager.class);

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = "";
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}
}
