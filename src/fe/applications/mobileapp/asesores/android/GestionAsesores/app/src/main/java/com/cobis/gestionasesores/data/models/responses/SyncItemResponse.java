package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.SyncItemRemote;

import java.util.List;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SyncItemResponse extends GenericResponse{
    private List<SyncItemRemote> data;

    public List<SyncItemRemote> getData() {
        return data;
    }

    public void setData(List<SyncItemRemote> data) {
        this.data = data;
    }
}
