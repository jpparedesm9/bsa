package com.cobiscorp.ecobis.customer.commons.dto;

import java.io.Serializable;

/**
 * DTO used in the method getQueryCustomerAddress.
 * @author bbuendia
 *
 */
public class CustomerAddressDTO implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private Integer idClient;
	private Integer idDirection;
	private String addressDescription;
	private Integer idCountry;
	private String descriptionCountry;
	private Integer idProvince;
	private String descriptionProvince;
	private Integer idCity;
	private String descriptionCity;
	private Integer idDistrict;
	private String descriptionDistrict;
	private Integer idTown;
	private String descriptionTown; 
	private Integer idOffice;
	private String officeName;
	private String other;
	private String typeDescription;
	private String type;
	private String verified;
	private String main;
	private String correspondence;
	private String rented;
	private Double rentAmount;
	private String charge;
	private String street;
	private String home;
	private String building;
	private String commercial;
	
	public String getDescriptionCountry() {
		return descriptionCountry;
	}
	public void setDescriptionCountry(String descriptionCountry) {
		this.descriptionCountry = descriptionCountry;
	}
	public String getDescriptionProvince() {
		return descriptionProvince;
	}
	public void setDescriptionProvince(String descriptionProvince) {
		this.descriptionProvince = descriptionProvince;
	}
	public String getDescriptionCity() {
		return descriptionCity;
	}
	public void setDescriptionCity(String descriptionCity) {
		this.descriptionCity = descriptionCity;
	}
	public String getDescriptionDistrict() {
		return descriptionDistrict;
	}
	public void setDescriptionDistrict(String descriptionDistrict) {
		this.descriptionDistrict = descriptionDistrict;
	}
	public String getDescriptionTown() {
		return descriptionTown;
	}
	public void setDescriptionTown(String descriptionTown) {
		this.descriptionTown = descriptionTown;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public Integer getIdClient() {
		return idClient;
	}
	public void setIdClient(Integer idClient) {
		this.idClient = idClient;
	}
	public Integer getIdDirection() {
		return idDirection;
	}
	public void setIdDirection(Integer idDirection) {
		this.idDirection = idDirection;
	}
	public String getAddressDescription() {
		return addressDescription;
	}
	public void setAddressDescription(String addressDescription) {
		this.addressDescription = addressDescription;
	}
	public Integer getIdCountry() {
		return idCountry;
	}
	public void setIdCountry(Integer idCountry) {
		this.idCountry = idCountry;
	}
	public Integer getIdProvince() {
		return idProvince;
	}
	public void setIdProvince(Integer idProvince) {
		this.idProvince = idProvince;
	}
	public Integer getIdCity() {
		return idCity;
	}
	public void setIdCity(Integer idCity) {
		this.idCity = idCity;
	}
	public Integer getIdDistrict() {
		return idDistrict;
	}
	public void setIdDistrict(Integer idDistrict) {
		this.idDistrict = idDistrict;
	}
	public Integer getIdTown() {
		return idTown;
	}
	public void setIdTown(Integer idTown) {
		this.idTown = idTown;
	}
	public Integer getIdOffice() {
		return idOffice;
	}
	public void setIdOffice(Integer idOffice) {
		this.idOffice = idOffice;
	}
	public String getOther() {
		return other;
	}
	public void setOther(String other) {
		this.other = other;
	}
	public String getTypeDescription() {
		return typeDescription;
	}
	public void setTypeDescription(String typeDescription) {
		this.typeDescription = typeDescription;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getVerified() {
		return verified;
	}
	public void setVerified(String verified) {
		this.verified = verified;
	}
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
	public String getCorrespondence() {
		return correspondence;
	}
	public void setCorrespondence(String correspondence) {
		this.correspondence = correspondence;
	}
	public String getRented() {
		return rented;
	}
	public void setRented(String rented) {
		this.rented = rented;
	}
	public Double getRentAmount() {
		return rentAmount;
	}
	public void setRentAmount(Double rentAmount) {
		this.rentAmount = rentAmount;
	}
	public String getCharge() {
		return charge;
	}
	public void setCharge(String charge) {
		this.charge = charge;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getHome() {
		return home;
	}
	public void setHome(String home) {
		this.home = home;
	}
	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}
	public String getCommercial() {
		return commercial;
	}
	public void setCommercial(String commercial) {
		this.commercial = commercial;
	}
	
	
	public CustomerAddressDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CustomerAddressDTO(Integer idDirection, Integer idCountry,
			String descriptionCountry, Integer idProvince,
			String descriptionProvince, Integer idCity, String descriptionCity,
			Integer idDistrict, String descriptionDistrict, Integer idTown,
			String descriptionTown, String other, String type,
			Integer idOffice, String officeName, String verified, String main,
			String correspondence, String rented, Double rentAmount,
			String charge, String street, String home, String building,
			String commercial) {
		this.idDirection = idDirection;
		this.addressDescription = descriptionTown + " " + street + " " + home + " " + other;
		this.idCountry = idCountry;
		//this.country = new Country();
		//country.setDescription(descriptionCountry);
		this.descriptionCountry = descriptionCountry;
		this.idProvince = idProvince;
		//this.province = new Province();
		//province.setDescriptionProvince(descriptionProvince);
		this.descriptionProvince = descriptionProvince;
		this.idCity = idCity;
		//this.city = new City();
		//city.setDescriptionCity(descriptionCity);
		this.descriptionCity = descriptionCity;
		this.idDistrict = idDistrict;
		//this.district = new District();
		//district.setDescriptionDistrict(descriptionDistrict);
		this.descriptionDistrict = descriptionDistrict;
		this.idTown = idTown;
		//this.town = new Town();
		//town.setDescriptionTown(descriptionTown);
		this.descriptionTown = descriptionTown;
		this.other = other;
		this.type = type;
		//this.office = new Office();
		//office.setOfficeName(officeName);
		this.officeName = officeName;
		this.verified = verified;
		this.main = main;
		this.correspondence = correspondence;
		this.rented = rented;
		this.rentAmount = rentAmount;
		this.charge = charge;
		this.street = street;
		this.home = home;
		this.building = building;
		this.commercial = commercial;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idClient == null) ? 0 : idClient.hashCode());
		result = prime * result
				+ ((idDirection == null) ? 0 : idDirection.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CustomerAddressDTO other = (CustomerAddressDTO) obj;
		if (idClient == null) {
			if (other.idClient != null)
				return false;
		} else if (!idClient.equals(other.idClient))
			return false;
		if (idDirection == null) {
			if (other.idDirection != null)
				return false;
		} else if (!idDirection.equals(other.idDirection))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "CustomerAddressDTO [idClient=" + idClient + ", idDirection="
				+ idDirection + ", addressDescription=" + addressDescription
				+ ", idCountry=" + idCountry + ", descriptionCountry="
				+ descriptionCountry + ", idProvince=" + idProvince
				+ ", descriptionProvince=" + descriptionProvince + ", idCity="
				+ idCity + ", descriptionCity=" + descriptionCity
				+ ", idDistrict=" + idDistrict + ", descriptionDistrict="
				+ descriptionDistrict + ", idTown=" + idTown
				+ ", descriptionTown=" + descriptionTown + ", idOffice="
				+ idOffice + ", officeName=" + officeName + ", other=" + other
				+ ", typeDescription=" + typeDescription + ", type=" + type
				+ ", verified=" + verified + ", main=" + main
				+ ", correspondence=" + correspondence + ", rented=" + rented
				+ ", rentAmount=" + rentAmount + ", charge=" + charge
				+ ", street=" + street + ", home=" + home + ", building="
				+ building + ", commercial=" + commercial + "]";
	}
}
