package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by bqtdesa02 on 8/30/2017.
 */

public class GroupResponse extends GenericResponse {

    private List<GroupResponseItem> data;

    public List<GroupResponseItem> getData() {
        return data;
    }

    public void setData(List<GroupResponseItem> data) {
        this.data = data;
    }
}
