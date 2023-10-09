package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by mnaunay on 07/08/2017.
 */

public class LocationData implements Serializable {
    private int serverId;
    private int addressId;
    private double latitude;
    private double longitude;

    public int getAddressId() {
        return addressId;
    }

    public LocationData setAddressId(int addressId) {
        this.addressId = addressId;
        return this;
    }

    public LocationData(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    @Override
    public String toString() {
        return "lat: " + latitude + " Lng: " + longitude;
    }
}
