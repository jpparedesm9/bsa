package com.cobiscorp.ecobis.cloud.service.dto.group;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class GroupResponse {

	private ServiceResponse group;
	private ServiceResponse members;

	public GroupResponse() {
	}

	public GroupResponse(ServiceResponse group) {
		this.group = group;
	}

	public ServiceResponse getGroup() {
		return group;
	}

	public void setGroup(ServiceResponse group) {
		this.group = group;
	}

	public ServiceResponse getMembers() {
		return members;
	}

	public void setMembers(ServiceResponse members) {
		this.members = members;
	}

}
