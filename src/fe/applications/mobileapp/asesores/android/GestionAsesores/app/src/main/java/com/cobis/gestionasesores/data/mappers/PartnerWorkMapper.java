package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.PartnerWork;
import com.cobis.gestionasesores.data.models.requests.PartnerWorkAddress;
import com.cobis.gestionasesores.data.models.requests.PartnerWorkRemote;
import com.cobis.gestionasesores.data.models.requests.PhoneInfo;
import com.cobis.gestionasesores.widgets.phonefield.Countries;

/**
 * Created by bqtdesa02 on 7/31/2017.
 */

public class PartnerWorkMapper {

    public static PartnerWorkRemote partnerWorkToRemote(@NonNull PartnerWork partnerWork) {
        AddressData addressData = partnerWork.getAddressData();
        PartnerWorkAddress partnerWorkAddress = null;
        if (addressData != null) {
            partnerWorkAddress = AddressMapper.transformToWorkAddress(addressData);
        }

        PhoneInfo cellphone = new PhoneInfo();
        cellphone.setNumber(partnerWork.getCellphone());
        cellphone.setAreaCode(String.valueOf(Countries.COUNTRIES.get(0).getDialCode()));
        cellphone.setPhoneId(partnerWork.getCellphoneServerId());

        PhoneInfo workphone = new PhoneInfo();
        workphone.setAreaCode(String.valueOf(Countries.COUNTRIES.get(0).getDialCode()));
        workphone.setNumber(partnerWork.getTelephoneWork());
        workphone.setPhoneId(partnerWork.getWorkphoneServerId());

        PartnerWorkRemote partnerWorkRemote = new PartnerWorkRemote();
        if (partnerWorkAddress != null) {
            partnerWorkRemote.setAddressId(addressData.getServerId());
        }
        partnerWorkRemote.setAddress(partnerWorkAddress);
        partnerWorkRemote.setCellphone(cellphone);
        partnerWorkRemote.setWorkphone(workphone);
        return partnerWorkRemote;
    }

    public static PartnerWork responseToPartnerWork(PartnerWorkRemote remote) {

        PartnerWorkAddress partnerWorkAddress = remote.getAddress();

        PhoneInfo workphone = remote.getWorkphone();
        PhoneInfo cellphone = remote.getCellphone();

        AddressData addressData = new AddressData();
        if (partnerWorkAddress != null) {
            addressData.setCountryCode(String.valueOf(partnerWorkAddress.getCountryCode()));
            addressData.setStreet(partnerWorkAddress.getStreet());
            addressData.setPostalCode(partnerWorkAddress.getPostalCode());
            addressData.setNumber(partnerWorkAddress.getAddressNumber());
            addressData.setInternalNumber(partnerWorkAddress.getAddressInternalNumber());
            addressData.setServerId(partnerWorkAddress.getAddressId());
            addressData.setStateCode(String.valueOf(partnerWorkAddress.getStateCode()));
            addressData.setTownCode(String.valueOf(partnerWorkAddress.getCityCode()));
            addressData.setVillageCode(String.valueOf(partnerWorkAddress.getNeighborhoodCode()));
            addressData.setCity(partnerWorkAddress.getReferenceLandmark());
        }

        PartnerWork.Builder partnerWork = new PartnerWork.Builder()
                .addAddressData(addressData);
        if (workphone != null) {
            partnerWork.addTelephoneWork(workphone.getNumber())
                    .addWorkphoneServerId(workphone.getPhoneId());
        }
        if (cellphone != null) {
            partnerWork.addCellphone(cellphone.getNumber())
                    .addCellphoneServerId(cellphone.getPhoneId());
        }

        return partnerWork.build();
    }
}
