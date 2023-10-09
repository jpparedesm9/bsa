package com.cobiscorp.ecobis.cloud.service.dto.group;

public class GroupData {
    private Group group;
    private Member[] members;

    public GroupData() {
    }

    public GroupData(Group group, Member[] members) {
        this.group = group;
        this.members = members;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public Member[] getMembers() {
        return members;
    }

    public void setMembers(Member[] members) {
        this.members = members;
    }
}
