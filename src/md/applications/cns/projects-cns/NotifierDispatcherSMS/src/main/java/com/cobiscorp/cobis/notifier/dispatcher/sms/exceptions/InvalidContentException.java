package com.cobiscorp.cobis.notifier.dispatcher.sms.exceptions;

import com.cobiscorp.cobis.commons.exceptions.COBISException;

public class InvalidContentException extends COBISException {

	private static final long serialVersionUID = -1753142852303108088L;

	public InvalidContentException(String message, Throwable t) {
		super("The content provided is not valid for this dispatcher: " + message, t);
		
	}

}
