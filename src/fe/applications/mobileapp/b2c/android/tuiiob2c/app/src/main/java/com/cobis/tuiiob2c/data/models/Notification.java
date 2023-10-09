package com.cobis.tuiiob2c.data.models;

import com.cobis.tuiiob2c.data.enums.NeedOtpType;
import com.cobis.tuiiob2c.data.enums.NotificationType;

public class Notification {

    private String id;
    private String description;
    @NotificationType
    private String type;
    @NeedOtpType
    private String needsOtp;

    public Notification() {
    }

    public Notification(String id, String description, String type, String needsOtp) {
        this.id = id;
        this.description = description;
        this.type = type;
        this.needsOtp = needsOtp;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getNeedsOtp() {
        return needsOtp;
    }

    public void setNeedsOtp(String needsOtp) {
        this.needsOtp = needsOtp;
    }
}
