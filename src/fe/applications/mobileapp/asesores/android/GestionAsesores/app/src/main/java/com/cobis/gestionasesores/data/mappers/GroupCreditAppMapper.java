package com.cobis.gestionasesores.data.mappers;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.ServerAction;
import com.cobis.gestionasesores.data.models.requests.GroupCreditInfo;
import com.cobis.gestionasesores.data.models.requests.MemberCreditInfo;
import com.cobis.gestionasesores.data.models.requests.ValidGroupRemote;
import com.cobis.gestionasesores.data.models.responses.ActionResponse;
import com.cobis.gestionasesores.data.models.responses.GroupCreditResponseItem;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 6/26/2017.
 */

public class GroupCreditAppMapper {

    public static GroupCreditApp fromGroup(Group group) {
        return new GroupCreditApp.Builder()
                .setApplicantId(group.getId())
                .setCycle(group.getCycle())
                .setAdviser(group.getAdviser())
                .setBranchOffice(group.getBranchOffice())
                .setApplicantName(group.getName())
                .setGroupServerId(group.getServerId())
                .setMemberCreditApps(MemberCreditAppMapper.fromMembers(group.getMembers()))
                .build();
    }

    public static List<ValidGroupRemote> validGroupsFromGroups(List<Group> groups){
        List<ValidGroupRemote> result = new ArrayList<>();
        for (Group group: groups){
            result.add(new ValidGroupRemote(group.getServerId()));
        }
        return result;
    }

    //***********************************DOWNLOAD MAPPER******************************************//
    public static List<GroupCreditApp> fromRemoteListItem(List<GroupCreditResponseItem> data) {
        List<GroupCreditApp> result = new ArrayList<>();
        for (GroupCreditResponseItem item : data) {
            result.add(fromRemoteItem(item));
        }
        return result;
    }

    private static GroupCreditApp fromRemoteItem(GroupCreditResponseItem item) {
        GroupCreditInfo remote = item.getEntity().getCreditGroupApplication();

        GroupCreditApp creditApp = new GroupCreditApp.Builder()
                .setCycle(remote.getGroupCycle())
                .setRate(remote.getRate())
                .setTerm(remote.getTerm())
                .setPromotion(remote.isPromotion())
                .setRenew(remote.isGroupAgreeRenew())
                .setReason(remote.getReasonNotAccepting())
                .setMemberCreditApps(fromRemoteMemberItem(remote.getMembers()))
                .setGroupServerId(remote.getGroupNumber())
                .setApplicantName(remote.getGroupName())
                .setCreationDate(DateUtils.parseDateFromService(remote.getApplicationDate()))
                .setServerId(remote.getProcessInstance())
                .build();
        ActionResponse actionResponse = item.getAction();
        if (actionResponse != null && (StringUtils.isNotEmpty(actionResponse.getActionType())
                || StringUtils.isNotEmpty(actionResponse.getDescription()))) {
            creditApp.setAction(new ServerAction(actionResponse.getActionType(), actionResponse.getDescription()));
        }
        return creditApp;
    }

    private static List<MemberCreditApp> fromRemoteMemberItem(List<MemberCreditInfo> creditInfos) {
        List<MemberCreditApp> result = new ArrayList<>();
        for (MemberCreditInfo info : creditInfos) {
            result.add(new MemberCreditApp.Builder()
                    .setPosition(info.getRole())
                    .setCycleInGroup(info.getCycleNumber())
                    .setPartOfCycle(info.getParticipant())
                    .setRequestAmount(info.getAmountRequestedOriginal())
                    .setAuthorizedAmount(info.getAuthorizedAmount())
                    .setMaxProposedAmount(info.getProposedMaximumAmount())
                    .setRfc(info.getRfc())
                    .setRiskLevel(RiskLevelMapper.fromRemote(info.getRiskLevel()))
                    .setCustomerName(info.getName())
                    .setCustomerServerId(info.getCode())
                    .build());
        }
        return result;
    }
}
