package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 28/08/2017.
 */

public class IndividualCreditResponseItem {
    private IndividualCreditEntity entity;
    private ActionResponse action;

    public IndividualCreditEntity getEntity() {
        return entity;
    }

    public void setEntity(IndividualCreditEntity entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}
