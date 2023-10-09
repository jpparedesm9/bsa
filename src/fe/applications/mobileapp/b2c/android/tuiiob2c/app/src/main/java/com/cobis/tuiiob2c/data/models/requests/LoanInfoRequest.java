package com.cobis.tuiiob2c.data.models.requests;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class LoanInfoRequest {

    @SerializedName("loanId")
    @Expose
    private String loanId;

    /**
     * No args constructor for use in serialization
     *
     */
    public LoanInfoRequest() {
    }

    /**
     *
     * @param loanId
     */
    public LoanInfoRequest(String loanId) {
        super();
        this.loanId = loanId;
    }

    public String getLoanId() {
        return loanId;
    }

    public void setLoanId(String loanId) {
        this.loanId = loanId;
    }
}