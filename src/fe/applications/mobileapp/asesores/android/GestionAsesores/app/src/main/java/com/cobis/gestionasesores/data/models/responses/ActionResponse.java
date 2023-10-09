package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 23/08/2017.
 */

public class ActionResponse {
    private String actionType;
    private String description;

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
