package com.cobiscorp.ecobis.customer.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(CustomerAddressId.class)
@Table(name = "cl_direccion", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "CustomerAddress.getAllAddress", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO(d.idDirection, d.idCountry,c.descriptionCountry, d.idProvince, p.descriptionProvince, d.idCity, ci.descriptionCity, d.idDistrict, di.descriptionDistrict,d.idTown, t.descriptionTown, d.other, d.type, d.idOffice, o.officeName, d.verified, d.main, d.correspondence, d.rented, d.rentAmount, d.charge, d.street, d.home, d.building, d.commercial)"
		+ " from CustomerAddress d left join d.country c join d.province p join d.city ci join d.district di join d.town t join d.office o"
		+ " where d.idClient = :idClient" + " order by d.idDirection") })
/**
 * Class used to access the database using JPA
 * related table: cl_direccion, bdd: cobis.
 * @author bbuendia
 *
 */
public class CustomerAddress {

	@Id
	@Column(name = "di_ente")
	private Integer idClient;

	@Id
	@Column(name = "di_direccion")
	private Integer idDirection;

	@Transient
	private String addressDescription;

	@Column(name = "di_pais")
	private Integer idCountry;

	@ManyToOne
	@JoinColumn(name = "di_pais", referencedColumnName = "pa_pais")
	private Country country;

	@Column(name = "di_provincia")
	private Integer idProvince;

	@ManyToOne
	@JoinColumn(name = "di_provincia", referencedColumnName = "pv_provincia")
	private Province province;

	@Column(name = "di_ciudad")
	private Integer idCity;

	@ManyToOne
	@JoinColumn(name = "di_ciudad", referencedColumnName = "ci_ciudad")
	private City city;

	@Column(name = "di_parroquia")
	private Integer idDistrict;

	@ManyToOne
	@JoinColumns({
			@JoinColumn(name = "di_parroquia", referencedColumnName = "pq_parroquia"),
			@JoinColumn(name = "di_ciudad", referencedColumnName = "pq_ciudad") })
	private District district;

	@Column(name = "di_codbarrio")
	private Integer idTown;

	@ManyToOne
	@JoinColumns({
			@JoinColumn(name = "di_codbarrio", referencedColumnName = "ba_barrio"),
			@JoinColumn(name = "di_ciudad", referencedColumnName = "ba_canton"),
			@JoinColumn(name = "di_parroquia", referencedColumnName = "ba_distrito") })
	private Town town;

	@Column(name = "di_oficina")
	private Integer idOffice;

	@ManyToOne
	@JoinColumn(name = "di_oficina", referencedColumnName = "of_oficina")
	private Office office;

	@Column(name = "di_otrasenas")
	private String other;

	@Transient
	private String typeDescription;

	@Column(name = "di_tipo")
	private String type;

	@Column(name = "di_verificado")
	private String verified;

	@Column(name = "di_principal")
	private String main;

	@Column(name = "di_correspondencia")
	private String correspondence;

	@Column(name = "di_alquilada")
	private String rented;

	@Column(name = "di_montoalquiler")
	private Double rentAmount;

	@Column(name = "di_cobro")
	private String charge;

	@Column(name = "di_calle")
	private String street;

	@Column(name = "di_casa")
	private String home;

	@Column(name = "di_edificio")
	private String building;

	@Column(name = "di_so_igu_co")
	private String commercial;

	public CustomerAddress() {

	}

	public CustomerAddress(Integer idDirection, Integer idCountry,
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
		this.country = new Country();
		country.setDescription(descriptionCountry);
		this.idProvince = idProvince;
		this.province = new Province();
		province.setDescriptionProvince(descriptionProvince);
		this.idCity = idCity;
		this.city = new City();
		city.setDescriptionCity(descriptionCity);
		this.idDistrict = idDistrict;
		this.district = new District();
		district.setDescriptionDistrict(descriptionDistrict);
		this.idTown = idTown;
		this.town = new Town();
		town.setDescriptionTown(descriptionTown);
		this.other = other;
		this.type = type;
		this.office = new Office();
		office.setOfficeName(officeName);
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

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public Province getProvince() {
		return province;
	}

	public void setProvince(Province province) {
		this.province = province;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public District getDistrict() {
		return district;
	}

	public void setDistrict(District district) {
		this.district = district;
	}

	public Town getTown() {
		return town;
	}

	public void setTown(Town town) {
		this.town = town;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public String getTypeDescription() {
		return typeDescription;
	}

	public void setTypeDescription(String typeDescription) {
		this.typeDescription = typeDescription;
	}
	
}
