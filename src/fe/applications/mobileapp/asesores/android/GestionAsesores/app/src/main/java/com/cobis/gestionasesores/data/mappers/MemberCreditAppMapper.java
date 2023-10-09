package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberCreditApp;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 6/26/2017.
 */

public class MemberCreditAppMapper {

    public static List<MemberCreditApp> fromMembers(List<Member> members){
        List<MemberCreditApp> memberCreditApps = new ArrayList<>();
        for (Member member : members) {
            memberCreditApps.add(fromMember(member));
        }
        return memberCreditApps;
    }

    public static MemberCreditApp fromMember(Member member){
        return new MemberCreditApp.Builder()
                .setRfc(member.getRfc())
                .setCustomerName(member.getName())
                .setPosition(member.getPosition())
                .setCycleInGroup(member.getCycleInGroup())
                .setCustomerNumber(member.getCustomerNumber())
                .setRiskLevel(RiskLevelMapper.fromRemote(member.getRiskLevel()))//RiskLevelMapper.fromRemote(riskLevel)
                .setCustomerServerId(member.getServerId())
                .build();
    }
}
