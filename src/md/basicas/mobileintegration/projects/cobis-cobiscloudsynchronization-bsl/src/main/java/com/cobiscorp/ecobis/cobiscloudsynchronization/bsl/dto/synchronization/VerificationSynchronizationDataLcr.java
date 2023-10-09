package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DocumentLcr;

@XmlRootElement(name = "verificationLcrDocument")
public class VerificationSynchronizationDataLcr {

	private int customerId;
	private String customerName;
	private int instanceProcess;
	private int instanceActivity;
	private int stepActivity;
	private List<DocumentLcr> documentList;
	
	
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
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
	public int getStepActivity() {
		return stepActivity;
	}
	public void setStepActivity(int stepActivity) {
		this.stepActivity = stepActivity;
	}
	public List<DocumentLcr> getDocumentList() {
		return documentList;
	}
	public void setDocumentList(List<DocumentLcr> documentList) {
		this.documentList = documentList;
	}

	

}
