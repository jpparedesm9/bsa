package com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto;

import java.math.BigDecimal;

/**
 * Created by pclavijo on 25/07/2017.
 */
public class Fee {
    private BigDecimal amount;
    private BigDecimal tax;

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getTax() {
        return tax;
    }

    public void setTax(BigDecimal tax) {
        this.tax = tax;
    }

    @Override
    public String toString() {
        return "Fee{" +
                "amount=" + amount +
                ", tax=" + tax +
                '}';
    }
}
