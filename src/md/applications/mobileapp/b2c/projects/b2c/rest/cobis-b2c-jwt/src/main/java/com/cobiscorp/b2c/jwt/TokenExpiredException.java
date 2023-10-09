package com.cobiscorp.b2c.jwt;

public class TokenExpiredException extends Exception {

	private static final long serialVersionUID = 8596096438513696827L;

	public TokenExpiredException(String string) {
        super(string);
    }

	public TokenExpiredException() {
		super();
	}

	public TokenExpiredException(String message, Throwable cause) {
		super(message, cause);
	}

	public TokenExpiredException(Throwable cause) {
		super(cause);
	}


}
