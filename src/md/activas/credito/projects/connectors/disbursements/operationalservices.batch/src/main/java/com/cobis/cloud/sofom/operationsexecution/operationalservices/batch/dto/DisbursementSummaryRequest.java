package com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto;

/**
 * Created by pclavijo on 21/07/2017.
 */
public class DisbursementSummaryRequest {
    private String summary;

    public DisbursementSummaryRequest(String summary) {
        super();
        this.summary = summary;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    @Override
    public String toString() {
        return "DisbursementSummaryRequest{" +
                "summary='" + summary + '\'' +
                '}';
    }
}
