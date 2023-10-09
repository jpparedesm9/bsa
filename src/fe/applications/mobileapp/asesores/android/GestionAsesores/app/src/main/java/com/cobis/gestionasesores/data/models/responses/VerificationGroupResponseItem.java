package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class VerificationGroupResponseItem {
    private VerificationGroupRemote entity;
    private ActionResponse action;

    public VerificationGroupRemote getEntity() {
        return entity;
    }

    public void setEntity(VerificationGroupRemote entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}
