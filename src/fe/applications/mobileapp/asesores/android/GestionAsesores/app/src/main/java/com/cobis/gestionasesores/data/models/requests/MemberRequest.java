package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 8/3/2017.
 */

public class MemberRequest {
    private MemberInfo member;
    private boolean online;

    public MemberInfo getMember() {
        return member;
    }

    public void setMember(MemberInfo member) {
        this.member = member;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
