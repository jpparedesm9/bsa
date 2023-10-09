package com.cobis.gestionasesores.data.models.requests;

import java.util.List;

/**
 * Created by mnaunay on 08/08/2017.
 */

public class GroupCreditInfo {
    private int processInstance;
    private int groupNumber;
    private String groupName;
    private int groupCycle;
    private String applicationDate;
    private String applicationType;
    private double groupAmount;
    private String rate;
    private String term;
    private boolean promotion;
    private boolean groupAgreeRenew;
    private boolean confirmation;
    private String reasonNotAccepting;
    private Boolean flagModifyApplication;
    private List<MemberCreditInfo> members;

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

    public List<MemberCreditInfo> getMembers() {
        return members;
    }

    public void setMembers(List<MemberCreditInfo> members) {
        this.members = members;
    }

    public boolean isConfirmation() {
        return confirmation;
    }

    public void setConfirmation(boolean confirmation) {
        this.confirmation = confirmation;
    }

    public Boolean getFlagModifyApplication() {
        return flagModifyApplication;
    }

    public void setFlagModifyApplication(Boolean flagModifyApplication) {
        this.flagModifyApplication = flagModifyApplication;
    }
}
