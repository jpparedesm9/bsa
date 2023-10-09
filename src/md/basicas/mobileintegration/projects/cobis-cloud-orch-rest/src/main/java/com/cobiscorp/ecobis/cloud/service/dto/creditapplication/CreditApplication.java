package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.ecobis.cloud.service.integration.ApplicationService;

import cobiscorp.ecobis.loangroup.dto.ApplicationGroupResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;

public class CreditApplication {
	private int processInstance;
	private int groupNumber;
	private String groupName;
	private int groupCycle;
	private String applicationDate;
	private String officer;
	private String office;
	private String applicationType;
	private double groupAmount;
	private String rate;
	private String term;
	private boolean promotion;
	private boolean groupAgreeRenew;
	private String reasonNotAccepting;
	private boolean flagModifyApplication; // Movil
	private Integer displacement;
	private List<MemberRequest> members;

	// / Aca poner el mapeo de la información
	public static CreditApplication fromResponse(int applicationId, ApplicationGroupResponse response, ApplicationService applicationService) {
		CreditApplication creditApplication = new CreditApplication();

		if (response != null) {
			creditApplication.processInstance = response.getProcessInstance();
			creditApplication.groupNumber = response.getGroupNumber();

			creditApplication.groupName = response.getGroupName();
			creditApplication.groupCycle = response.getGroupCycle();
			creditApplication.applicationDate = response.getApplicationDate();
			creditApplication.officer = response.getOfficer();
			creditApplication.office = response.getOffice();
			creditApplication.applicationType = response.getApplicationType();
			creditApplication.groupAmount = response.getGroupAmount();
			creditApplication.rate = response.getRate();
			creditApplication.term = response.getTerm() == null ? null : String.valueOf(response.getTerm());
			creditApplication.displacement = response.getDisplacement() == null ? null : Integer.valueOf(response.getDisplacement());
			if (response.getPromotion() != null) {
				if (response.getPromotion() == 'S') {
					creditApplication.promotion = true;
				} else {
					creditApplication.promotion = false;
				}
			}

			if (response.getGroupAgreeRenew() != null) {
				if (response.getGroupAgreeRenew() == 'S') {
					creditApplication.groupAgreeRenew = true;
				} else {
					creditApplication.groupAgreeRenew = false;
				}
			}

			creditApplication.reasonNotAccepting = response.getReasonNotAccepting();
			if (response.getFlagModifyApplication() != null) {
				if (response.getFlagModifyApplication() == 'S') {
					creditApplication.flagModifyApplication = true;
				} else {
					creditApplication.flagModifyApplication = false;
				}
			}

			List<MemberRequest> memberRequest = new ArrayList<MemberRequest>();

			GroupLoanAmountResponse[] groupLoanAmountResponse = applicationService.searchAmount(applicationId);
			if (groupLoanAmountResponse != null) {
				for (GroupLoanAmountResponse groupLoanAmount : groupLoanAmountResponse) {
					MemberRequest mr = new MemberRequest();
					mr.setRole(groupLoanAmount.getRole());
					mr.setCycleNumber(groupLoanAmount.getCycleNumber());
					mr.setCode(groupLoanAmount.getCustomerId());
					mr.setRfc(groupLoanAmount.getRfc());
					mr.setName(groupLoanAmount.getCustumerName());

					if (groupLoanAmount.getCycleParticipation() != null) {
						if (groupLoanAmount.getCycleParticipation() == 'S') {
							mr.setParticipant(true);
						} else {
							mr.setParticipant(false);
						}
					}

					mr.setAmountRequestedOriginal(groupLoanAmount.getAmount());
					mr.setAuthorizedAmount(groupLoanAmount.getAuthorizedAmount());
					mr.setLiquidGuarantee(groupLoanAmount.getLiquidGuarantee());
					mr.setVoluntarySavings(groupLoanAmount.getVoluntarySavings());
					mr.setProposedMaximumAmount(groupLoanAmount.getProposedMaximumSaving());
					mr.setRiskLevel(groupLoanAmount.getRiskLevel());
					memberRequest.add(mr);
				}
			}
			creditApplication.members = memberRequest;

		}

		return creditApplication;
	}

	public int getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(int processInstance) {
		this.processInstance = processInstance;
	}

	public int getGroupNumber() {
		return groupNumber;
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

	public String getApplicationDate() {
		return applicationDate;
	}

	public void setApplicationDate(String applicationDate) {
		this.applicationDate = applicationDate;
	}

	public String getOfficer() {
		return officer;
	}

	public void setOfficer(String officer) {
		this.officer = officer;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
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

	public boolean isFlagModifyApplication() {
		return flagModifyApplication;
	}

	public void setFlagModifyApplication(boolean flagModifyApplication) {
		this.flagModifyApplication = flagModifyApplication;
	}

	public Integer getDisplacement() {
		return displacement;
	}

	public void setDisplacement(Integer displacement) {
		this.displacement = displacement;
	}

}
