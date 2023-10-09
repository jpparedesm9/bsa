package com.cobiscorp.ecobis.cloud.service.dto.client;

/**
 * @author Cesar Loachamin
 */
public class CustomerDataRequest extends CustomerData {

    private boolean online;

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
