package com.cobis.cloud.sofom.customers.utils.santander.dto;

/**
 * Created by pclavijo on 21/06/2017.
 */
public class Error {
    private String code;
    private String message;
    private String level;
    private String description;
    private String moreInfo;

    public Error() {
    }

    public Error(String code, String message, String level, String description, String moreInfo) {
        this.code = code;
        this.message = message;
        this.level = level;
        this.description = description;
        this.moreInfo = moreInfo;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMoreInfo() {
        return moreInfo;
    }

    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }
}
