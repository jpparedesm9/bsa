package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 03/08/2017.
 */

public class GroupRequest {
    private GroupInfo group;
    private boolean online;

    public GroupInfo getGroup() {
        return group;
    }

    public void setGroup(GroupInfo group) {
        this.group = group;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
