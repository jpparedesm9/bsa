package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

import java.io.Serializable;

/**
 * Created by Miguel on 14/06/2017.
 */
public class AddressData implements Serializable {
    private int serverId;
    private String stateName;
    private String townName;
    private String villageName;
    private String street;
    private String postalCode;
    private int number;
    private int internalNumber;
    private String countryCode;
    private String stateCode;
    private String townCode;
    private String villageCode;
    private LocationData locationData;
//    private LocationData oficialLocationData;
    private String city;

    public AddressData() {
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
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

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getInternalNumber() {
        return internalNumber;
    }

    public void setInternalNumber(int internalNumber) {
        this.internalNumber = internalNumber;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public String getStateCode() {
        return stateCode;
    }

    public void setStateCode(String stateCode) {
        this.stateCode = stateCode;
    }

    public String getTownCode() {
        return townCode;
    }

    public void setTownCode(String townCode) {
        this.townCode = townCode;
    }

    public String getVillageCode() {
        return villageCode;
    }

    public void setVillageCode(String villageCode) {
        this.villageCode = villageCode;
    }

    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    public String getTownName() {
        return townName;
    }

    public void setTownName(String townName) {
        this.townName = townName;
    }

    public String getVillageName() {
        return villageName;
    }

    public void setVillageName(String villageName) {
        this.villageName = villageName;
    }

    public LocationData getLocationData() {
        return locationData;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setLocationData(LocationData locationData) {
        this.locationData = locationData;
    }

//    public LocationData getOficialLocationData() {
//        return oficialLocationData;
//    }
//
//    public AddressData setOficialLocationData(LocationData oficialLocationData) {
//        this.oficialLocationData = oficialLocationData;
//        return this;
//    }

    public boolean isComplete(){
        boolean isComplete = true;
        if (StringUtils.isEmpty(street)) {
            isComplete = false;
        }

        if (number == -1) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(postalCode)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(stateCode)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(townCode)) {
            isComplete = false;
        }
        if (StringUtils.isEmpty(villageCode)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(city)){
            isComplete=false;
        }
        return isComplete;
    }
}
