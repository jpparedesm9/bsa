package com.cobiscorp.ecobis.cloud.service.dto.simulation;

import cobiscorp.ecobis.assets.cloud.dto.LoanSimulatorRequest;

import java.math.BigDecimal;

import static com.cobiscorp.ecobis.cloud.service.util.CalendarUtil.fromISOTime;
import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

public class SimulationParameters {
    private String type;
    private String initialDate; //Calendar
    private BigDecimal amount;
    private Integer term;
    private String frequency;

    public LoanSimulatorRequest toRequest() {
        LoanSimulatorRequest request = new LoanSimulatorRequest();
        request.setCustomerId(null);
        request.setOperationtype(type);
        if (!isNullOrEmpty(initialDate)) {
            request.setInitialDate(fromISOTime(initialDate));
        }
        request.setAmount(amount.doubleValue());
        request.setTerm(term);
        request.setFrequency(frequency);
        request.setCurrency(0);
        return request;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getInitialDate() {
        return initialDate;
    }

    public void setInitialDate(String initialDate) {
        this.initialDate = initialDate;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Integer getTerm() {
        return term;
    }

    public void setTerm(Integer term) {
        this.term = term;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }
}
