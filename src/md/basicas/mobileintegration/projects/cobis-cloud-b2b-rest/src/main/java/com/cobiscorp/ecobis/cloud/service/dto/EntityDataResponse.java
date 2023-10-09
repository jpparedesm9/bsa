package com.cobiscorp.ecobis.cloud.service.dto;

import java.util.List;

import cobiscorp.ecobis.businesstobusiness.dto.CustomerGroupResponse;

public class EntityDataResponse {

	private List<CustomerGroupResponse> entity;

	public List<CustomerGroupResponse> getEntity() {
		return entity;
	}

	public void setEntity(List<CustomerGroupResponse> entity) {
		this.entity = entity;
	}

}
