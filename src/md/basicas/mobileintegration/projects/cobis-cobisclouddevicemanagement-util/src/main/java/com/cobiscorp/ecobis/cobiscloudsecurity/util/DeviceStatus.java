package com.cobiscorp.ecobis.cobiscloudsecurity.util;

/**
 * Created by fervincent on 22/08/17.
 */
public enum DeviceStatus {
    PRE_REGISTERED("P", true, false, false), REGISTERED("R", false, false, false),
    LOCK("L", false, true, true), UNSUSCRIBED ("U", false, true, true);

    private String status;
    private boolean proceedToCompleteRegistration;
    private boolean proceedToClearData;
    private boolean lock;

    DeviceStatus(String status, boolean proceedToCompleteRegistration,
                 boolean lock, boolean proceedToClearData) {
        this.status = status;
        this.proceedToCompleteRegistration = proceedToCompleteRegistration;
        this.lock = lock;
        this.proceedToClearData = proceedToClearData;
    }


    public String getStatus() {
        return status;
    }

    public boolean isProceedToCompleteRegistration() {
        return proceedToCompleteRegistration;
    }

    public boolean isLock() {
        return lock;
    }


    public boolean isProceedToClearData() {
        return proceedToClearData;
    }
}
