package com.cobis.gestionasesores.infrastructure.jwt;

/**
 * Created by mnaunay on 22/08/2017.
 */
public class DecodeException extends RuntimeException {

    DecodeException(String message) {
        super(message);
    }

    DecodeException(String message, Throwable cause) {
        super(message, cause);
    }
}
