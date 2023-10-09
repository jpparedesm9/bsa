package com.cobiscorp.ecobis.cloud.service.dto.group;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

import com.cobiscorp.ecobis.cloud.service.dto.client.RelationData;

import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

public class Member {

    private int customerId;
    private String bankCode;
    private String rfc;
    private String position;
    private Integer cycleNumber;
    private String name;
    private BigDecimal amountOfVoluntarySavings;
    private String riskLevel;
    private String meetingPlace;
    private List<RelationData> relations;
    private String checkRenapo;
    /*private String relatedPersonId;
    private String typeOfRelationship;*/

    public MemberRequest toRequest(int groupId) {
        MemberRequest request = new MemberRequest();
        request.setGroupId(groupId);
        request.setCustomerId(customerId);
        request.setRoleId(position);
        request.setQualificationId(riskLevel);
        if (amountOfVoluntarySavings != null) {
            request.setSavingVoluntary(amountOfVoluntarySavings.doubleValue());
        }
        request.setMeetingPlace(meetingPlace);
        request.setMembershipDate(Calendar.getInstance());//TODO: Review with Manuel
        request.setStateId("V"); //TODO: Review with Manuel
        return request;
    }

    public static Member fromResponse(MemberResponse response) {
        if (response == null) {
            return null;
        }
        Member member = new Member();
        member.customerId = response.getCustomerId();
        member.position = response.getRoleId();
        member.riskLevel = response.getQualificationId();
        member.amountOfVoluntarySavings = new BigDecimal(response.getSavingVoluntary());
        member.meetingPlace = response.getMeetingPlace();
        member.name = response.getCustomer();
        member.cycleNumber = response.getCicle();
        member.checkRenapo = response.getCheckRenapo();
        return member;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Integer getCycleNumber() {
        return cycleNumber;
    }

    public void setCycleNumber(Integer cycleNumber) {
        this.cycleNumber = cycleNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getAmountOfVoluntarySavings() {
        return amountOfVoluntarySavings;
    }

    public void setAmountOfVoluntarySavings(BigDecimal amountOfVoluntarySavings) {
        this.amountOfVoluntarySavings = amountOfVoluntarySavings;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    public String getMeetingPlace() {
        return meetingPlace;
    }

    public void setMeetingPlace(String meetingPlace) {
        this.meetingPlace = meetingPlace;
    }

	public List<RelationData> getRelations() {
		return relations;
	}

	public void setRelations(List<RelationData> relations) {
		this.relations = relations;
	}

	public String getCheckRenapo() {
		return checkRenapo;
	}

	public void setCheckRenapo(String checkRenapo) {
		this.checkRenapo = checkRenapo;
	}

}
