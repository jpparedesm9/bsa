package com.cobis.gestionasesores.data.models;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Jose on 8/16/2017.
 */

public class Question implements Serializable{
    private String code;
    private String question;
    private String template;
    private int type;
    private String value;
    private List<QuestionOption> options;
    private String parent;
    private String parentValue;
    private boolean needGeo;
    private boolean error;
    private boolean isActive;
    private boolean isEnabled;
    private int position;


    public Question() {
        isActive  = true;
        isEnabled = true;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public String getQuestion() {
        return question;
    }

    public int getType() {
        return type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public List<QuestionOption> getOptions() {
        return options;
    }

    public String getCode() {
        return code;
    }

    public String getParent() {
        return parent;
    }

    public String getParentValue() {
        return parentValue;
    }

    public boolean needGeo(){
        return needGeo;
    }

    public boolean isError() {
        return error;
    }

    public void setError(boolean error) {
        this.error = error;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setOptions(List<QuestionOption> options) {
        this.options = options;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public void setParentValue(String parentValue) {
        this.parentValue = parentValue;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public boolean isEnabled() {
        return isEnabled;
    }

    public void setEnabled(boolean enabled) {
        isEnabled = enabled;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }
}
