package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CustomerBusiness;
import com.cobis.gestionasesores.data.models.requests.AddressInfo;
import com.cobis.gestionasesores.data.models.requests.Business;
import com.cobis.gestionasesores.data.models.requests.CustomerBusinessRemote;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.utils.DateUtils;

/**
 * Created by bqtdesa02 on 7/31/2017.
 */

public class CustomerWorkMapper {

    public static CustomerBusinessRemote customerBusinessToCustomerBusinessRemote(@NonNull CustomerBusiness customerBusiness, boolean isSync) {
        AddressData addressData = customerBusiness.getAddressData();
        AddressInfo addressInfo = AddressMapper.transformToAddressInfo(addressData, customerBusiness.getLocationType());
        GeoReference geoReference = AddressMapper.transformToGeoReference(addressData.getLocationData());
//        GeoReference officialGeoReference = AddressMapper.transformToGeoReference(addressData.getOficialLocationData());

        addressInfo.setAddressId(addressData.getServerId());

        Business business = new Business();
        business.setBusinessId(customerBusiness.getServerId());
        business.setName(customerBusiness.getName());
        business.setTransfer(customerBusiness.getTurnaround());
        business.setOpenDate(DateUtils.formatDateForService(customerBusiness.getOpeningDate()));
        business.setPhone(customerBusiness.getPhoneNumber());
        business.setPhoneId(customerBusiness.getPhoneId());
        business.setIndustry(customerBusiness.getActivity());
        business.setYearsInBusiness(ConvertUtils.tryToInt(customerBusiness.getTimeActivity(), 0));
        business.setWithWhatResourceWillPayForCredit(customerBusiness.getCreditPay());
        business.setMonthlyRevenue(customerBusiness.getMonthlyIncome());
        business.setCreditPurpose(customerBusiness.getCreditDestination());
        business.setYearsAtAddress(ConvertUtils.tryToInt(customerBusiness.getTimeRooting(), 0));
        business.setOwnershipType(customerBusiness.getLocationType());

        CustomerBusinessRemote remote = new CustomerBusinessRemote();
        remote.setOnline(!isSync);
        remote.setBusiness(business);
        remote.setGeoReference(geoReference);
        remote.setAddress(addressInfo);
//        remote.setOfficialGeoReference(officialGeoReference);

        return remote;
    }

    public static CustomerBusiness responseToCustomerBusiness(CustomerBusinessRemote remote) {
        Business business = remote.getBusiness();
        AddressInfo addressInfo = remote.getAddress();
        CustomerBusiness.Builder customerBusiness = new CustomerBusiness.Builder();
        if (addressInfo != null) {
            AddressData addressData = AddressMapper.transformToAddressData(addressInfo, remote.getGeoReference());
            addressData.setServerId(addressInfo.getAddressId() != null ? addressInfo.getAddressId() : 0);
            customerBusiness.addAddressData(addressData);
        }
        if (business != null) {
            customerBusiness.addServerId(business.getBusinessId())
                    .addName(business.getName())
                    .addTurnaround(business.getTransfer())
                    .addCreditDestination(business.getCreditPurpose())
                    .addPhoneNumber(business.getPhone())
                    .addPhoneId(business.getPhoneId())
                    .addActivity(business.getIndustry())
                    .addTimeActivity(String.valueOf(business.getYearsInBusiness()))
                    .addTimeRooting(String.valueOf(business.getYearsAtAddress()))
                    .addOpeningDate(DateUtils.parseDateFromService(business.getOpenDate()))
                    .addCreditPay(business.getWithWhatResourceWillPayForCredit())
                    .addMonthlyIncome(business.getMonthlyRevenue())
                    .addLocationType(business.getOwnershipType());
        }

        return customerBusiness.build();
    }
}
