package com.cobiscorp.cobis.customer.reports.security;


public class SessionSecurityKey {

    private String backendId;
    private String login;
    private String applicationId;
    private String password;

    public SessionSecurityKey() {

    }

    public SessionSecurityKey(String backendId, String login,
                              String applicationId) {
        super();
        this.backendId = backendId;
        this.login = login;
        this.applicationId = applicationId;
    }

    public SessionSecurityKey(String backendId, String login, String password,
                              String applicationId) {
        super();
        this.backendId = backendId;
        this.login = login;
        this.password = password;
        this.applicationId = applicationId;
    }

    public String getBackendId() {
        return backendId;
    }

    public void setBackendId(String backendId) {
        this.backendId = backendId;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(String applicationId) {
        this.applicationId = applicationId;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result
                + ((applicationId == null) ? 0 : applicationId.hashCode());
        result = prime * result
                + ((backendId == null) ? 0 : backendId.hashCode());
        result = prime * result + ((login == null) ? 0 : login.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        SessionSecurityKey other = (SessionSecurityKey) obj;
        if (applicationId == null) {
            if (other.applicationId != null)
                return false;
        } else if (!applicationId.equals(other.applicationId))
            return false;
        if (backendId == null) {
            if (other.backendId != null)
                return false;
        } else if (!backendId.equals(other.backendId))
            return false;
        if (login == null) {
            if (other.login != null)
                return false;
        } else if (!login.equals(other.login))
            return false;
        return true;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
