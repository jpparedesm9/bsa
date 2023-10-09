package com.cobiscorp.ecobis.cobiscloudparty.bsl.dto;

public class CustomerProduct {

    Integer customerId;
    String buc;
    String contractNumber;
    String productId;
    String subproductId;
    String status;
    String currencyCode;

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getBuc() {
        return buc;
    }

    public void setBuc(String buc) {
        this.buc = buc;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getSubproductId() {
        return subproductId;
    }

    public void setSubproductId(String subproductId) {
        this.subproductId = subproductId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }


    @Override
    public String toString() {
        return "CustomerProduct{" +
                "customerId=" + customerId +
                ", buc='" + buc + '\'' +
                ", contractNumber='" + contractNumber + '\'' +
                ", productId='" + productId + '\'' +
                ", subproductId='" + subproductId + '\'' +
                ", status=" + status +
                ", currencyCode='" + currencyCode + '\'' +
                '}';
    }
}
