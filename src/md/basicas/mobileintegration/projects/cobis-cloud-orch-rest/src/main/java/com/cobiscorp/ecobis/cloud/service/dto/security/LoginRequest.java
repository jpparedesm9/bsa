package com.cobiscorp.ecobis.cloud.service.dto.security;

/**
 * Created by farid on 7/25/2017.
 */
public class LoginRequest {
    private String deviceId;
    private String user;
    private String password;


    public LoginRequest() {
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }


    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


}
