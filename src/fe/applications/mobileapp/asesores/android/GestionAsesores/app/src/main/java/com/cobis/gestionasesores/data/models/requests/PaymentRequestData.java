package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 21/08/2017.
 */

public class PaymentRequestData {
    private int groupId;
    private double groupAmount;
    private boolean debitsSavingAccounts;

    public int getGroupId() {
        return groupId;
    }

    public PaymentRequestData setGroupId(int groupId) {
        this.groupId = groupId;
        return this;
    }

    public double getGroupAmount() {
        return groupAmount;
    }

    public PaymentRequestData setGroupAmount(double groupAmount) {
        this.groupAmount = groupAmount;
        return this;
    }

    public boolean isDebitsSavingAccounts() {
        return debitsSavingAccounts;
    }

    public PaymentRequestData setDebitsSavingAccounts(boolean debitsSavingAccounts) {
        this.debitsSavingAccounts = debitsSavingAccounts;
        return this;
    }
}
