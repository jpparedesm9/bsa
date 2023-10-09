package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services;

/**
 * Created by farid on 7/18/2017.
 */
public class UpdateDataSynchronizeRequest {
    private Integer idSync;
    private String status;

    public UpdateDataSynchronizeRequest() {
    }

    public Integer getIdSync() {
        return idSync;
    }

    public void setIdSync(Integer idSync) {
        this.idSync = idSync;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
