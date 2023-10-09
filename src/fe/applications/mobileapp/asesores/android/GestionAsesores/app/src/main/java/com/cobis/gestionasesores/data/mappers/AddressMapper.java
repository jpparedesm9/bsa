package com.cobis.gestionasesores.data.mappers;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.requests.AddressInfo;
import com.cobis.gestionasesores.data.models.requests.CustomerAddressRequest;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.data.models.requests.PartnerWorkAddress;

/**
 * Created by mnaunay on 07/08/2017.
 */

public final class AddressMapper {

    public static AddressInfo transformToAddressInfo(AddressData addressData,String ownerShipType){
        AddressInfo addressInfo = new AddressInfo();
        addressInfo.setCountryCode(BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.DEFAULT_COUNTRY));
        addressInfo.setPostalCode(addressData.getPostalCode());
        addressInfo.setStateCode(ConvertUtils.tryToInt(addressData.getStateCode(), 0));
        addressInfo.setCityCode(ConvertUtils.tryToInt(addressData.getTownCode(), 0));
        addressInfo.setNeighborhoodCode(ConvertUtils.tryToInt(addressData.getVillageCode(), 0));
        addressInfo.setStreet(addressData.getStreet());
        addressInfo.setAddressNumber(addressData.getNumber());
        addressInfo.setAddressInternalNumber(addressData.getInternalNumber());
        addressInfo.setOwnershipType(ownerShipType);
        addressInfo.setReferenceLandmark(addressData.getCity());
        return addressInfo;
    }

    public static AddressData transformToAddressData(AddressInfo addressInfo, GeoReference geoReference){
        if(addressInfo != null) {
            AddressData addressData = new AddressData();
            addressData.setCountryCode(String.valueOf(addressInfo.getCountryCode()));
            addressData.setStreet(addressInfo.getStreet());
            addressData.setPostalCode(addressInfo.getPostalCode());
            addressData.setNumber(addressInfo.getAddressNumber());
            addressData.setInternalNumber(addressInfo.getAddressInternalNumber());
            addressData.setStateCode(String.valueOf(addressInfo.getStateCode()));
            addressData.setTownCode(String.valueOf(addressInfo.getCityCode()));
            addressData.setVillageCode(String.valueOf(addressInfo.getNeighborhoodCode()));
            addressData.setLocationData(AddressMapper.transformToLocationData(geoReference));
            addressData.setCity(addressInfo.getReferenceLandmark());
            return addressData;
        }
        return null;
    }

    public static AddressData customerAddressToAddressData(CustomerAddressRequest address){
        AddressData addressData = transformToAddressData(address.getAddress(), address.getGeoReference());
        addressData.setServerId(address.getAddressId());
        return addressData;
    }

    public static GeoReference transformToGeoReference(LocationData locationData){
        GeoReference remote= null;
        if(locationData != null){
            remote = new GeoReference();
            remote.setLatitude(locationData.getLatitude());
            remote.setLongitude(locationData.getLongitude());
        }
        return remote;
    }

    public static LocationData transformToLocationData(GeoReference geoReference) {
        if(geoReference!= null){
            LocationData locationData = new LocationData(geoReference.getLatitude(),geoReference.getLongitude());
            //locationData.setServerId(geoReference.getGeoReferenceId());
            return locationData;
        }
        return null;
    }

    public static PartnerWorkAddress transformToWorkAddress(AddressData addressData){
        PartnerWorkAddress partnerWorkAddress = new PartnerWorkAddress();
        partnerWorkAddress.setAddressId(addressData.getServerId());
        partnerWorkAddress.setStreet(addressData.getStreet());
        partnerWorkAddress.setAddressNumber(addressData.getNumber());
        partnerWorkAddress.setAddressInternalNumber(addressData.getInternalNumber());
        partnerWorkAddress.setNeighborhoodCode(ConvertUtils.tryToInt(addressData.getVillageCode(), 0));
        partnerWorkAddress.setCityCode(ConvertUtils.tryToInt(addressData.getTownCode(), 0));
        partnerWorkAddress.setStateCode(ConvertUtils.tryToInt(addressData.getStateCode(), 0));
        partnerWorkAddress.setCountryCode(BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.DEFAULT_COUNTRY));
        partnerWorkAddress.setPostalCode(addressData.getPostalCode());
        partnerWorkAddress.setReferenceLandmark(addressData.getCity());
        return partnerWorkAddress;
    }
}