package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.MemberInfo;

/**
 * Created by bqtdesa02 on 8/3/2017.
 */

public class MemberResponse extends GenericResponse {

    private MemberInfo data;

    public MemberInfo getData() {
        return data;
    }

    public void setData(MemberInfo data) {
        this.data = data;
    }
}
