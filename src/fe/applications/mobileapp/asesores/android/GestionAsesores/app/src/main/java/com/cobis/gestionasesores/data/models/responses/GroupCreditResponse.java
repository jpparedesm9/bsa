package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by bqtdesa02 on 8/29/2017.
 */

public class GroupCreditResponse extends GenericResponse{

    List<GroupCreditResponseItem> data;

    public List<GroupCreditResponseItem> getData() {
        return data;
    }

    public void setData(List<GroupCreditResponseItem> data) {
        this.data = data;
    }
}
