package com.cobiscorp.ecobis.cloud.service.dto.group;

import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

import java.util.Calendar;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.toInt;

public class Group {
	private int groupId;
	private String bankCode;
	private String name;
	private int cycle;
	private String meetingDay;
	private String meetingHour; // Calendar
	private boolean validated;
	private boolean flagModifyGroup; // Movil
	private String msmFlagModifyGroup;

	public GroupRequest toRequest() {
		GroupRequest request = new GroupRequest();
		request.setCode(groupId);
		request.setNameGroup(name);
		request.setCycleNumber(cycle);
		request.setGroupOffice(SessionUtil.getOffice());
		request.setDay(meetingDay);
		request.setTime(CalendarUtil.fromISOTime(meetingHour));
		request.setConstitutionDate(Calendar.getInstance());
		request.setNextVisitDate(Calendar.getInstance()); // Default values
		request.setState("V");// Default values
		request.setMeetingAddres(" ");// TODO: Review with Manuel
		request.setGroupType("S");
		return request;
	}

	public static Group fromResponse(GroupResponse response) {
		Group group = new Group();
		group.groupId = response.getCode();
		group.name = response.getNameGroup();
		group.cycle = toInt(response.getCycleNumber());
		group.meetingDay = response.getDay();
		group.meetingHour = CalendarUtil.toISOTime(response.getTime());
		if (response.getUpdateGroupMovil() == 'S') {
			group.flagModifyGroup = true;
		} else {
			group.flagModifyGroup = false;
		}
		group.msmFlagModifyGroup=response.getMsmUpdateGroupMovil();//msm cuando el grupo no puede ser modificado
		return group;
	}

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCycle() {
		return cycle;
	}

	public void setCycle(int cycle) {
		this.cycle = cycle;
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

	public boolean isValidated() {
		return validated;
	}

	public void setValidated(boolean validated) {
		this.validated = validated;
	}

	public boolean isFlagModifyGroup() {
		return flagModifyGroup;
	}

	public void setFlagModifyGroup(boolean flagModifyGroup) {
		this.flagModifyGroup = flagModifyGroup;
	}

	public String getMsmFlagModifyGroup() {
		return msmFlagModifyGroup;
	}

	public void setMsmFlagModifyGroup(String msmFlagModifyGroup) {
		this.msmFlagModifyGroup = msmFlagModifyGroup;
	}
	
	

}
