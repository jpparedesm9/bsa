package com.cobis.gestionasesores.data.models.responses;

public class CustomerResponseItem {
    private CustomerEntity entity;
    private ActionResponse action;

    public int getCustomerId() {
        if (entity != null && entity.getCustomer() != null && entity.getCustomer().getCustomer() != null) {
            return entity.getCustomer().getCustomer().getCustomerId();
        } else {
            return -1;
        }
    }

    public CustomerEntity getEntity() {
        return entity;
    }

    public void setEntity(CustomerEntity entity) {
        this.entity = entity;
    }

    public ActionResponse getAction() {
        return action;
    }

    public void setAction(ActionResponse action) {
        this.action = action;
    }
}
