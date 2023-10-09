package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by bqtdesa02 on 8/17/2017.
 */

public class QuestionOption implements Serializable{

    private String value;
    private String code;

    public QuestionOption(String code, String value) {
        this.value = value;
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
