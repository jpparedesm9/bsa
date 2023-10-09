package com.cobiscorp.ecobis.cloud.service.dto.group;

/**
 * @author Cesar Loachamin
 */
public class GroupResult {
    private int groupId;

    public GroupResult() {
    }

    public GroupResult(Integer groupId) {
        this.groupId = groupId == null ? 0 : groupId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }
}
