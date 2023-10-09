package com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import java.util.Date;

/**
 * Created by pclavijo on 25/07/2017.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Event {
    private String type;
    private Date event_date;
    private Transaction transaction;
    private String verification_code;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getEvent_date() {
        return event_date;
    }

    public void setEvent_date(Date event_date) {
        this.event_date = event_date;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public String getVerification_code() {
        return verification_code;
    }

    public void setVerification_code(String verification_code) {
        this.verification_code = verification_code;
    }

    @Override
    public String toString() {
        return "Event{" +
                "type='" + type + '\'' +
                ", event_date=" + event_date +
                ", transaction=" + transaction +
                ", verification_code='" + verification_code + '\'' +
                '}';
    }
}