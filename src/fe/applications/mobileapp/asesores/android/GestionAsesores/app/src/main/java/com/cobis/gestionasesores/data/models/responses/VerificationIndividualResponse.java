package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */
public class VerificationIndividualResponse extends GenericResponse{
    private List<VerificationIndividualResponseItem> data;

    public List<VerificationIndividualResponseItem> getData() {
        return data;
    }

    public void setData(List<VerificationIndividualResponseItem> data) {
        this.data = data;
    }
}
