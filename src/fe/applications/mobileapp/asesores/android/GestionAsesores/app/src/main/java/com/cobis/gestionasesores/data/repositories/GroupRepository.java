package com.cobis.gestionasesores.data.repositories;

import android.util.SparseArray;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.NetworkUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.mappers.GroupCreditAppMapper;
import com.cobis.gestionasesores.data.mappers.GroupMapper;
import com.cobis.gestionasesores.data.mappers.RelationMapper;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberRelation;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.requests.MemberInfo;
import com.cobis.gestionasesores.data.models.requests.ValidGroupRemote;
import com.cobis.gestionasesores.data.models.responses.GroupRemote;
import com.cobis.gestionasesores.data.models.responses.MemberResponse;
import com.cobis.gestionasesores.data.models.responses.SaveGroupResponse;
import com.cobis.gestionasesores.data.models.responses.ValidGroupResponse;
import com.cobis.gestionasesores.data.source.GroupDataSource;
import com.cobis.gestionasesores.data.source.local.PersistenceGroup;
import com.cobis.gestionasesores.data.source.remote.CreditAppService;
import com.cobis.gestionasesores.data.source.remote.GroupService;
import com.cobis.gestionasesores.presentation.group.GroupPresenter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Created by mnaunay on 16/06/2017.
 */

public class GroupRepository implements GroupDataSource {
    private static GroupRepository INSTANCE;

