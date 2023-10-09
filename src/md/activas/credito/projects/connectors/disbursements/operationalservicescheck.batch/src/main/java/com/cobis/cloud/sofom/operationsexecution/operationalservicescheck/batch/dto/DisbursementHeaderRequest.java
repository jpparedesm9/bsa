package com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto;

/**
 * Created by pclavijo on 21/07/2017.
 */
public class DisbursementHeaderRequest {
    private String header;

    public DisbursementHeaderRequest(String header) {
        super();
        this.header = header;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    @Override
    public String toString() {
        return "DisbursementHeaderRequest{" +
                "header='" + header + '\'' +
                '}';
    }
}
