package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SyncItemRequest {
    private String user;

    public SyncItemRequest(String user) {
        this.user = user;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}
