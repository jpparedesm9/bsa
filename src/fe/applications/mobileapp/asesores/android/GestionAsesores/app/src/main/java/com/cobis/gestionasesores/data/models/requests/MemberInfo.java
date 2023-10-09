package com.cobis.gestionasesores.data.models.requests;

import com.cobis.gestionasesores.data.models.responses.MemberRelationInfo;

import java.util.List;

/**
 * Created by bqtdesa02 on 8/3/2017.
 */

public class MemberInfo {
    private int customerId;
    private String bankCode;
    private String rfc;
    private String position;
    private int cycle;
    private String name;
    private double amountOfVoluntarySavings;
    private String riskLevel;
    private String meetingPlace;
    private List<MemberRelationInfo> relations;

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

    public int getCycle() {
        return cycle;
    }

    public void setCycle(int cycle) {
        this.cycle = cycle;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getAmountOfVoluntarySavings() {
        return amountOfVoluntarySavings;
    }

    public void setAmountOfVoluntarySavings(double amountOfVoluntarySavings) {
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

    public List<MemberRelationInfo> getRelations() {
        return relations;
    }

    public void setRelations(List<MemberRelationInfo> relations) {
        this.relations = relations;
    }
}
