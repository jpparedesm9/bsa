package com.cobis.gestionasesores.data.models.requests;

import java.io.Serializable;

/**
 * Created by bqtdesa02 on 7/27/2017.
 */

public class GeoReference implements Serializable {
    private int addressId;
    private double latitude;
    private double longitude;

    public int getAddressId() {
        return addressId;
    }

    public GeoReference setAddressId(int addressId) {
        this.addressId = addressId;
        return this;
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
}
