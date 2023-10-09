package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 14/07/2017.
 */

public class BuroResponse {
    private int riskScore;
    private String ruleExecutionResult;

    public BuroResponse() {
    }

    public int getRiskScore() {
        return riskScore;
    }

    public void setRiskScore(int riskScore) {
        this.riskScore = riskScore;
    }

    public String getRuleExecutionResult() {
        return ruleExecutionResult;
    }

    public void setRuleExecutionResult(String ruleExecutionResult) {
        this.ruleExecutionResult = ruleExecutionResult;
    }

    @Override
    public String toString() {
        return "BuroResponse{" +
                "riskScore=" + riskScore +
                ", ruleExecutionResult='" + ruleExecutionResult + '\'' +
                '}';
    }
}
