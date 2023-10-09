package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.models.requests.GeoReference;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MemberVerification extends Synchronizable {
    private String name;
    private double score;
    private int applicationId;
    private List<Question> questions;
    private Map<String, GeoReference> geoReferences;
    private boolean aval;
    private boolean group;
//    private LocationData businessAddressGeoReference;
//    private LocationData homeAddressGeoReference;
//    private LocationData officialGeoReference;
    private GeoReference businessAddressGeoReference;
    private GeoReference homeAddressGeoReference;
    private GeoReference officialGeoReference;

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public Map<String, GeoReference> getGeoReferences() {
        return geoReferences;
    }

    public MemberVerification setGeoReferences(Map<String, GeoReference> geoReferences) {
        this.geoReferences = geoReferences;
        return this;
    }

    public boolean isAval() {
        return aval;
    }

    public void setAval(boolean aval) {
        this.aval = aval;
    }

    public GeoReference getLocationDataByCode(String code){
        if(geoReferences != null){
            return geoReferences.get(code);
        }
        return null;
    }

    public void addGeoReference(String code, GeoReference locationData) {
        if (geoReferences == null) {
            geoReferences = new HashMap<>();
        }

        geoReferences.put(code, locationData);
    }

    public void setEnabled(boolean enabled) {
        for (Question question : questions) {
            question.setEnabled(enabled);
        }
    }

    public void setGroup(boolean group) {
        this.group = group;
    }

    public boolean isGroup() {
        return group;
    }

    public GeoReference getBusinessAddressGeoReference() {
        return businessAddressGeoReference;
    }

    public MemberVerification setBusinessAddressGeoReference(GeoReference businessAddressGeoReference) {
        this.businessAddressGeoReference = businessAddressGeoReference;
        return this;
    }

    public GeoReference getHomeAddressGeoReference() {
        return homeAddressGeoReference;
    }

    public MemberVerification setHomeAddressGeoReference(GeoReference homeAddressGeoReference) {
        this.homeAddressGeoReference = homeAddressGeoReference;
        return this;
    }

    public GeoReference getOfficialGeoReference() {
        return officialGeoReference;
    }

    public MemberVerification setOfficialGeoReference(GeoReference officialGeoReference) {
        this.officialGeoReference = officialGeoReference;
        return this;
    }
}
