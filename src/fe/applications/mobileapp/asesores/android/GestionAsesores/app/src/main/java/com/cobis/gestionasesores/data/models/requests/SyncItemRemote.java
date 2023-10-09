package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SyncItemRemote {
    private String date;
    private String entity;
    private int entityId;
    private int idSync;
    private int registersNumber;
    private String state;
    private String user;

    public String getDate() {
        return date;
    }

    public int getEntityId() {
        return entityId;
    }

    public void setEntityId(int entityId) {
        this.entityId = entityId;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public int getIdSync() {
        return idSync;
    }

    public void setIdSync(int idSync) {
        this.idSync = idSync;
    }

    public int getRegistersNumber() {
        return registersNumber;
    }

    public void setRegistersNumber(int registersNumber) {
        this.registersNumber = registersNumber;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}
