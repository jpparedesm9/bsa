package com.cobis.cloud.sofom.salesservice.customermanagement.dto;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class Product {
    private String productCode;
    private String subproductCode;
    private String status;
    private String contractNumber;
    private String currencyCode;

    public Product() {
    }

    public Product(String productCode, String subproductCode, String status, String contractNumber) {
        this.productCode = productCode;
        this.subproductCode = subproductCode;
        this.status = status;
        this.contractNumber = contractNumber;
    }

    public Product(String productCode, String subproductCode, String status, String contractNumber, String currencyCode) {
        this.productCode = productCode;
        this.subproductCode = subproductCode;
        this.status = status;
        this.contractNumber = contractNumber;
        this.currencyCode = currencyCode;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getSubproductCode() {
        return subproductCode;
    }

    public void setSubproductCode(String subproductCode) {
        this.subproductCode = subproductCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productCode='" + productCode + '\'' +
                ", subproductCode='" + subproductCode + '\'' +
                ", status='" + status + '\'' +
                ", contractNumber='" + contractNumber + '\'' +
                ", currencyCode='" + currencyCode + '\'' +
                '}';
    }
}
