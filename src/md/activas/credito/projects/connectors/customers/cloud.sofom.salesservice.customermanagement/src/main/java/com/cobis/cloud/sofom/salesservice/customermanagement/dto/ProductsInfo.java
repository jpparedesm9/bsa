package com.cobis.cloud.sofom.salesservice.customermanagement.dto;

import java.util.List;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class ProductsInfo {
    private List<Product> productList;

    public ProductsInfo() {
    }

    public ProductsInfo(List<Product> productList) {
        this.productList = productList;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    @Override
    public String toString() {
        return "ProductsInfo{" +
                "productList=" + productList.toString() +
                '}';
    }
}
