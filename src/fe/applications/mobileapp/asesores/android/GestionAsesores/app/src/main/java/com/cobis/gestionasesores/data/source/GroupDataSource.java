package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.ResultData;

import java.util.List;

public interface GroupDataSource {
    ResultData save(Group group, boolean isSync) throws Exception;

    ResultData saveMember(Group group, Member member, boolean isSync) throws Exception;

    ResultData deleteMember(int groupId, Member member) throws Exception;

    Group getById(int id);

    Group getGroup(int localId) throws Exception;

    Member getMember(int localGroupId, int memberServerId) throws Exception;

    ResultData delete(int id);

    List<Group> getAllGroups(@SyncStatus int status, String keyword);

    List<Group> getForCreditApp(String keyword, List<Group> groups) throws Exception;

    int countGroups(@SyncStatus int status);

    ResultData saveGroupLocal(Group group);

    void updateMemberRelations(int id);
}