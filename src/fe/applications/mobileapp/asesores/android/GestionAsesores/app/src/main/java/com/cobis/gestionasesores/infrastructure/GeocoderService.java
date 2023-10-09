package com.cobis.gestionasesores.infrastructure;

import android.location.Address;
import android.location.Geocoder;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.models.LocationData;

import java.util.List;
import java.util.Locale;

/**
 * Geocode location service class
 * Created by mnaunay on 07/08/2017.
 */
public final class GeocoderService {

    /**
     * Allows get latitude and longitude from address
     * @param address Address
     * @return Latitude and longitude into {@link LocationData}
     */
    public LocationData fromAddress(String address){
        LocationData location = null;
        try {
            if(NetworkUtils.isOnline()) {
                if (LibCore.getApplicationContext() == null) {
                    throw new RuntimeException("Operation need application context!!");
                }
                Geocoder geocoder = new Geocoder(LibCore.getApplicationContext(), Locale.getDefault());
                List<Address> addressesList = geocoder.getFromLocationName(address, 1);
                if(addressesList.size()>0){
                   location = new LocationData(addressesList.get(0).getLatitude(),addressesList.get(0).getLongitude());
                }
            }
            Log.d(location!= null?location.toString():"Location Not found");
        }catch (Exception ex){
            Log.e("GeocoderService::fromAddress:",ex);
        }
        return location;
    }
}
