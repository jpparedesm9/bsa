package com.cobiscorp.ecobis.cloud.service.dto.group;



public class MemberData {

    private Member member;

    public MemberData() {
    }

    public MemberData(Member member) {
        this.member = member;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

}
