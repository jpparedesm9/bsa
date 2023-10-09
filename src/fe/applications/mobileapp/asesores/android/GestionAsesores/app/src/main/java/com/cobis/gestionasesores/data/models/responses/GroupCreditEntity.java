package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.GroupCreditInfo;

/**
 * Created by bqtdesa02 on 8/29/2017.
 */

public class GroupCreditEntity {

    private GroupCreditInfo creditGroupApplication;

    public GroupCreditInfo getCreditGroupApplication() {
        return creditGroupApplication;
    }

    public void setCreditGroupApplication(GroupCreditInfo creditGroupApplication) {
        this.creditGroupApplication = creditGroupApplication;
    }
}
