package com.cobis.gestionasesores.data.models;

/**
 * Created by bqtdesa02 on 6/6/2017.
 */

public class CatalogItem {

    private int mCatalogId;
    private String mCode;
    private String mValue;

    public CatalogItem(int catalogId, String code, String value) {
        mCatalogId = catalogId;
        mCode = code;
        mValue = value;
    }

    public int getCatalogId() {
        return mCatalogId;
    }

    public String getValue() {
        return mValue;
    }

    public String getCode() {
        return mCode;
    }

    @Override
    public String toString() {
        return mValue;
    }
}
