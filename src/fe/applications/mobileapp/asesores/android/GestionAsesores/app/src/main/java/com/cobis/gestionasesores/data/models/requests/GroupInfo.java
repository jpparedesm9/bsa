package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 03/08/2017.
 */
public class GroupInfo {
    private int groupId;
    private int bankCode;
    private String name;
    private int cycle;
    private String officer;
    private String office;
    private String meetingDay;
    private String meetingHour;
    private Boolean validated;
    private Boolean flagModifyGroup;

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getBankCode() {
        return bankCode;
    }

    public void setBankCode(int bankCode) {
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

    public String getOfficer() {
        return officer;
    }

    public void setOfficer(String officer) {
        this.officer = officer;
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

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }

    public Boolean getValidated() {
        return validated;
    }

    public Boolean getFlagModifyGroup() {
        return flagModifyGroup;
    }

    public void setValidated(Boolean validated) {
        this.validated = validated;
    }
}
