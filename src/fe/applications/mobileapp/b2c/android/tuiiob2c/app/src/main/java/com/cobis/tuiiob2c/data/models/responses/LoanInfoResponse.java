package com.cobis.tuiiob2c.data.models.responses;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Loan;

import java.io.Serializable;

public class LoanInfoResponse extends BaseModel implements Serializable {

    private Loan data;

    public LoanInfoResponse() {
    }

    public LoanInfoResponse(Loan data) {
        this.data = data;
    }

    public Loan getData() {
        return data;
    }

    public void setData(Loan data) {
        this.data = data;
    }
}