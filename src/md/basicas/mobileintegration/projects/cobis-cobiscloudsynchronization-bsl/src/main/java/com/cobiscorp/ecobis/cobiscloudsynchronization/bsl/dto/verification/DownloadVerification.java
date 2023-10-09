package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification;

import java.util.List;

import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;

public class DownloadVerification {

    private String customerName;
    private String date; //TODO: validar Manuel
    private double result; // TODO: validar servicio subida
    private Integer applicationId;
    private Integer customerId;
    private List<DownloadQuestion> questions;
    private boolean group;
    private GeoReference businessAddressGeoReference;
    private GeoReference homeAddressGeoReference;

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

    public double getResult() {
        return result;
    }

    public void setResult(double result) {
        this.result = result;
    }

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

    public List<DownloadQuestion> getQuestions() {
        return questions;
    }

    public void setQuestions(List<DownloadQuestion> questions) {
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

	public void setBusinessAddressGeoReference(GeoReference businessAddressGeoReference) {
		this.businessAddressGeoReference = businessAddressGeoReference;
	}

	public GeoReference getHomeAddressGeoReference() {
		return homeAddressGeoReference;
	}

	public void setHomeAddressGeoReference(GeoReference homeAddressGeoReference) {
		this.homeAddressGeoReference = homeAddressGeoReference;
	}
    
}
