package com.cobiscorp.ecobis.cloud.service.dto.security;

/**
 * Created by farid on 7/25/2017.
 */
public class LoginResponse {
    private String sessionId;

    public LoginResponse() {
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
}
