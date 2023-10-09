package com.cobiscorp.ecobis.cloud.service.dto.client;


public class ComplementaryDataRequest extends ComplementaryData {

    private boolean online;

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
