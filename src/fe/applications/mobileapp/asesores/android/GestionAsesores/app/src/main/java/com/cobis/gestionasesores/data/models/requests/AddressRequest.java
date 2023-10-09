package com.cobis.gestionasesores.data.models.requests;

// TODO: 8/19/2017 should unify the remote address data structure
public class AddressRequest {
    private int customerId;
    private int addressId;
    private int parishCode;
    private int cityCode;
    private int provinceCode;
    private Object postalCode;
    private String street;
    private int countryCode;
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

    public AddressRequest setAddressId(int addressId) {
        this.addressId = addressId;
        return this;
    }

    public int getParishCode() {
        return parishCode;
    }

    public void setParishCode(int parishCode) {
        this.parishCode = parishCode;
    }

    public int getCityCode() {
        return cityCode;
    }

    public void setCityCode(int cityCode) {
        this.cityCode = cityCode;
    }

    public int getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(int provinceCode) {
        this.provinceCode = provinceCode;
    }

    public Object getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(Object postalCode) {
        this.postalCode = postalCode;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public int getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(int countryCode) {
        this.countryCode = countryCode;
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

    public void setDirectionNumberInternal(int directionNumberInternal) {
        this.directionNumberInternal = directionNumberInternal;
    }

    public String getReferenceLandmark() {
        return referenceLandmark;
    }

    public void setReferenceLandmark(String referenceLandmark) {
        this.referenceLandmark = referenceLandmark;
    }
}
