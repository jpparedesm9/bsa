package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.responses.Message;

import java.io.Serializable;

public abstract class Synchronizable implements Serializable {
    @SyncStatus
    protected int status;
    protected int serverId;
    protected Message errorMsg;
    protected ServerAction action;

    @SyncStatus
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public Message getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(Message errorMsg) {
        this.errorMsg = errorMsg;
    }

    public ServerAction getAction() {
        return action;
    }

    public void setAction(ServerAction action) {
        this.action = action;
    }
}
