package com.cobis.gestionasesores.domain.businesslogic;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;
import com.cobis.gestionasesores.data.repositories.GroupRepository;
import com.cobis.gestionasesores.data.source.CreditAppDataSource;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.List;

public class GroupOperation {

    private GroupDataSource mGroupDataSource;
    private CreditAppDataSource mCreditAppDataSource;

    public GroupOperation() {
        mGroupDataSource = GroupRepository.getInstance();
        mCreditAppDataSource = CreditAppRepository.getInstance();
    }

    public ResultData saveMember(int groupId, Member member) throws Exception {
        Group group = mGroupDataSource.getById(groupId);
        return saveMember(group, member, false);
    }

    public ResultData saveMember(Group group, Member member, boolean isSync) throws Exception {
        ResultData resultData = mGroupDataSource.saveMember(group, member, isSync);
        //update
        if (resultData.getType() == ResultType.SUCCESS && group.getId() > 0) {
            mCreditAppDataSource.updateMembersGroup(mGroupDataSource.getById(group.getId()));
            mGroupDataSource.updateMemberRelations(group.getId());
        }

        return resultData;
    }

    public ResultData deleteMember(int groupId, Member member) throws Exception {
        ResultData resultData = mGroupDataSource.deleteMember(groupId, member);
        //update
        if (resultData.getType() == ResultType.SUCCESS && groupId > 0) {
            mCreditAppDataSource.updateMembersGroup(mGroupDataSource.getById(groupId));
            mGroupDataSource.updateMemberRelations(groupId);
        }
        return resultData;
    }

    public ResultData removeMemberRelation(int groupId, Member currentMember, int memberToRemoveId) throws Exception {
        Group group = mGroupDataSource.getById(groupId);

        List<Member> members = group.getMembers();
        if (members != null) {
            for (Member member : members) {
                if (member.getServerId() == currentMember.getServerId()) {
                    currentMember.removeMemberRelation(memberToRemoveId);
                    member.removeMemberRelation(memberToRemoveId);
                }
                if (member.getServerId() == memberToRemoveId) {
                    member.removeMemberRelation(member.getServerId());
                }
            }
        }

        return saveMember(group, currentMember, false);
    }
}
