package com.cobiscorp.b2c.jwt;

public class InvalidTokenException extends Exception {

	private static final long serialVersionUID = 2200124562221211567L;

	public InvalidTokenException() {
		super();
	}

	public InvalidTokenException(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidTokenException(String message) {
		super(message);
	}

	public InvalidTokenException(Throwable cause) {
		super(cause);
	}
	
	

}
