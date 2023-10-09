package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.ValidGroupRemote;

import java.util.List;

/**
 * Created by bqtdesa02 on 10/24/2017.
 */

public class ValidGroupResponse extends GenericResponse{

    private List<ValidGroupRemote> data;

    public List<ValidGroupRemote> getData() {
        return data;
    }

    public void setData(List<ValidGroupRemote> data) {
        this.data = data;
    }
}
