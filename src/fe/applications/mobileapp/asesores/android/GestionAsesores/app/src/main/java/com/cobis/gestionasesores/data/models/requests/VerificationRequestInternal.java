package com.cobis.gestionasesores.data.models.requests;

import java.util.List;

/**
 * Created by mnaunay on 18/08/2017.
 */

public class VerificationRequestInternal {
    private int applicationId;
    private int customerId;
    private boolean group;
    private List<QuestionRequest> questions;
    private GeoReference businessAddressGeoReference;
    private GeoReference homeAddressGeoReference;
    private GeoReference officialGeoReference;

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public boolean isGroup() {
        return group;
    }

    public void setGroup(boolean group) {
        this.group = group;
    }

    public List<QuestionRequest> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionRequest> questions) {
        this.questions = questions;
    }

    public GeoReference getBusinessAddressGeoReference() {
        return businessAddressGeoReference;
    }

    public void setBusinessAddressGeoReference(GeoReference businessAddressGeoReference) {
        this.businessAddressGeoReference = businessAddressGeoReference;
    }

    public GeoReference getHomeAddressGeoReference() {
        return homeAddressGeoReference;
    }

    public void setHomeAddressGeoReference(GeoReference homeAddressGeoReference) {
        this.homeAddressGeoReference = homeAddressGeoReference;
    }

    public GeoReference getOfficialGeoReference() {
        return officialGeoReference;
    }

    public VerificationRequestInternal setOfficialGeoReference(GeoReference officialGeoReference) {
        this.officialGeoReference = officialGeoReference;
        return this;
    }
}
