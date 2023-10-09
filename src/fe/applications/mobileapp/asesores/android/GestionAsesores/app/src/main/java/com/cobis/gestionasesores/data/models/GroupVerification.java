package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.TaskType;

import java.util.List;

/**
 * Created by bqtdesa02 on 8/14/2017.
 */

public class GroupVerification extends Verification {
    private int groupId;

    public GroupVerification() {
        super(TaskType.GROUP_VERIFICATION);
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }
}