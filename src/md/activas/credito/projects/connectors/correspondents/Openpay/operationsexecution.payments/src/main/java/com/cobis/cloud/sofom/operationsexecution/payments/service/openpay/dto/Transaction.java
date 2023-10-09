package com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by pclavijo on 25/07/2017.
 */
public class Transaction {
    private String id;
    private String authorization;
    private String operation_type;
    private String method;
    private String transaction_type;
    private String status;
    private boolean conciliated;
    private Date creation_date;
    private Date operation_date;
    private String description;
    private String error_message;
    private Integer order_id;
    private String customer_id;
    private Date due_date;
    private PaymentMethod payment_method;
    private BigDecimal amount;
    private Fee fee;
    private String currency;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAuthorization() {
        return authorization;
    }

    public void setAuthorization(String authorization) {
        this.authorization = authorization;
    }

    public String getOperation_type() {
        return operation_type;
    }

    public void setOperation_type(String operation_type) {
        this.operation_type = operation_type;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getTransaction_type() {
        return transaction_type;
    }

    public void setTransaction_type(String transaction_type) {
        this.transaction_type = transaction_type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isConciliated() {
        return conciliated;
    }

    public void setConciliated(boolean conciliated) {
        this.conciliated = conciliated;
    }

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    public Date getOperation_date() {
        return operation_date;
    }

    public void setOperation_date(Date operation_date) {
        this.operation_date = operation_date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getError_message() {
        return error_message;
    }

    public void setError_message(String error_message) {
        this.error_message = error_message;
    }

    public Integer getOrder_id() {
        return order_id;
    }

    public void setOrder_id(Integer order_id) {
        this.order_id = order_id;
    }

    public String getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(String customer_id) {
        this.customer_id = customer_id;
    }

    public Date getDue_date() {
        return due_date;
    }

    public void setDue_date(Date due_date) {
        this.due_date = due_date;
    }

    public PaymentMethod getPayment_method() {
        return payment_method;
    }

    public void setPayment_method(PaymentMethod payment_method) {
        this.payment_method = payment_method;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Fee getFee() {
        return fee;
    }

    public void setFee(Fee fee) {
        this.fee = fee;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "id='" + id + '\'' +
                ", authorization='" + authorization + '\'' +
                ", operation_type='" + operation_type + '\'' +
                ", method='" + method + '\'' +
                ", transaction_type='" + transaction_type + '\'' +
                ", status='" + status + '\'' +
                ", conciliated=" + conciliated +
                ", creation_date=" + creation_date +
                ", operation_date=" + operation_date +
                ", description='" + description + '\'' +
                ", error_message='" + error_message + '\'' +
                ", order_id=" + order_id +
                ", customer_id='" + customer_id + '\'' +
                ", due_date=" + due_date +
                ", payment_method=" + payment_method +
                ", amount=" + amount +
                ", fee=" + fee +
                ", currency='" + currency + '\'' +
                '}';
    }
}
