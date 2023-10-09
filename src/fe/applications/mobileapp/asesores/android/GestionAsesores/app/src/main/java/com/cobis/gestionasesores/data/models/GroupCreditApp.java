package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.CreditAppType;

import java.util.List;

/**
 * Represent a group credit application request
 * Created by mnaunay on 22/06/2017.
 */
public class GroupCreditApp extends CreditApp {
    private int cycle;
    private String adviser;
    private String branchOffice;
    private String rate;
    private String term;
    private boolean isPromotion;
    private boolean isRenew;
    private String reason;
    private int groupServerId;
    private boolean canEdit;
    private List<MemberCreditApp> memberCreditApps;

    /**
     * Default constructor is used for JSON parse
     */
    GroupCreditApp() {
        super(CreditAppType.GROUP);
    }

    private GroupCreditApp(Builder builder) {
        super(builder);
        canEdit = builder.canEdit;
        cycle = builder.cycle;
        adviser = builder.adviser;
        branchOffice = builder.branchOffice;
        rate = builder.rate;
        term = builder.term;
        isPromotion = builder.isPromotion;
        isRenew = builder.isRenew;
        reason = builder.reason;
        groupServerId = builder.groupServerId;
        memberCreditApps = builder.memberCreditApps;
        action = builder.serverAction;
    }

    public int getCycle() {
        return cycle;
    }

    public String getAdviser() {
        return adviser;
    }

    public String getBranchOffice() {
        return branchOffice;
    }

    public String getRate() {
        return rate;
    }

    public String getTerm() {
        return term;
    }

    public boolean isPromotion() {
        return isPromotion;
    }

    public boolean isRenew() {
        return isRenew;
    }

    public String getReason() {
        return reason;
    }

    public int getGroupServerId() {
        return groupServerId;
    }

    public boolean canEdit() {
        return canEdit;
    }

    public List<MemberCreditApp> getMemberCreditApps() {
        return memberCreditApps;
    }

    public void setCanEdit(boolean canEdit) {
        this.canEdit = canEdit;
    }

    @Override
    public double getAmount() {
        if (memberCreditApps == null) return 0;
        double amount = 0;
        for (MemberCreditApp memberCreditApp : memberCreditApps) {
            amount += memberCreditApp.getRequestAmount();
        }
        return amount;
    }

    public Builder buildUpon() {
        return new Builder(this);
    }

    public static class Builder extends InternalBuilder<Builder> {

        private ServerAction serverAction;
        private int cycle;
        private  String adviser;
        private String branchOffice;
        private String rate;
        private String term;
        private boolean isPromotion;
        private boolean isRenew;
        private String reason;
        private boolean canEdit;
        private List<MemberCreditApp> memberCreditApps;
        public int groupServerId;

        private Builder(GroupCreditApp groupCreditApp) {
            super(groupCreditApp);
            canEdit = groupCreditApp.canEdit;
            cycle = groupCreditApp.cycle;
            adviser = groupCreditApp.adviser;
            branchOffice = groupCreditApp.branchOffice;
            rate = groupCreditApp.rate;
            term = groupCreditApp.term;
            isPromotion = groupCreditApp.isPromotion;
            isRenew = groupCreditApp.isRenew;
            reason = groupCreditApp.reason;
            groupServerId = groupCreditApp.groupServerId;
            memberCreditApps = groupCreditApp.memberCreditApps;
            serverAction = groupCreditApp.action;
        }

        public Builder() {
            super(CreditAppType.GROUP);
            isPromotion = false;
            isRenew = true;
            canEdit = true;
        }

        public Builder setCycle(int cycle) {
            this.cycle = cycle;
            return this;
        }

        public Builder setAdviser(String adviser) {
            this.adviser = adviser;
            return this;
        }

        public Builder setBranchOffice(String branchOffice) {
            this.branchOffice = branchOffice;
            return this;
        }

        public Builder setRate(String rate) {
            this.rate = rate;
            return this;
        }

        public Builder setTerm(String term) {
            this.term = term;
            return this;
        }

        public Builder setPromotion(boolean promotion) {
            isPromotion = promotion;
            return this;
        }

        public Builder setRenew(boolean renew) {
            isRenew = renew;
            return this;
        }

        public Builder setReason(String reason) {
            this.reason = reason;
            return this;
        }

        public Builder setMemberCreditApps(List<MemberCreditApp> memberCreditApps) {
            this.memberCreditApps = memberCreditApps;
            return this;
        }

        public Builder setGroupServerId(int groupServerId) {
            this.groupServerId = groupServerId;
            return this;
        }

        public Builder setCanEdit(boolean canEdit) {
            this.canEdit = canEdit;
            return this;
        }

        public GroupCreditApp build() {
            return new GroupCreditApp(this);
        }
    }
}
