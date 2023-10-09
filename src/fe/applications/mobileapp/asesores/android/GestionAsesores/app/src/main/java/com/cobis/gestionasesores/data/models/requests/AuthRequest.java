package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by jescudero on 22/08/2017.
 */

public class AuthRequest {
    private String user;
    private String password;
    private String deviceId;
    private int channel;

    public AuthRequest(String user, String password, String deviceID, int channel) {
        this.user = user;
        this.password = password;
        this.deviceId = deviceID;
        this.channel = channel;
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

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public int getChannel() {
        return channel;
    }

    public void setChannel(int channel) {
        this.channel = channel;
    }
}
