package com.cobiscorp.mobile.model;

import org.codehaus.jackson.annotate.JsonIgnore;

public class Address {

	@JsonIgnore
	private int id;
	@JsonIgnore
	private int customerId;
	private int colony;
	private int municipality;
	private int state;
	private String street;
	private String postalCode;
	private int externalNumber;
	private int internalNumber;
	private int city;
	private int country;
	private String description;
	private String main;
	@JsonIgnore
	private String type;
	private String latitudeCoordinates;
	private Integer latitudeDegrees;
	private Integer latitudeMinutes;
	private Double latitudeSeconds;
	private String longitudeCoordinates;
	private Integer longitudeDegrees;
	private Integer longitudeMinutes;
	private Double longitudeSeconds;
	private String pathCroquis;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int entityId) {
		this.customerId = entityId;
	}

	public int getColony() {
		return colony;
	}

	public void setColony(int colony) {
		this.colony = colony;
	}

	public int getMunicipality() {
		return municipality;
	}

	public void setMunicipality(int municipality) {
		this.municipality = municipality;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public int getExternalNumber() {
		return externalNumber;
	}

	public void setExternalNumber(int externalNumber) {
		this.externalNumber = externalNumber;
	}

	public int getInternalNumber() {
		return internalNumber;
	}

	public void setInternalNumber(int internalNumber) {
		this.internalNumber = internalNumber;
	}

	public int getCity() {
		return city;
	}

	public void setCity(int city) {
		this.city = city;
	}

	public int getCountry() {
		return country;
	}

	public void setCountry(int country) {
		this.country = country;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMain() {
		return main;
	}

	public void setMain(String main) {
		this.main = main;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLatitudeCoordinates() {
		return latitudeCoordinates;
	}

	public void setLatitudeCoordinates(String latitudeCoordinates) {
		this.latitudeCoordinates = latitudeCoordinates;
	}

	public Integer getLatitudeDegrees() {
		return latitudeDegrees;
	}

	public void setLatitudeDegrees(Integer latitudeDegrees) {
		this.latitudeDegrees = latitudeDegrees;
	}

	public Integer getLatitudeMinutes() {
		return latitudeMinutes;
	}

	public void setLatitudeMinutes(Integer latitudeMinutes) {
		this.latitudeMinutes = latitudeMinutes;
	}

	public Double getLatitudeSeconds() {
		return latitudeSeconds;
	}

	public void setLatitudeSeconds(Double latitudeSeconds) {
		this.latitudeSeconds = latitudeSeconds;
	}

	public String getLongitudeCoordinates() {
		return longitudeCoordinates;
	}

	public void setLongitudeCoordinates(String longitudeCoordinates) {
		this.longitudeCoordinates = longitudeCoordinates;
	}

	public Integer getLongitudeDegrees() {
		return longitudeDegrees;
	}

	public void setLongitudeDegrees(Integer longitudeDegrees) {
		this.longitudeDegrees = longitudeDegrees;
	}

	public Integer getLongitudeMinutes() {
		return longitudeMinutes;
	}

	public void setLongitudeMinutes(Integer longitudeMinutes) {
		this.longitudeMinutes = longitudeMinutes;
	}

	public Double getLongitudeSeconds() {
		return longitudeSeconds;
	}

	public void setLongitudeSeconds(Double longitudeSeconds) {
		this.longitudeSeconds = longitudeSeconds;
	}

	public String getPathCroquis() {
		return pathCroquis;
	}

	public void setPathCroquis(String pathCroquis) {
		this.pathCroquis = pathCroquis;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("Address [");
		sb.append("id=");
		sb.append(id);
		sb.append(", customerId=");
		sb.append(customerId);
		sb.append(", colony=");
		sb.append(colony);
		sb.append(", municipality=");
		sb.append(municipality);
		sb.append(", state=");
		sb.append(state);
		sb.append(", street=");
		sb.append(street == null ? "" : street);
		sb.append(", postalCode=");
		sb.append(postalCode == null ? "" : postalCode);
		sb.append(", externalNumber=");
		sb.append(externalNumber);
		sb.append(", internalNumber=");
		sb.append(internalNumber);
		sb.append(", city=");
		sb.append(city);
		sb.append(", country=");
		sb.append(country);
		sb.append(", description=");
		sb.append(description == null ? "" : description);
		sb.append(", main=");
		sb.append(main == null ? "" : main);
		sb.append(", type=");
		sb.append(type == null ? "" : type);
		sb.append(", latitudeCoordinates=");
		sb.append(latitudeCoordinates == null ? "" : latitudeCoordinates);
		sb.append(", latitudeDegrees=");
		sb.append(latitudeDegrees == null ? "" : latitudeDegrees);
		sb.append(", latitudeMinutes=");
		sb.append(latitudeMinutes == null ? "" : latitudeMinutes);
		sb.append(", latitudeSeconds=");
		sb.append(latitudeSeconds == null ? "" : latitudeSeconds);
		sb.append(", latitudeSeconds=");
		sb.append(latitudeSeconds == null ? "" : latitudeSeconds);
		sb.append(", longitudeCoordinates=");
		sb.append(longitudeCoordinates == null ? "" : longitudeCoordinates);
		sb.append(", longitudeDegrees=");
		sb.append(longitudeDegrees == null ? "" : longitudeDegrees);
		sb.append(", longitudeMinutes=");
		sb.append(longitudeMinutes == null ? "" : longitudeMinutes);
		sb.append(", longitudeSeconds=");
		sb.append(longitudeSeconds == null ? "" : longitudeSeconds);
		sb.append(", pathCroquis=");
		sb.append(pathCroquis == null ? "" : pathCroquis);
		sb.append("]");
		return sb.toString();
	}

}
