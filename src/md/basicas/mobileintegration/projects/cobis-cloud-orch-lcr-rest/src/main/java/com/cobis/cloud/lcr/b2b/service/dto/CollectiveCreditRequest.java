package com.cobis.cloud.lcr.b2b.service.dto;

import java.util.List;

import com.cobiscorp.ecobis.cloud.service.dto.client.CollectiveCustomer;

public class CollectiveCreditRequest {

	private int instanceProcess;
	private int instanceActivity;
	private int applicationId;
	private int customerId;
	private String decision;
	private List<RevolvingUpdateDocumentRequest> documents;
	private CollectiveCustomer collectiveCustomer;

	public int getInstanceProcess() {
		return instanceProcess;
	}

	public void setInstanceProcess(int instanceProcess) {
		this.instanceProcess = instanceProcess;
	}

	public int getInstanceActivity() {
		return instanceActivity;
	}

	public void setInstanceActivity(int instanceActivity) {
		this.instanceActivity = instanceActivity;
	}

	public String getDecision() {
		return decision;
	}

	public void setDecision(String decision) {
		this.decision = decision;
	}

	public List<RevolvingUpdateDocumentRequest> getDocuments() {
		return documents;
	}

	public void setDocuments(List<RevolvingUpdateDocumentRequest> documents) {
		this.documents = documents;
	}

	public int getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(int applicationId) {
		this.applicationId = applicationId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public CollectiveCustomer getCollectiveCustomer() {
		return collectiveCustomer;
	}

	public void setCollectiveCustomer(CollectiveCustomer collectiveCustomer) {
		this.collectiveCustomer = collectiveCustomer;
	}

}
