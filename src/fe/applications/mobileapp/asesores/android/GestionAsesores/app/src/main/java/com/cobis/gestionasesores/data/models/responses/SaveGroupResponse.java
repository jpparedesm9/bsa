package com.cobis.gestionasesores.data.models.responses;


import com.cobis.gestionasesores.data.models.requests.GroupInfo;

/**
 * Created by mnaunay on 03/08/2017.
 */

public class SaveGroupResponse extends GenericResponse{
    private GroupInfo data;

    public GroupInfo getData() {
        return data;
    }

    public void setData(GroupInfo data) {
        this.data = data;
    }
}
