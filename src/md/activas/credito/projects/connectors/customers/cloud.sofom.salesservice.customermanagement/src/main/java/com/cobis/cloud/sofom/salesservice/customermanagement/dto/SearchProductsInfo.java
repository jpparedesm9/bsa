package com.cobis.cloud.sofom.salesservice.customermanagement.dto;

/**
 * Created by pclavijo on 10/07/2017.
 */
public class SearchProductsInfo {
    private String buc;

    public SearchProductsInfo(String buc) {
        this.buc = buc;
    }

    public String getBuc() {
        return buc;
    }

    public void setBuc(String buc) {
        this.buc = buc;
    }

    @Override
    public String toString() {
        return "SearchProductsInfo{" +
                "buc='" + buc + '\'' +
                '}';
    }
}
