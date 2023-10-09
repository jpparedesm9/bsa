package com.cobiscorp.mobile.converter;

import com.cobiscorp.mobile.model.KeyValue;

public class ErrorConverter {

	public static KeyValue convertError(KeyValue error) {
		String message = (String) error.getValue();
		if (message.contains("]")) {
			KeyValue result = new KeyValue();
			String[] parts = message.split("\\]");

			String code = parts[0].trim().replace("[", "");
			if (isNumeric(code)) {
				result.setKey(code);
			} else {
				result.setKey(error.getKey());
			}

			String value = parts[parts.length - 1];
			result.setValue(value.trim());

			return result;
		}
		return error;
	}

	private static boolean isNumeric(String value) {
		try {
			Long.valueOf(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}
}
