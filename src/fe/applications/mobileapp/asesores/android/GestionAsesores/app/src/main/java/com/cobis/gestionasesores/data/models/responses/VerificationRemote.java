package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.requests.GeoReference;

import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class VerificationRemote {
    private String customerName;
    private String date;
    private float result;
    private int applicationId;
    private int customerId;
    private List<QuestionRemote> questions;
    private boolean group;
//    private LocationData businessAddressGeoReference;
//    private LocationData homeAddressGeoReference;
    private GeoReference businessAddressGeoReference;
    private GeoReference homeAddressGeoReference;
    private boolean aval;

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public float getResult() {
        return result;
    }

    public void setResult(float result) {
        this.result = result;
    }

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

    public List<QuestionRemote> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionRemote> questions) {
        this.questions = questions;
    }

    public boolean isGroup() {
        return group;
    }

    public void setGroup(boolean group) {
        this.group = group;
    }

    public GeoReference getBusinessAddressGeoReference() {
        return businessAddressGeoReference;
    }

    public VerificationRemote setBusinessAddressGeoReference(GeoReference businessAddressGeoReference) {
        this.businessAddressGeoReference = businessAddressGeoReference;
        return this;
    }

    public GeoReference getHomeAddressGeoReference() {
        return homeAddressGeoReference;
    }

    public VerificationRemote setHomeAddressGeoReference(GeoReference homeAddressGeoReference) {
        this.homeAddressGeoReference = homeAddressGeoReference;
        return this;
    }

    public boolean isAval() {
        return aval;
    }

    public void setAval(boolean aval) {
        this.aval = aval;
    }
}
