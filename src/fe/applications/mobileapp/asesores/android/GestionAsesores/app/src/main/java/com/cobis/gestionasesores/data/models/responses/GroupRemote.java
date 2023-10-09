package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.GroupInfo;
import com.cobis.gestionasesores.data.models.requests.MemberInfo;

import java.util.List;

/**
 * Created by bqtdesa02 on 8/4/2017.
 */

public class GroupRemote {

    private GroupInfo group;
    private List<MemberInfo> members;

    public GroupInfo getGroup() {
        return group;
    }

    public void setGroup(GroupInfo group) {
        this.group = group;
    }

    public List<MemberInfo> getMembers() {
        return members;
    }

    public void setMembers(List<MemberInfo> members) {
        this.members = members;
    }
}
