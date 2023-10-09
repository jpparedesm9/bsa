package com.cobis.cloud.sofom.service.oxxo.utils;

import cobiscorp.ecobis.commons.dto.MessageTO;

public class OxxoMessages {
	OxxoMessages() {
	}

	public static MessageTO[] setErrorMessages(String message, Object object) {
		MessageTO errorMessage = new MessageTO();
		StringBuilder errorBuilder = new StringBuilder();
		errorBuilder.append(message == null ? "" : message);
		errorBuilder.append(object == null ? "" : object);
		errorMessage.setMessage(errorBuilder.toString());
		return new MessageTO[] { errorMessage };
	}

}
