package com.cobis.cloud.sofom.operationsexecution.operationalservices.dto;

import com.cobis.cloud.sofom.referencedata.party.dto.CustomerInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.Product;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pclavijo on 06/07/2017.
 */
public class AccountForDisbursementInfo {
    private CustomerInfo customerInfo;
    private Product product;
    List<Product> productList;

    public AccountForDisbursementInfo(CustomerInfo customerInfo, Product product) {
        this.customerInfo = customerInfo;
        this.product = product;
        this.productList = new ArrayList<Product>();
    }

    public AccountForDisbursementInfo(CustomerInfo customerInfo, Product product, List<Product> productList) {
        this.customerInfo = customerInfo;
        this.product = product;
        this.productList = productList;
    }

    public CustomerInfo getCustomerInfo() {
        return customerInfo;
    }

    public void setCustomerInfo(CustomerInfo customerInfo) {
        this.customerInfo = customerInfo;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    @Override
    public String toString() {
        return "AccountForDisbursementInfo{" +
                "customerInfo=" + customerInfo +
                ", product=" + product +
                ", productList=" + productList +
                '}';
    }
}
