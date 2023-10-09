package com.cobiscorp.ecobis.customer.commons.dto;

public class GroupOtherInformationDTO {
	private String state;
	private Integer cycleNumber;
	private String meetingAddress;
	private String meetingNumberDay;
	private String meetingDay;
	private String meetingHour;
	private String branchOffice;
	private String branchOfficeDescription;
	private String score;

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getCycleNumber() {
		return cycleNumber;
	}

	public void setCycleNumber(Integer cycleNumber) {
		this.cycleNumber = cycleNumber;
	}

	public String getMeetingAddress() {
		return meetingAddress;
	}

	public void setMeetingAddress(String meetingAddress) {
		this.meetingAddress = meetingAddress;
	}

	public String getMeetingDay() {
		return meetingDay;
	}

	public void setMeetingDay(String meetingDay) {
		this.meetingDay = meetingDay;
	}

	public String getMeetingHour() {
		return meetingHour;
	}

	public void setMeetingHour(String meetingHour) {
		this.meetingHour = meetingHour;
	}

	public String getBranchOffice() {
		return branchOffice;
	}

	public void setBranchOffice(String branchOffice) {
		this.branchOffice = branchOffice;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	public String getMeetingNumberDay() {
		return meetingNumberDay;
	}

	public void setMeetingNumberDay(String meetingNumberDay) {
		this.meetingNumberDay = meetingNumberDay;
	}

	public String getBranchOfficeDescription() {
		return branchOfficeDescription;
	}

	public void setBranchOfficeDescription(String branchOfficeDescription) {
		this.branchOfficeDescription = branchOfficeDescription;
	}

}
