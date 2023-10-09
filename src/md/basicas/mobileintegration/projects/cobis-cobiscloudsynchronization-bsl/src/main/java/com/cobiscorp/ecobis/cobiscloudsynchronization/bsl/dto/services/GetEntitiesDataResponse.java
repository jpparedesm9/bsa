package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services;

import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.Action;

import java.util.Map;

/**
 * Created by farid on 7/20/2017.
 */
public class GetEntitiesDataResponse {
    private Object entity;
    private Action action;

    public GetEntitiesDataResponse() {
    }

    public Object getEntity() {
        return entity;
    }

    public void setEntity(Object entity) {
        this.entity = entity;
    }

    public Action getAction() {
        return action;
    }

    public void setAction(Action action) {
        this.action = action;
    }
}
