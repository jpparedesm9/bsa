package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import java.util.List;

/**
 * Created by ntrujillo on 13/07/2017.
 */
public class CreditApplicationRequest {

	private int processInstance;
	private int groupNumber;
	private String groupName;
	private int groupCycle;
	private long applicationDate;
	private int officer;
	private int office;
	private String applicationType;
	private double groupAmount;
	private String rate;
	private String term;
	private boolean promotion;
	private boolean groupAgreeRenew;
	private String reasonNotAccepting;
	private List<MemberRequest> members;
	private boolean confirmation;
	private Integer displacement;
	private String requestType;

	public int getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(int processInstance) {
		this.processInstance = processInstance;
	}

	public int getGroupNumber() {
		return groupNumber;
	}

	public boolean isConfirmation() {
		return confirmation;
	}

	public void setConfirmation(boolean confirmation) {
		this.confirmation = confirmation;
	}

	public void setGroupNumber(int groupNumber) {
		this.groupNumber = groupNumber;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public int getGroupCycle() {
		return groupCycle;
	}

	public void setGroupCycle(int groupCycle) {
		this.groupCycle = groupCycle;
	}

	public long getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(long applicationDate) {
		this.applicationDate = applicationDate;
	}

	public int getOfficer() {
		return officer;
	}

	public void setOfficer(int officer) {
		this.officer = officer;
	}

	public int getOffice() {
		return office;
	}

	public void setOffice(int office) {
		this.office = office;
	}

	public String getApplicationType() {
		return applicationType;
	}

	public void setApplicationType(String applicationType) {
		this.applicationType = applicationType;
	}

	public double getGroupAmount() {
		return groupAmount;
	}

	public void setGroupAmount(double groupAmount) {
		this.groupAmount = groupAmount;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public boolean isPromotion() {
		return promotion;
	}

	public void setPromotion(boolean promotion) {
		this.promotion = promotion;
	}

	public boolean isGroupAgreeRenew() {
		return groupAgreeRenew;
	}

	public void setGroupAgreeRenew(boolean groupAgreeRenew) {
		this.groupAgreeRenew = groupAgreeRenew;
	}

	public String getReasonNotAccepting() {
		return reasonNotAccepting;
	}

	public void setReasonNotAccepting(String reasonNotAccepting) {
		this.reasonNotAccepting = reasonNotAccepting;
	}

	public List<MemberRequest> getMembers() {
		return members;
	}

	public void setMembers(List<MemberRequest> members) {
		this.members = members;
	}

	public Integer getDisplacement() {
		return displacement;
	}

	public void setDisplacement(Integer displacement) {
		this.displacement = displacement;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}

}
