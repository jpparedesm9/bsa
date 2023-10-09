package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 28/08/2017.
 */

public class IndividualCreditResponse extends GenericResponse {
    private List<IndividualCreditResponseItem> data;

    public List<IndividualCreditResponseItem> getData() {
        return data;
    }

    public void setData(List<IndividualCreditResponseItem> data) {
        this.data = data;
    }
}