    public static GroupRepository getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new GroupRepository();
        }
        return INSTANCE;
    }

    private GroupRepository() {
    }

    @Override
    public ResultData save(Group group, boolean isSync) throws Exception {
        ResultData resultData;
        if (NetworkUtils.isOnline()) {
            resultData = saveGroupRemote(group, isSync);
            group = (Group) resultData.getData();
            group.setStatus(getGroupStatus(group));
            if (resultData.getType() == ResultType.SUCCESS || isSync) {
                resultData = saveGroupLocal(group);
            }
        } else {
            group.setErrorMsg(null);
            int status = getStatusFromMembers(group.getMembers());
            if (status == SyncStatus.SYNCED) {
                status = SyncStatus.PENDING;
            }
            group.setStatus(status);
            resultData = saveGroupLocal(group);
        }
        return resultData;
    }

    @Override
    public ResultData saveMember(Group group, Member member, boolean isSync) throws Exception {
        ResultData resultData;
        if (NetworkUtils.isOnline() && group.getServerId() > 0) {
            resultData = saveMemberRemote(group.getServerId(), member, isSync);
            if (resultData.getType() == ResultType.SUCCESS || isSync) {
                resultData = saveMemberLocal(group, (Member) resultData.getData());
                //Need to reset status in case of error status so that status is defined by member
                group.setStatus(SyncStatus.UNKNOWN);
                group.setErrorMsg(null);
                group.setStatus(getGroupStatus(group));
                saveGroupLocal(group);
            }
        } else {
            member.setStatus(SyncStatus.PENDING);
            member.setErrorMsg(null);
            resultData = saveMemberLocal(group, member);
            //Need to reset status in case of error status so that status is defined by member
            group.setStatus(SyncStatus.UNKNOWN);
            group.setErrorMsg(null);
            group.setStatus(getGroupStatus(group));
            saveGroupLocal(group);
        }
        return resultData;
    }

    @Override
    public ResultData deleteMember(int localGroupId, Member member) throws Exception {
        ResultData resultData = null;
        if (member.isSyncedToServer()) {
            if (NetworkUtils.isOnline()) {
                resultData = deleteMemberRemote(localGroupId, member);
            }
        } else {
            resultData = deleteMemberLocal(localGroupId, member);
        }
        return resultData;
    }

    @Override
    public ResultData delete(final int id) {
        PersistenceGroup persistence = null;
        ResultData result;
        try {
            persistence = new PersistenceGroup();
            result = new ResultData(persistence.deleteGroup(id) ? ResultType.SUCCESS : ResultType.FAILURE, null);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        //update person data
        if (result.getType() == ResultType.SUCCESS) {
            PersonRepository.getInstance().deleteRelationGroup(id);
        }
        return result;
    }

    @Override
    public Group getById(final int id) {
        PersistenceGroup persistence = null;
        Group result;
        try {
            persistence = new PersistenceGroup();
            result = persistence.getById(id);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public Group getGroup(int localId) throws Exception {
        Group localGroup = getById(localId);
        int serverId = localGroup.getServerId();
        if (NetworkUtils.isOnline() && serverId > 0) {
            Group remoteGroup = getGroupRemote(serverId);
            if (remoteGroup != null) {
                localGroup.merge(remoteGroup);
                saveGroupLocal(localGroup);
                PersonRepository.getInstance().cleanUpPersonRelationsGroup(localGroup);
                updateMemberRelations(localGroup.getId());
            }
        }
        return localGroup;
    }

    @Override
    public Member getMember(int localGroupId, int memberServerId) throws Exception {
        Group localGroup = getById(localGroupId);

        Member localMember = null;

        List<Member> members = localGroup.getMembers();
        for (Member m : members) {
            if (m.getServerId() == memberServerId) {
                localMember = m;
                break;
            }
        }
        if (localMember != null && NetworkUtils.isOnline()) {
            SparseArray<String> nameArray = new SparseArray<>();
            for (Member m : localGroup.getMembers()) {
                nameArray.put(m.getServerId(), m.getName());
            }

            Member remoteMember = getMemberRemote(localGroup.getServerId(), memberServerId, nameArray);
            if (remoteMember != null) {
                localMember.merge(remoteMember);
                saveMemberLocal(localGroup, localMember);
                // TODO: 10/3/2017 handle removed relationships
                updateMemberRelations(localGroupId);
            }

            Person person = PersonRepository.getInstance().getPersonByServerId(localMember.getServerId());

            if (person != null) {
                localMember.setRfc(person.getDocument());
                Section section = Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections());
                CustomerData customerData = (CustomerData) section.getSectionData();
                if (customerData != null) {
                    localMember.setCustomerNumber(customerData.getCustomerNumber());
                }
            }
        }
        return localMember;
    }

    @Override
    public List<Group> getAllGroups(@SyncStatus int status, String keyword) {
        PersistenceGroup persistence = null;
        try {
            persistence = new PersistenceGroup();
            return persistence.getGroups(keyword, status);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
    }

    @Override
    public List<Group> getForCreditApp(String keyword, List<Group> groups) throws Exception {
        List<Group> localGroups = null;
        if(groups != null){
            localGroups = new ArrayList<>();
            localGroups.addAll(groups);
        }
        if (localGroups == null) {
            localGroups = getLocalGroupsForCredit();

            if (localGroups != null && !localGroups.isEmpty() && NetworkUtils.isOnline()) {
                localGroups = filterGroupsForCredit(localGroups);
            }
        }

        if (StringUtils.isNotEmpty(keyword)) {
            localGroups = filterByName(localGroups, keyword);
        }

        return localGroups;
    }

    private List<Group> filterByName(List<Group> groups, String keyword) {
        List<Group> result = new ArrayList<>();
        for (Group group : groups) {
            if (Pattern.compile(Pattern.quote(keyword), Pattern.CASE_INSENSITIVE).matcher(group.getName()).find()) {
                result.add(group);
            }
        }
        return result;
    }

    private List<Group> filterGroupsForCredit(List<Group> groups) throws Exception {
        ValidGroupResponse response = new CreditAppService().getValidGroups(GroupCreditAppMapper.validGroupsFromGroups(groups));
        if (response.isResult()) {
            SparseArray<Group> sparseArray = new SparseArray<>();
            for (Group group : groups) {
                sparseArray.put(group.getServerId(), group);
            }
            for (ValidGroupRemote remote : response.getData()) {
                if (remote.getAvailableForCredit() == null || !remote.getAvailableForCredit()) {
                    sparseArray.remove(remote.getGroupId());
                }
            }
            groups = new ArrayList<>();
            for (int i = 0; i < sparseArray.size(); i++) {
                groups.add(sparseArray.get(sparseArray.keyAt(i)));
            }
        } else {
            throw new RuntimeException("Error in filterGroupsForCredit");
        }
        return groups;
    }

    private List<Group> getLocalGroupsForCredit() {
        PersistenceGroup persistence = null;
        List<Group> result;
        try {
            persistence = new PersistenceGroup();
            result = persistence.getAllWithoutCredit();
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public int countGroups(@SyncStatus int status) {
        int count = 0;
        PersistenceGroup persistence = null;
        try {
            persistence = new PersistenceGroup();
            count = persistence.countByStatus(status);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return count;
    }

    private ResultData saveGroupRemote(Group group, boolean isSync) throws Exception {
        ResultData resultData;
        GroupService service = new GroupService();
        SaveGroupResponse groupResponse;
        if (group.getServerId() > 0) {
            groupResponse = service.updateGroup(GroupMapper.groupToGroupRequest(group, isSync));
        } else {
            groupResponse = service.createGroup(GroupMapper.groupToGroupRequest(group, isSync));
            if (groupResponse.getData() != null) {
                group.setServerId(groupResponse.getData().getGroupId());
            }
        }

        if (groupResponse.isResult()) {
            group.setErrorMsg(null);
            group.setAction(null);
            resultData = new ResultData(ResultType.SUCCESS, groupResponse.getFirstMessage(), group);
        } else {
            group.setStatus(SyncStatus.ERROR);
            group.setErrorMsg(groupResponse.getFirstMessage());
            resultData = new ResultData(ResultType.FAILURE, groupResponse.getFirstMessage(), group);
        }
        return resultData;
    }

    @Override
    public ResultData saveGroupLocal(Group group) {
        PersistenceGroup persistence = null;
        int groupId = -1;
        try {
            persistence = new PersistenceGroup();
            groupId = persistence.saveOrUpdate(group);
            group.setId(groupId);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return new ResultData(groupId > 0 ? ResultType.SUCCESS : ResultType.FAILURE, null, groupId > 0 ? group : null);
    }

    @Override
    public void updateMemberRelations(int id) {
        Group group = getById(id);
        List<Member> members = group.getMembers();

        if (members != null) {
            SparseArray<Member> memberSparseArray = new SparseArray<>();

            for (Member member : members) {
                memberSparseArray.put(member.getServerId(), member);
            }

            List<CatalogItem> relationshipCatalog = CatalogRepository.getInstance().getCatalogItemsByCode(Catalog.CAT_FAMILY_RELATIONSHIP);

            Map<String, String> relationMap = new HashMap<>();
            if (relationshipCatalog != null) {
                for (CatalogItem catalogItem : relationshipCatalog) {
                    relationMap.put(catalogItem.getCode(), catalogItem.getValue());
                }
            }

            List<MemberRelation> memberRelations;
            for (Member member : members) {
                memberRelations = member.getRelationships();
                if (memberRelations != null) {
                    for (Iterator<MemberRelation> iterator = memberRelations.iterator(); iterator.hasNext(); ) {
                        MemberRelation relation = iterator.next();
                        if (memberSparseArray.get(relation.getCustomerId()) == null) {
                            iterator.remove();
                        } else {
                            String relationCode = RelationMapper.getCorelation(relation.getRelationTypeCode());
                            memberSparseArray.get(relation.getCustomerId())
                                    .addMemberRelation(new MemberRelation.Builder()
                                            .setCustomerId(member.getServerId())
                                            .setName(member.getName())
                                            .setRelationName(relationMap.get(relationCode))
                                            .setRelationTypeCode(relationCode)
                                            .build());
                        }
                    }
                }
            }

            members = new ArrayList<>();
            for (int i = 0; i < memberSparseArray.size(); i++) {
                members.add(memberSparseArray.get(memberSparseArray.keyAt(i)));
            }
            group.setMembers(members);
            saveGroupLocal(group);
        }
    }

    private ResultData saveMemberRemote(int groupId, Member member, boolean isSync) throws Exception {
        MemberResponse memberResponse;
        GroupService groupService = new GroupService();
        if (member.isSyncedToServer()) {
            memberResponse = groupService.updateMember(groupId, GroupMapper.memberToMemberRequest(member, isSync));
        } else {
            memberResponse = groupService.createMember(groupId, GroupMapper.memberToMemberRequest(member, isSync));
            member.setSyncedToServer(memberResponse.isResult());
        }
        if (memberResponse.isResult()) {
            member.setStatus(SyncStatus.SYNCED);
            member.setErrorMsg(null);
            member.setAction(null);
            return new ResultData(ResultType.SUCCESS, memberResponse.getFirstMessage(), member);
        } else {
            member.setStatus(SyncStatus.ERROR);
            member.setErrorMsg(memberResponse.getFirstMessage());
            return new ResultData(ResultType.FAILURE, memberResponse.getFirstMessage(), member);
        }
    }

    private ResultData saveMemberLocal(Group group, Member member) {
        List<Member> members = group.getMembers();
        if (members == null) {
            members = new ArrayList<>();
        }

        if (group.containsMember(member)) {
            for (int i = 0; i < members.size(); i++) {
                if (members.get(i).getServerId() == member.getServerId()) {
                    members.set(i, member);
                    break;
                }
            }
        } else {
            members.add(member);
        }
        ResultData result = saveGroupLocal(group);
        result.setData(group.getMembers().size());

        //update person data
        if (result.getType() == ResultType.SUCCESS && member.getServerId() > 0) {
            PersonRepository.getInstance().updateRelationGroup(member.getServerId(), group.getId());
        }
        return result;
    }

    private ResultData deleteMemberRemote(int groupId, Member member) throws Exception {
        Group group = getById(groupId);
        MemberResponse memberResponse = new GroupService().deleteMember(group.getServerId(), member.getServerId());
        boolean isDeleted = memberResponse.isResult();
        if (isDeleted) {
            group.removeMember(member);

            //Need to reset status in case of error status so that status is defined by member
            group.setStatus(SyncStatus.UNKNOWN);
            group.setErrorMsg(null);
            group.setStatus(getGroupStatus(group));
            ResultData deleteLocalResult = saveGroupLocal(group);
            isDeleted = deleteLocalResult.getType() == ResultType.SUCCESS;
            updateRelationGroup(deleteLocalResult, member);
        }
        return new ResultData(isDeleted ? ResultType.SUCCESS : ResultType.FAILURE, memberResponse.getFirstMessage(), group.getMembers().size());
    }

    private ResultData deleteMemberLocal(int groupId, Member member) {
        Group group = getById(groupId);
        group.removeMember(member);

        //Need to reset status in case of error status so that status is defined by member
        group.setStatus(SyncStatus.UNKNOWN);
        group.setErrorMsg(null);
        group.setStatus(getGroupStatus(group));
        ResultData deleteLocalResult = saveGroupLocal(group);
        updateRelationGroup(deleteLocalResult, member);
        return new ResultData(deleteLocalResult.getType(), null, group.getMembers().size());
    }

    private void updateRelationGroup(ResultData resultDelete, Member member) {
        if (resultDelete.getType() == ResultType.SUCCESS && member.getServerId() > 0) {
            PersonRepository.getInstance().updateRelationGroup(member.getServerId(), -1);
        }
    }

    private Group getGroupRemote(int serverId) {
        Group group = null;
        try {
            GroupRemote remote = new GroupService().getGroup(serverId);
            group = GroupMapper.fromRemote(remote);
        } catch (Exception ex) {
            Log.e("Group Repository: getGroupRemote! ", ex);
        }
        return group;
    }

    private Member getMemberRemote(int groupServerId, int memberServerId, SparseArray<String> nameArray) {
        Member member = null;
        try {
            List<CatalogItem> relationships = CatalogRepository.getInstance().getCatalogItemsByCode(Catalog.CAT_FAMILY_RELATIONSHIP);

            SparseArray<String> relationArray = new SparseArray<>();

            for (CatalogItem item : relationships) {
                relationArray.put(ConvertUtils.tryToInt(item.getCode(), 0), item.getValue());
            }

            MemberInfo remote = new GroupService().getMember(groupServerId, memberServerId);
            member = GroupMapper.memberInfoToMember(remote, nameArray, relationArray);
        } catch (Exception ex) {
            Log.e("Group Repository: getMemberRemote! ", ex);
        }
        return member;
    }


    @SyncStatus
    private int getGroupStatus(Group group) {
        int status;
        if (group.getStatus() == SyncStatus.ERROR) {
            return SyncStatus.ERROR;
        } else {
            status = getStatusFromMembers(group.getMembers());
        }
        return status;
    }

    @SyncStatus
    private int getStatusFromMembers(List<Member> members) {
        if (members == null) {
            return SyncStatus.DRAFT;
        }

        int status;
        int error = 0, synced = 0;
        int minMembers = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_MEMBER);
        boolean hasMeetingLocation = GroupPresenter.getMeetingLocation(members) != null;

        for (Member member : members) {
            switch (member.getStatus()) {
                case SyncStatus.ERROR:
                    error++;
                    break;
                case SyncStatus.SYNCED:
                    synced++;
                    break;
            }
        }
        if (error > 0) {
            status = SyncStatus.ERROR;
        } else if (members.size() < minMembers || !hasMeetingLocation) {
            status = SyncStatus.DRAFT;
        } else if (synced == members.size() && synced >= minMembers && hasMeetingLocation) {
            status = SyncStatus.SYNCED;
        } else {
            status = SyncStatus.PENDING;
        }
        return status;
    }
}
