package com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto;

import java.util.List;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class ProductsByBucResponse {
    private List<ProductByBuc> out;

    public ProductsByBucResponse() {
    }

    public ProductsByBucResponse(List<ProductByBuc> out) {
        this.out = out;
    }

    public List<ProductByBuc> getOut() {
        return out;
    }

    public void setOut(List<ProductByBuc> out) {
        this.out = out;
    }
}
