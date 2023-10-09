package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 10/24/2017.
 */

public class ValidGroupRemote {

    private int groupId;
    private Boolean availableForCredit;

    public ValidGroupRemote() {
    }

    public ValidGroupRemote(int groupId) {
        this.groupId = groupId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public Boolean getAvailableForCredit() {
        return availableForCredit;
    }

    public void setAvailableForCredit(boolean availableForCredit) {
        this.availableForCredit = availableForCredit;
    }
}
