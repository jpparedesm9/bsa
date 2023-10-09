package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/27/2017.
 */
// TODO: 8/19/2017 should unify the remote address data structure
public class AddressInfo {
    private Integer addressId;
    private String street;
    private int addressNumber;
    private int neighborhoodCode;
    private int countryCode;
    private String postalCode;
    private int stateCode;
    private int cityCode;
    private int addressInternalNumber;
    private int yearsAtAddress;
    private String ownershipType;
    private String referenceLandmark;
    private int numberOfResidents; //protected for workaround no serialize field

    public int getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(int countryCode) {
        this.countryCode = countryCode;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public int getStateCode() {
        return stateCode;
    }

    public void setStateCode(int stateCode) {
        this.stateCode = stateCode;
    }

    public int getCityCode() {
        return cityCode;
    }

    public void setCityCode(int cityCode) {
        this.cityCode = cityCode;
    }

    public int getNeighborhoodCode() {
        return neighborhoodCode;
    }

    public void setNeighborhoodCode(int neighborhoodCode) {
        this.neighborhoodCode = neighborhoodCode;
    }

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

    public int getAddressInternalNumber() {
        return addressInternalNumber;
    }

    public void setAddressInternalNumber(int addressInternalNumber) {
        this.addressInternalNumber = addressInternalNumber;
    }

    public int getYearsAtAddress() {
        return yearsAtAddress;
    }

    public void setYearsAtAddress(int yearsAtAddress) {
        this.yearsAtAddress = yearsAtAddress;
    }

    public String getOwnershipType() {
        return ownershipType;
    }

    public void setOwnershipType(String ownershipType) {
        this.ownershipType = ownershipType;
    }

    public int getNumberOfResidents() {
        return numberOfResidents;
    }

    public void setNumberOfResidents(int numberOfResidents) {
        this.numberOfResidents = numberOfResidents;
    }

    public String getReferenceLandmark() {
        return referenceLandmark;
    }

    public void setReferenceLandmark(String referenceLandmark) {
        this.referenceLandmark = referenceLandmark;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }
}
