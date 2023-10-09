package com.cobiscorp.ecobis.cloud.service;

import com.cobiscorp.ecobis.cloud.service.dto.group.GroupRequestData;
import com.cobiscorp.ecobis.cloud.service.dto.group.MemberDataRequest;

import javax.ws.rs.core.Response;

/**
 * @author Cesar Loachamin
 */
public interface GroupService {

    Response readGroup(int groupId);

    Response createGroup(GroupRequestData data);

    Response updateGroup(GroupRequestData data);

    Response readMember(int groupId, int memberId);

    Response createMember(int groupId, MemberDataRequest data);

    Response updateMember(int groupId, MemberDataRequest data);

    Response deleteMember(int groupId, int memberId);


}
