package com.cobiscorp.ecobis.cloud.service.dto.client;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;

public class Relation {

	private int customerId;
	private int relatedCustomerId;
	private int relation;

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getRelatedCustomerId() {
		return relatedCustomerId;
	}

	public void setRelatedCustomerId(int relatedCustomerId) {
		this.relatedCustomerId = relatedCustomerId;
	}

	public int getRelation() {
		return relation;
	}

	public void setRelation(int relation) {
		this.relation = relation;
	}

	public RelationRequest toRequest() {
		RelationRequest request = new RelationRequest();
		request.setLeft(customerId);
		request.setRight(relatedCustomerId);
		request.setRelation(relation);
		request.setSide('I');
		return request;
	}

	public static List<RelationData> fromResponse(int customerId, CustomerResponse[] responses) {
		if (responses == null) {
			return null;
		}
		List<RelationData> relations = new ArrayList<RelationData>();
		for (CustomerResponse response : responses) {
			RelationData relation = new RelationData();
			relation.setRelatedPersonId(response.getCustomerDependsNum());
			relation.setTypeOfRelationship(response.getRelationId());
			relations.add(relation);
		}

		return relations;
	}
}
