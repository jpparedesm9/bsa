package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 8/30/2017.
 */

public class GroupResponseItem {

    private GroupEntity entity;
    private ActionResponse action;

    public GroupEntity getEntity() {
        return entity;
    }

    public void setEntity(GroupEntity entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}
