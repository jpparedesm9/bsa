package com.cobis.gestionasesores.data.models;

import java.util.List;

/**
 * Created by mnaunay on 17/08/2017.
 */
public class Verification extends Task {

    List<MemberVerification> memberVerifications;

    public Verification(String type) {
        super(type);
    }

    public List<MemberVerification> getMemberVerifications() {
        return memberVerifications;
    }

    public synchronized void replaceMember(MemberVerification memberVerification){
        for(int i=0;i<memberVerifications.size();i++){
            if(memberVerifications.get(i).getServerId()== memberVerification.getServerId()){
                memberVerifications.set(i,memberVerification);
                break;
            }
        }
    }
    public void setMemberVerifications(List<MemberVerification> memberVerifications) {
        this.memberVerifications = memberVerifications;
    }
}
