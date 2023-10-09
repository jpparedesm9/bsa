package com.cobis.gestionasesores.data.models.responses;

public class SolidarityPaymentResponseItem{
    private SolidarityPaymentEntity entity;
    private ActionResponse action;

    public SolidarityPaymentEntity getEntity() {
        return entity;
    }

    public void setEntity(SolidarityPaymentEntity entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}

