package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

/**
 * @author Cesar Loachamin
 */
public class ProspectAddress {

    private Integer customerId;
    private Integer addressId;
    private int countryCode;
    private int provinceCode;
    private int cityCode;
    private int parishCode;
    private String postalCode;
    private String street;
    private int directionNumber;
    private int directionNumberInternal;
    private String referenceLandmark;
    private String reference;

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

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

    public void setDirectionNumberInternal(int directionNumberInternal) {
        this.directionNumberInternal = directionNumberInternal;
    }

    public String getReferenceLandmark() {
        return referenceLandmark;
    }

    public void setReferenceLandmark(String referenceLandmark) {
        this.referenceLandmark = referenceLandmark;
    }

    public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	private void fillFromResponse(AddressResp address, int customerId) {
        if (address != null) {
            this.customerId = customerId;
            this.addressId = address.getAddress();
            this.countryCode = address.getCountyCode();
            this.postalCode = address.getPostalCode();
            this.provinceCode = address.getProvinceCode();
            this.cityCode = address.getCityCode();
            this.parishCode = address.getParishCode();
            this.street = address.getStreet();
            this.directionNumber = address.getDirectionNumber();
            this.directionNumberInternal = address.getDirectionNumberInternal();
            this.reference = address.getReference();
            this.referenceLandmark = isNullOrEmpty(address.getCityPoblation()) ? "" : address.getCityPoblation().trim();
        }
    }

    public AddressRequest toRequest() {
        AddressRequest request = new AddressRequest();
        request.setCustomerId(customerId);
        request.setAddress(addressId);
        request.setCountyCode(countryCode);
        request.setPostalCode(postalCode);
        request.setProvinceCode(provinceCode);
        request.setCityCode(cityCode);
        request.setParishCode(parishCode);
        request.setStreet(street);
        request.setDirectionNumber(directionNumber);
        request.setDirectionNumberInternal(directionNumberInternal);
        request.setPrincipal("S");
        request.setAddressType("RE");
        //request.setAddressDesc(street);
        request.setCityPoblation(referenceLandmark);
        request.setReference(reference);
        return request;
    }

    public static ProspectAddress fromResponse(AddressResp address, int customerId) {
        if (address == null) {
            return null;
        }
        ProspectAddress obj = new ProspectAddress();
        obj.fillFromResponse(address, customerId);
        return obj;
    }

}
