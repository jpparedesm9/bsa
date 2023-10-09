package com.cobiscorp.mobile.request;

public class DocumentUploadRequest {

	private int customerId;
	private int documentId;
	private int processId;
	private int groupId;

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getDocumentId() {
		return documentId;
	}

	public void setDocumentId(int documentId) {
		this.documentId = documentId;
	}

	public int getProcessId() {
		return processId;
	}

	public void setProcessId(int processId) {
		this.processId = processId;
	}

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	@Override
	public String toString() {
		return "DocumentUploadRequest [customerId=" + customerId + ", documentId=" + documentId + ", processId="
				+ processId + ", groupId=" + groupId + "]";
	}

}
