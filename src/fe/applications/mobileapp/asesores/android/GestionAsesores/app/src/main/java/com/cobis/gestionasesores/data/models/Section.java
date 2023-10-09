package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.SectionCode;

import java.io.Serializable;

public class Section extends Synchronizable implements Serializable {
    @SectionCode
    private String code;
    private SectionData sectionData;
    private boolean isMandatory;
    @SectionCode
    private String parentCode;

    public Section() {
    }

    public Section(@SectionCode String code, @SectionCode String parentCode, int status, boolean isMandatory) {
        this.status = status;
        this.code = code;
        this.parentCode = parentCode;
        this.isMandatory = isMandatory;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public @SectionCode
    String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public SectionData getSectionData() {
        return sectionData;
    }

    public void setSectionData(SectionData sectionData) {
        this.sectionData = sectionData;
    }

    public boolean isMandatory() {
        return isMandatory;
    }

    public void setMandatory(boolean mandatory) {
        isMandatory = mandatory;
    }

    public @SectionCode
    String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }
}