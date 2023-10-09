package com.cobis.gestionasesores.data.mappers;

import android.util.SparseArray;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberRelation;
import com.cobis.gestionasesores.data.models.requests.GroupInfo;
import com.cobis.gestionasesores.data.models.requests.GroupRequest;
import com.cobis.gestionasesores.data.models.requests.MemberInfo;
import com.cobis.gestionasesores.data.models.requests.MemberRequest;
import com.cobis.gestionasesores.data.models.responses.GroupRemote;
import com.cobis.gestionasesores.data.models.responses.GroupResponseItem;
import com.cobis.gestionasesores.data.models.responses.MemberRelationInfo;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.List;

import io.reactivex.annotations.Nullable;

/**
 * Created by bqtdesa02 on 8/3/2017.
 */

public class GroupMapper {

    public static Group fromRemote(GroupRemote remote) {
        GroupInfo groupInfo = remote.getGroup();
        return fromGroupInfo(groupInfo, remote.getMembers());
    }

    public static GroupRequest groupToGroupRequest(Group group, boolean isSync) {
        GroupInfo groupInfo = new GroupInfo();
        groupInfo.setGroupId(group.getServerId());
        groupInfo.setMeetingDay(group.getDayMeeting());
        groupInfo.setMeetingHour(DateUtils.formatTimeForService(group.getTimeMeeting()));
        groupInfo.setName(group.getName());
        GroupRequest request = new GroupRequest();
        request.setGroup(groupInfo);
        request.setOnline(!isSync);
        return request;
    }

    public static MemberRequest memberToMemberRequest(Member member, boolean isSync) {

        MemberInfo memberInfo = new MemberInfo();
        memberInfo.setCustomerId(member.getServerId());
        memberInfo.setBankCode(String.valueOf(member.getCustomerNumber()));
        memberInfo.setRfc(member.getRfc());
        memberInfo.setPosition(member.getPosition());
        memberInfo.setCycle(member.getCycleInGroup());
        memberInfo.setName(member.getName());
        memberInfo.setRiskLevel(RiskLevelMapper.toRemote(member.getRiskLevel()));
        memberInfo.setMeetingPlace(member.getMeetingLocation());


        List<MemberRelationInfo> relations = new ArrayList<>();
        if (member.getRelationships() != null && !member.getRelationships().isEmpty()) {
            for (MemberRelation relation : member.getRelationships()) {
                relations.add(memberRelationToMemberInfo(relation));
            }
        }
        memberInfo.setRelations(relations);

        MemberRequest request = new MemberRequest();
        request.setOnline(!isSync);
        request.setMember(memberInfo);
        return request;
    }

    private static MemberRelationInfo memberRelationToMemberInfo(MemberRelation memberRelation) {
        MemberRelationInfo relation = new MemberRelationInfo();
        relation.setRelatedPersonId(memberRelation.getCustomerId());
        relation.setTypeOfRelationship(ConvertUtils.tryToInt(memberRelation.getRelationTypeCode(), -1));
        return relation;
    }

    //***************************************DOWNLOAD MAPPER***************************************/

    public static List<Group> fromRemoteListItem(List<GroupResponseItem> data) {
        List<Group> result = new ArrayList<>();
        for (GroupResponseItem item : data) {
            result.add(fromRemoteItem(item));
        }
        return result;
    }

    private static Group fromRemoteItem(GroupResponseItem item) {
        GroupInfo groupInfo = item.getEntity().getGroup().getGroup();
        List<MemberInfo> memberInfos = item.getEntity().getGroup().getMembers();

        return fromGroupInfo(groupInfo, memberInfos);
    }

    private static Group fromGroupInfo(GroupInfo groupInfo, List<MemberInfo> memberInfos) {
        Group group = new Group.Builder()
                .setName(groupInfo.getName())
                .setCycle(groupInfo.getCycle())
                .setBranchOffice(groupInfo.getOffice())
                .setAdviser(groupInfo.getOfficer())
                .setDayMeeting(groupInfo.getMeetingDay())
                .setTimeMeeting(DateUtils.parseTimeFromService(groupInfo.getMeetingHour()))
                .setMembers(memberInfosToMembers(memberInfos))
                .setCanEditMembers(groupInfo.getFlagModifyGroup() == null ? true : groupInfo.getFlagModifyGroup())
                .setStatus(groupInfo.getValidated() != null && groupInfo.getValidated() ? SyncStatus.SYNCED : SyncStatus.DRAFT)
                .build();
        group.setServerId(groupInfo.getGroupId());

        return group;
    }

    private static List<Member> memberInfosToMembers(List<MemberInfo> memberInfos) {
        if (memberInfos == null) return null;
        List<Member> members = new ArrayList<>();

        SparseArray<String> nameArray = new SparseArray<>();
        for (MemberInfo memberInfo : memberInfos) {
            if (memberInfo.getCustomerId() > 0) {
                nameArray.put(memberInfo.getCustomerId(), memberInfo.getName());
            }
        }

        for (MemberInfo memberInfo : memberInfos) {
            if (memberInfo.getCustomerId() > 0) {
                members.add(memberInfoToMember(memberInfo, nameArray, null));
            }
        }

        return members;
    }

    public static Member memberInfoToMember(MemberInfo memberInfo, SparseArray<String> nameArray, @Nullable SparseArray<String> relationArray) {
        Member member = new Member.Builder()
                .addServerId(memberInfo.getCustomerId())
                .addRfc(memberInfo.getRfc())
                .addName(memberInfo.getName())
                .addPosition(memberInfo.getPosition())
                .addCycleInGroup(memberInfo.getCycle())
                .addCustomerNumber(memberInfo.getBankCode())
                .addRiskLevel(RiskLevelMapper.fromRemote(memberInfo.getRiskLevel()))
                .addMeetingLocation(memberInfo.getMeetingPlace())
                .addRelationships(memberRelationInfoToMemberRelation(memberInfo.getRelations(), nameArray, relationArray))
                .addSyncedToServer(true)
                .build();
        member.setStatus(SyncStatus.SYNCED);

        return member;
    }

    private static List<MemberRelation> memberRelationInfoToMemberRelation(List<MemberRelationInfo> relationInfos, SparseArray<String> nameArray, @Nullable SparseArray<String> relationArray) {
        List<MemberRelation> result = new ArrayList<>();

        if (relationInfos != null) {
            for (MemberRelationInfo info : relationInfos) {
                String name = nameArray.get(info.getRelatedPersonId());
                result.add(new MemberRelation.Builder()
                        .setCustomerId(info.getRelatedPersonId())
                        .setRelationTypeCode(String.valueOf(info.getTypeOfRelationship()))
                        .setName(name)
                        .setRelationName(relationArray == null ? info.getRelationDescription() : relationArray.get(info.getTypeOfRelationship()))
                        .build());
            }
        }
        return result;
    }
}
