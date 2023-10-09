package com.cobis.gestionasesores.data.models;

/**
 * Created by Miguel on 14/07/2017.
 */

public class Session {
    private String token;
    private String userName;
    private String officerName;
    private long inactivityTimeout;
    private boolean isOnline;

    public Session(Builder builder) {
        token = builder.token;
        userName = builder.userName;
        officerName = builder.officerName;
        isOnline = builder.isOnline;
        inactivityTimeout = builder.inactivityTimeout;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUserName() {
        return userName;
    }

    public boolean isOnline() {
        return isOnline;
    }

    public String getToken() {
        return token;
    }

    public String getOfficerName() {
        return officerName;
    }

    public long getInactivityTimeout() {
        return inactivityTimeout;
    }

    @Override
    public String toString() {
        return "Session{" +
                ", token='" + token + '\'' +
                ", userName='" + userName + '\'' +
                ", officerName='" + officerName + '\'' +
                '}';
    }

    public static class Builder {
        private String token;
        private String userName;
        private String officerName;
        private long inactivityTimeout;
        private boolean isOnline;

        public Builder setOnline(boolean online) {
            isOnline = online;
            return this;
        }

        public Builder setToken(String token) {
            this.token = token;
            return this;
        }

        public Builder setUserName(String userName) {
            this.userName = userName;
            return this;
        }

        public Builder setOfficerName(String officerName) {
            this.officerName = officerName;
            return this;
        }

        public Builder setInactivityTimeout(long inactivityTimeout) {
            this.inactivityTimeout = inactivityTimeout;
            return this;
        }

        public Session build(){
            return new Session(this);
        }
    }
}
