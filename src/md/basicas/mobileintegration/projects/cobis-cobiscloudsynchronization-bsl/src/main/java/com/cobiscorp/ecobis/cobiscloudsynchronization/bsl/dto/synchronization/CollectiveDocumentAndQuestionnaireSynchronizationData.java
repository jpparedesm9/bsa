package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import com.cobiscorp.ecobis.cloud.service.dto.client.CollectiveCustomer;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DocumentLcr;

@XmlRootElement(name = "collectiveDocumentSyncronizedData")
public class CollectiveDocumentAndQuestionnaireSynchronizationData {

	private int clientId;
	private String clientName;
	private int instanceProcess;
	private int instanceActivity;
	private String activityName;
	private int stepActivity;
	private int applicationId;
	private Long date;
	private List<DocumentLcr> documentList;
	private CollectiveCustomer collectiveCustomer;

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

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

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public int getStepActivity() {
		return stepActivity;
	}

	public void setStepActivity(int stepActivity) {
		this.stepActivity = stepActivity;
	}

	public int getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(int applicationId) {
		this.applicationId = applicationId;
	}

	public long getDate() {
		return date;
	}

	public void setDate(long date) {
		this.date = date;
	}

	public List<DocumentLcr> getDocumentList() {
		return documentList;
	}

	public void setDocumentList(List<DocumentLcr> documentList) {
		this.documentList = documentList;
	}

	public CollectiveCustomer getCollectiveCustomer() {
		return collectiveCustomer;
	}

	public void setCollectiveCustomer(CollectiveCustomer collectiveCustomer) {
		this.collectiveCustomer = collectiveCustomer;
	}
}
