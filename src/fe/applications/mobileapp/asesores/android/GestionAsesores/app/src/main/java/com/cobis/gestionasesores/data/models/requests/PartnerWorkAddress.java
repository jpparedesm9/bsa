package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/31/2017.
 */
// TODO: 8/19/2017 should unify the remote address data structure
public class PartnerWorkAddress {

    private int addressId;
    private int addressInternalNumber;
    private String street;
    private int addressNumber;
    private int neighborhoodCode;
    private int cityCode;
    private int stateCode;
    private String postalCode;
    private int countryCode;
    private String referenceLandmark;

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public int getAddressNumber() {
        return addressNumber;
    }

    public void setAddressNumber(int addressNumber) {
        this.addressNumber = addressNumber;
    }

    public int getNeighborhoodCode() {
        return neighborhoodCode;
    }

    public void setNeighborhoodCode(int neighborhoodCode) {
        this.neighborhoodCode = neighborhoodCode;
    }

    public int getCityCode() {
        return cityCode;
    }

    public void setCityCode(int cityCode) {
        this.cityCode = cityCode;
    }

    public int getStateCode() {
        return stateCode;
    }

    public void setStateCode(int stateCode) {
        this.stateCode = stateCode;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public int getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(int countryCode) {
        this.countryCode = countryCode;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getAddressInternalNumber() {
        return addressInternalNumber;
    }

    public void setAddressInternalNumber(int addressInternalNumber) {
        this.addressInternalNumber = addressInternalNumber;
    }

    public String getReferenceLandmark() {
        return referenceLandmark;
    }

    public void setReferenceLandmark(String referenceLandmark) {
        this.referenceLandmark = referenceLandmark;
    }
}
