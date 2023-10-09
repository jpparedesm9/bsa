package com.cobiscorp.ecobis.cloud.service.dto.address;

import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

public class BasicAddress {

	private int addressId;
	private String postalCode;
	private int countryCode;
	private int stateCode;
	private int cityCode;// Municipio-Delegacion
	private String cityDescription;
	private int neighborhoodCode;// colonia
	private String neighborhoodDescription;
	private String street;// calle
	private int yearsAtAddress;
	private String ownershipType;
	private int addressNumber; // numero
	private int addressInternalNumber;
	private String referenceLandmark;
	private String addressDescription;
	private String reference;

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
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

	public String getReferenceLandmark() {
		return referenceLandmark;
	}

	public void setReferenceLandmark(String referenceLandmark) {
		this.referenceLandmark = referenceLandmark;
	}

	public String getCityDescription() {
		return cityDescription;
	}

	public void setCityDescription(String cityDescription) {
		this.cityDescription = cityDescription;
	}

	public String getNeighborhoodDescription() {
		return neighborhoodDescription;
	}

	public void setNeighborhoodDescription(String neighborhoodDescription) {
		this.neighborhoodDescription = neighborhoodDescription;
	}

	public String getAddressDescription() {
		return addressDescription;
	}

	public void setAddressDescription(String addressDescription) {
		this.addressDescription = addressDescription;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	protected void fillFromResponse(AddressResp address) {
		if (address != null) {
			this.addressId = address.getAddress();
			this.countryCode = address.getCountyCode();
			this.postalCode = address.getPostalCode();
			this.stateCode = address.getProvinceCode();
			this.cityCode = address.getCityCode();
			this.cityDescription = address.getCityDescription();
			this.neighborhoodCode = address.getParishCode();
			this.neighborhoodDescription = address.getParishDescription();
			this.street = address.getStreet();
			this.addressNumber = address.getDirectionNumber();
			this.addressInternalNumber = address.getDirectionNumberInternal();
			this.yearsAtAddress = address.getResidenceTime();
			this.ownershipType = address.getOwnershipType();
			this.reference = address.getReference();
			this.referenceLandmark = isNullOrEmpty(address.getCityPoblation()) ? "" : address.getCityPoblation().trim();
			this.addressDescription = (street == null ? "" : street) + " " + addressNumber + " " + (neighborhoodDescription == null ? "" : neighborhoodDescription) + " "
					+ (cityDescription == null ? "" : cityDescription);
		}
	}

	public AddressRequest toRequest(int customerId) {
		AddressRequest request = new AddressRequest();
		request.setAddress(addressId);
		request.setCustomerId(customerId);
		request.setCountyCode(countryCode);
		request.setPostalCode(postalCode);
		request.setProvinceCode(stateCode);
		request.setCityCode(cityCode);
		request.setParishCode(neighborhoodCode);
		request.setStreet(street);
		request.setDirectionNumber(addressNumber);
		request.setDirectionNumberInternal(addressInternalNumber);
		request.setResidenceTyme(yearsAtAddress);
		request.setOwnershipType(ownershipType);
		request.setPrincipal("S");
		request.setAddressType("RE");
		// request.setAddressDesc(street);
		request.setCityPoblation(referenceLandmark);
		request.setReference(reference);
		return request;
	}
}
