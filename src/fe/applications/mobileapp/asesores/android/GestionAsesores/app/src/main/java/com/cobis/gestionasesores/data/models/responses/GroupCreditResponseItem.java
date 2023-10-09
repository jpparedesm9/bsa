package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 8/29/2017.
 */

public class GroupCreditResponseItem {

    private GroupCreditEntity entity;
    private ActionResponse action;

    public GroupCreditEntity getEntity() {
        return entity;
    }

    public void setEntity(GroupCreditEntity entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}
