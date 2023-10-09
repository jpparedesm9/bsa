package com.cobiscorp.mobile.exception;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.mobile.model.KeyValue;

public class MobileServiceException extends Throwable {

	private static final long serialVersionUID = 4800631834937311382L;

	private List<KeyValue> errors;

	public MobileServiceException() {
		super();
	}

	public MobileServiceException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public MobileServiceException(String message, Throwable cause) {
		super(message, cause);
	}

	public MobileServiceException(String message) {
		super(message);
	}

	public MobileServiceException(Throwable cause) {
		super(cause);
	}

	public MobileServiceException(String code, String message) {
		super(message);
		addError(code, message);
	}

	public void addError(String code, String message) {
		if (errors == null) {
			errors = new ArrayList<KeyValue>();
		}
		errors.add(new KeyValue(code, message));
	}

	public List<KeyValue> getErrors() {
		return errors;
	}

}