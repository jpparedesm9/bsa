package com.cobiscorp.ecobis.cloud.service.dto.client;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceResponse;

public class Reference {

    private int referenceId;
    private String firstName;
    private String surname;
    private String phone;
    private String emailAddress;
    private int timeOfRelationship;

    public CustomerReferenceRequest toRequest(int customerId) {
        CustomerReferenceRequest request = new CustomerReferenceRequest();
        request.setName(firstName);
        request.setFirstLastName(surname);
        request.setReferences(referenceId);
        request.setHomePhone(phone);
        request.setEmail(emailAddress);
        request.setKnownTime(timeOfRelationship);
        request.setCustomerCode(customerId);
        request.setRelationship("HE");
        return request;
    }

    public static Reference fromResponse(CustomerReferenceResponse response) {
        if (response == null) {
            return null;
        }
        Reference reference = new Reference();
        reference.referenceId = response.getReferences();
        reference.firstName = response.getName();
        reference.surname = response.getFirstLastName();
        if (response.getHomePhone() != null) {
            reference.phone = response.getHomePhone().trim();
        }
        reference.emailAddress = response.getEmail();
        reference.timeOfRelationship = response.getKnownTime();
        return reference;
    }

    public int getReferenceId() {
        return referenceId;
    }

    public void setReferenceId(int referenceId) {
        this.referenceId = referenceId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public int getTimeOfRelationship() {
        return timeOfRelationship;
    }

    public void setTimeOfRelationship(int timeOfRelationship) {
        this.timeOfRelationship = timeOfRelationship;
    }
}
