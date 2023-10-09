package com.cobiscorp.mobile.services.impl.exception;

import java.io.Serializable;

/**
 * Represent a business exception in Mobile Service
 * @author fespinosa
 *
 */
public class MobileServiceException extends RuntimeException implements Serializable {

	private static final long serialVersionUID = 1L;

	public MobileServiceException(String message) {
		super(message);
	}
	
	public MobileServiceException(String message,Throwable cause) {
		super(message,cause);
	}

}
