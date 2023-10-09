package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class VerificationIndividualResponseItem {
    private VerificationIndividualRemote entity;
    private ActionResponse action;

    public VerificationIndividualRemote getEntity() {
        return entity;
    }

    public void setEntity(VerificationIndividualRemote entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}
