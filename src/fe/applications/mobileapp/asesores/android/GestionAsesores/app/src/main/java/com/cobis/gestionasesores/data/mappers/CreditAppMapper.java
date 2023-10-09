package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.requests.GroupCreditInfo;
import com.cobis.gestionasesores.data.models.requests.MemberCreditInfo;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mnaunay on 08/08/2017.
 */

public class CreditAppMapper {
    private static final String APP_GROUP_SERVER = "GRUPAL";

    public static GroupCreditInfo fromCreditApp(GroupCreditApp creditApp, boolean isConfirmation) {
        GroupCreditInfo info = new GroupCreditInfo();
        info.setApplicationDate(DateUtils.formatDateForService(creditApp.getCreationDate()));
        info.setGroupNumber(creditApp.getGroupServerId());
        info.setGroupName(creditApp.getApplicantName());
        info.setGroupCycle(creditApp.getCycle());

        info.setApplicationType(APP_GROUP_SERVER);
        info.setGroupAmount(creditApp.getAmount());

        info.setRate(creditApp.getRate());
        info.setTerm(creditApp.getTerm());
        info.setPromotion(creditApp.isPromotion());
        info.setGroupAgreeRenew(creditApp.isRenew());
        info.setReasonNotAccepting(creditApp.getReason());
        info.setConfirmation(isConfirmation);
        info.setMembers(fromListMemberCreditApp(creditApp.getMemberCreditApps()));
        return info;
    }

    public static GroupCreditApp toGroupCreditApp(GroupCreditInfo creditInfo) {

        Long creationDate = null;
        if (creditInfo.getApplicationDate() != null) {
            creationDate = DateUtils.parseDateFromService(creditInfo.getApplicationDate());
        }

        Boolean canModify = creditInfo.getFlagModifyApplication();

        return new GroupCreditApp.Builder()
                .setServerId(creditInfo.getProcessInstance())
                .setGroupServerId(creditInfo.getGroupNumber())
                .setApplicantName(creditInfo.getGroupName())
                .setCycle(creditInfo.getGroupCycle())
                .setCreationDate(creationDate)
                .setAmount(creditInfo.getGroupAmount())
//                .setAdviser(creditInfo.getAdviser())
//                .setBranchOffice(creditInfo.getBranchOffice())
                .setCanEdit(canModify == null ? true : canModify)
                .setRate(creditInfo.getRate())
                .setTerm(creditInfo.getTerm())
                .setPromotion(creditInfo.isPromotion())
                .setRenew(creditInfo.isGroupAgreeRenew())
                .setReason(creditInfo.getReasonNotAccepting())
                .setMemberCreditApps(fromListMemberCreditInfo(creditInfo.getMembers()))
                .build();
    }

    private static List<MemberCreditApp> fromListMemberCreditInfo(List<MemberCreditInfo> memberCreditInfos) {
        if (memberCreditInfos == null) return null;
        List<MemberCreditApp> memberCreditApps = new ArrayList<>();
        for (MemberCreditInfo creditInfo : memberCreditInfos) {
            memberCreditApps.add(new MemberCreditApp.Builder()
                    .setRfc(creditInfo.getRfc())
                    .setPosition(creditInfo.getRole())
                    .setCycleInGroup(creditInfo.getCycleNumber())
                    .setPartOfCycle(creditInfo.getParticipant())
                    .setRequestAmount(creditInfo.getAmountRequestedOriginal())
                    .setAuthorizedAmount(creditInfo.getAuthorizedAmount())
                    .setMaxProposedAmount(creditInfo.getProposedMaximumAmount())
                    .setRiskLevel(RiskLevelMapper.fromRemote(creditInfo.getRiskLevel()))//RiskLevelMapper.fromRemote(riskLevel)
                    .setCustomerName(creditInfo.getName())
//                    .setCustomerNumber(creditInfo.get)
//                    .setRenovation(creditInfo.get)
                    .setCustomerServerId(creditInfo.getCode())
                    .build());
        }
        return memberCreditApps;
    }

    private static List<MemberCreditInfo> fromListMemberCreditApp(List<MemberCreditApp> memberCreditApps) {
        List<MemberCreditInfo> result = new ArrayList<>();
        for (MemberCreditApp memberCreditApp : memberCreditApps) {
            result.add(toMemberInfo(memberCreditApp));
        }
        return result;
    }


    private static MemberCreditInfo toMemberInfo(MemberCreditApp memberCreditApp) {
        MemberCreditInfo info = new MemberCreditInfo();
        info.setRole(memberCreditApp.getPosition());
        info.setCycleNumber(memberCreditApp.getCycleInGroup());
        info.setCode(memberCreditApp.getCustomerServerId());
        info.setName(memberCreditApp.getCustomerName());
        info.setParticipant(memberCreditApp.isPartOfCycle());
        info.setAmountRequestedOriginal(memberCreditApp.getRequestAmount());
        info.setAuthorizedAmount(memberCreditApp.getAuthorizedAmount());

        //Not send liquid guarantee
        //info.setLiquidGuarantee(0);

        //Voluntary save send in zero!
        info.setVoluntarySavings(0.0);
        return info;
    }
}
