package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto;

/**
 * Created by farid on 7/20/2017.
 */
public class Action {
    private String actionType;
    private String description;

    public Action() {
    }

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

    @Override
    public String toString() {
        return "Action{" +
                "actionType='" + actionType + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
