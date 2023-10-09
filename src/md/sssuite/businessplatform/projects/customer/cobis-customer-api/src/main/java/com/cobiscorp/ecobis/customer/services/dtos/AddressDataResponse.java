package com.cobiscorp.ecobis.customer.services.dtos;

import java.math.BigDecimal;

public class AddressDataResponse {

	private Integer addressId;
	private String description;
	private int countryCode;
	private String country;	
	private int provinceCode;
	private String province;
	private String departmentId;
	private String department;
	private int cityCode;
	private String city;
	private int districtCode;
	private String district;
	private int neighbordhoodCode;
	private String neighbordhood;
	private String otherSigns;

	private String type;
	private String typeCode;
	private int officeCode;
	private String office;
	private String isVerified;
	private String isMainAddress;
	private String isMailAddress;
	private String isRented;
	private BigDecimal rentAmount;
	private String isBillingAddress;
	private String street;
	private String house;
	private String building;
	private String comercialAddress;

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(int countryCode) {
		this.countryCode = countryCode;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public int getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(int provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public int getCityCode() {
		return cityCode;
	}

	public void setCityCode(int cityCode) {
		this.cityCode = cityCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(int districtCode) {
		this.districtCode = districtCode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public int getNeighbordhoodCode() {
		return neighbordhoodCode;
	}

	public void setNeighbordhoodCode(int neighbordhoodCode) {
		this.neighbordhoodCode = neighbordhoodCode;
	}

	public String getNeighbordhood() {
		return neighbordhood;
	}

	public void setNeighbordhood(String neighbordhood) {
		this.neighbordhood = neighbordhood;
	}

	public String getOtherSigns() {
		return otherSigns;
	}

	public void setOtherSigns(String otherSigns) {
		this.otherSigns = otherSigns;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public int getOfficeCode() {
		return officeCode;
	}

	public void setOfficeCode(int officeCode) {
		this.officeCode = officeCode;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public String getIsVerified() {
		return isVerified;
	}

	public void setIsVerified(String isVerified) {
		this.isVerified = isVerified;
	}

	public String getIsMainAddress() {
		return isMainAddress;
	}

	public void setIsMainAddress(String isMainAddress) {
		this.isMainAddress = isMainAddress;
	}

	public String getIsMailAddress() {
		return isMailAddress;
	}

	public void setIsMailAddress(String isMailAddress) {
		this.isMailAddress = isMailAddress;
	}

	public String getIsRented() {
		return isRented;
	}

	public void setIsRented(String isRented) {
		this.isRented = isRented;
	}

	public BigDecimal getRentAmount() {
		return rentAmount;
	}

	public void setRentAmount(BigDecimal rentAmount) {
		this.rentAmount = rentAmount;
	}

	public String getIsBillingAddress() {
		return isBillingAddress;
	}

	public void setIsBillingAddress(String isBillingAddress) {
		this.isBillingAddress = isBillingAddress;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getHouse() {
		return house;
	}

	public void setHouse(String house) {
		this.house = house;
	}

	public String getBuilding() {
		return building;
	}

	public void setBuilding(String building) {
		this.building = building;
	}

	public String getComercialAddress() {
		return comercialAddress;
	}

	public void setComercialAddress(String comercialAddress) {
		this.comercialAddress = comercialAddress;
	}

	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

}
