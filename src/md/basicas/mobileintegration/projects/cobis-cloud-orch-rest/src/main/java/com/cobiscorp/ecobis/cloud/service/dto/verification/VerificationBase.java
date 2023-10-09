package com.cobiscorp.ecobis.cloud.service.dto.verification;

import java.util.List;

public class VerificationBase<T extends Question> {

    public static final int GROUP_MODE = 3;
    public static final int PERSONAL_MODE = 2;

    private Integer applicationId;
    private Integer customerId;
    private List<T> questions;
    private boolean group;

    public Integer getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(Integer applicationId) {
        this.applicationId = applicationId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public List<T> getQuestions() {
        return questions;
    }

    public void setQuestions(List<T> questions) {
        this.questions = questions;
    }

    public boolean isGroup() {
        return group;
    }

    public void setGroup(boolean group) {
        this.group = group;
    }
}
