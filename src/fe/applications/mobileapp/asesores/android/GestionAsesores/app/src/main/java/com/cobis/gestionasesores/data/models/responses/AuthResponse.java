package com.cobis.gestionasesores.data.models.responses;

public class AuthResponse extends GenericResponse {
    private LoginInfo data;
    private String user;

    public AuthResponse() {
    }

    public String getToken() {
        return data.token;
    }

    public void setToken(String token) {
        this.data.token = token;
    }

    public boolean isProceedToCompleteRegistration() {
        return data.proceedToCompleteRegistration;
    }

    public void setProceedToCompleteRegistration(boolean proceedToCompleteRegistration) {
        this.data.proceedToCompleteRegistration = proceedToCompleteRegistration;
    }

    public String getOfficerName() {
        return data.officerName;
    }

    public long getIdleTimeout() {
        return data.idleTimeout;
    }

    public void setOfficerName(String officerName) {
        this.data.officerName = officerName;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    private static class LoginInfo {
        private String token;
        private boolean proceedToCompleteRegistration;
        private String officerName;
        private long idleTimeout;
    }
}
