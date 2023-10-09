package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

public class CustomerResponse extends GenericResponse {
    List<CustomerResponseItem> data;

    public List<CustomerResponseItem> getData() {
        return data;
    }

    public void setData(List<CustomerResponseItem> data) {
        this.data = data;
    }
}
