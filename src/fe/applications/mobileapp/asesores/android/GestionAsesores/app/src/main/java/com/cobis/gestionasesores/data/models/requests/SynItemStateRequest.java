package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SynItemStateRequest {
    private int idSync;
    private String status;

    public SynItemStateRequest(int idSync, String status) {
        this.idSync = idSync;
        this.status = status;
    }

    public int getIdSync() {
        return idSync;
    }

    public void setIdSync(int idSync) {
        this.idSync = idSync;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
