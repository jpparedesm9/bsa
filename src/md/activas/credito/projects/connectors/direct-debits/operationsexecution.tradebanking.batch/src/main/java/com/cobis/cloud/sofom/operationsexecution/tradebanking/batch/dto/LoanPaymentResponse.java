package com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.dto;

public class LoanPaymentResponse {
    private String errorMessage;
    private Integer errorNumber;
    private Integer executionReturnNumber;

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public Integer getErrorNumber() {
        return errorNumber;
    }

    public void setErrorNumber(Integer errorNumber) {
        this.errorNumber = errorNumber;
    }

    public Integer getExecutionReturnNumber() {
        return executionReturnNumber;
    }

    public void setExecutionReturnNumber(Integer executionReturnNumber) {
        this.executionReturnNumber = executionReturnNumber;
    }

    @Override
    public String toString() {
        return "LoanPaymentResponse{" +
                "errorMessage='" + errorMessage + '\'' +
                ", errorNumber=" + errorNumber +
                ", executionReturnNumber=" + executionReturnNumber +
                '}';
    }
}
