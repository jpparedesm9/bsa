package com.cobiscorp.ecobis.cloud.service.dto.group;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.common.OutputData;

public class MemberDataResponse implements OutputData {

    private ServiceResponse member;
    private ServiceResponse relation;

    public MemberDataResponse() {
    }

    public ServiceResponse getMember() {
        return member;
    }

    public void setMember(ServiceResponse member) {
        this.member = member;
    }

    public ServiceResponse getRelation() {
	return relation;
    }

    public void setRelation(ServiceResponse relation) {
	this.relation = relation;
    }

    @Override
    public ServiceResponse[] getResponses() {
        return new ServiceResponse[] {member, relation};
    }
}
