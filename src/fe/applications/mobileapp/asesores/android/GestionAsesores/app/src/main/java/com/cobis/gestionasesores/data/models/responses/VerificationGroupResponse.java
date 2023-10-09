package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class VerificationGroupResponse extends GenericResponse {
    private List<VerificationGroupResponseItem> data;

    public List<VerificationGroupResponseItem> getData() {
        return data;
    }

    public void setData(List<VerificationGroupResponseItem> data) {
        this.data = data;
    }
}