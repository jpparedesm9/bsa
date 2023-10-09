package com.cobis.gestionasesores.data.models;

/**
 * Default model for generic use
 * Created by Miguel on 24/06/2017.
 */

public class SingleItem {
    private String code;
    private String value;

    public SingleItem(String code, String value) {
        this.code = code;
        this.value = value;
    }

    public SingleItem(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
