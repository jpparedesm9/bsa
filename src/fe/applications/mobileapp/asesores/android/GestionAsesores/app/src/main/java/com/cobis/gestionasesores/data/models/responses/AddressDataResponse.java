/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.gestionasesores.data.models.responses;

/**
 * @author mnaunay
 */
// TODO: 8/19/2017 should unify the remote address data structure
public class AddressDataResponse {
    private int customerId;
    private int addressId;
    private int countryCode;
    private int provinceCode;
    private int cityCode;
    private int parishCode;
    private String postalCode;
    private String street;
    private int directionNumber;
    private int directionNumberInternal;
    private String referenceLandmark;

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(int countryCode) {
        this.countryCode = countryCode;
    }

    public int getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(int provinceCode) {
        this.provinceCode = provinceCode;
    }

    public int getCityCode() {
        return cityCode;
    }

    public void setCityCode(int cityCode) {
        this.cityCode = cityCode;
    }

    public int getParishCode() {
        return parishCode;
    }

    public void setParishCode(int parishCode) {
        this.parishCode = parishCode;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public int getDirectionNumber() {
        return directionNumber;
    }

    public void setDirectionNumber(int directionNumber) {
        this.directionNumber = directionNumber;
    }

    public int getDirectionNumberInternal() {
        return directionNumberInternal;
    }

    public String getReferenceLandmark() {
        return referenceLandmark;
    }

    public void setReferenceLandmark(String referenceLandmark) {
        this.referenceLandmark = referenceLandmark;
    }

    public void setDirectionNumberInternal(int directionNumberInternal) {
        this.directionNumberInternal = directionNumberInternal;
    }
}
