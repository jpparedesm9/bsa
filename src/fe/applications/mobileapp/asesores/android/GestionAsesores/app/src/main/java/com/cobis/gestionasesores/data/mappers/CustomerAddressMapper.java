package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.requests.AddressInfo;
import com.cobis.gestionasesores.data.models.requests.CustomerAddressRequest;
import com.cobis.gestionasesores.data.models.requests.EmailAddress;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.data.models.requests.PhoneInfo;
import com.cobis.gestionasesores.data.models.requests.ProspectRequest;
import com.cobis.gestionasesores.widgets.phonefield.Countries;

/**
 * Created by bqtdesa02 on 7/27/2017.
 */

public class CustomerAddressMapper {

    public static CustomerAddressRequest personToCustomerAddressRequest(@NonNull Person person, boolean isSync) {
        Section prospectDataSection = Person.getSection(SectionCode.CUSTOMER_ADDRESS, person.getSections());
        CustomerAddress customerAddress = (CustomerAddress) prospectDataSection.getSectionData();

        AddressData addressData = customerAddress.getAddressData();
        AddressInfo addressInfo = AddressMapper.transformToAddressInfo(addressData, customerAddress.getHousingType());
        addressInfo.setYearsAtAddress(ConvertUtils.tryToInt(customerAddress.getYearsInCurrentAddress(), 0));
        addressInfo.setNumberOfResidents(ConvertUtils.tryToInt(customerAddress.getNumPeopleLivingInAddress(), 0));

        EmailAddress emailAddress = new EmailAddress();
        emailAddress.setAddressId(customerAddress.getEmailServerId());
        emailAddress.setEmail(customerAddress.getEmail());

        PhoneInfo phoneInfo = new PhoneInfo();
        phoneInfo.setPhoneId(customerAddress.getPhoneServerId());
        phoneInfo.setAreaCode(String.valueOf(Countries.COUNTRIES.get(0).getDialCode()));
        phoneInfo.setNumber(customerAddress.getTelephone());

        PhoneInfo cellPhoneInfo = new PhoneInfo();
        cellPhoneInfo.setPhoneId(customerAddress.getCellphoneServerId());
        cellPhoneInfo.setAreaCode(String.valueOf(Countries.COUNTRIES.get(0).getDialCode()));
        cellPhoneInfo.setNumber(customerAddress.getCellphone());

        GeoReference geoReference = AddressMapper.transformToGeoReference(addressData.getLocationData());
//        GeoReference officialGeoReference = AddressMapper.transformToGeoReference(addressData.getOficialLocationData());

        CustomerAddressRequest addressRequest = new CustomerAddressRequest();
        addressRequest.setOnline(!isSync);
        addressRequest.setAddress(addressInfo);
        addressRequest.setAddressId(customerAddress.getAddressData().getServerId());
        addressRequest.setEmailAddress(emailAddress);
        addressRequest.setPhone(phoneInfo);
        addressRequest.setGeoReference(geoReference);
//        addressRequest.setOfficialGeoReference(officialGeoReference);
        addressRequest.setCellphone(cellPhoneInfo);

        return addressRequest;
    }

    public static CustomerAddress responseToCustomerAddress(CustomerAddressRequest customerAddressRequest) {
        AddressInfo addressInfo = customerAddressRequest.getAddress();
        AddressData addressData = AddressMapper.transformToAddressData(addressInfo, customerAddressRequest.getGeoReference());

        PhoneInfo phone = customerAddressRequest.getPhone();
        PhoneInfo cellphone = customerAddressRequest.getCellphone();
        EmailAddress emailAddress = customerAddressRequest.getEmailAddress();

        CustomerAddress.Builder customerAddress = new CustomerAddress.Builder();

        if (addressData != null) {
            addressData.setServerId(customerAddressRequest.getAddressId());
            customerAddress.addAddressData(addressData);
        }

        if (phone != null) {
            customerAddress.addPhoneServerId(phone.getPhoneId())
                    .addTelephone(phone.getNumber());
        }

        if (cellphone != null) {
            customerAddress.addCellphone(cellphone.getNumber())
                    .addCellphoneServerId(cellphone.getPhoneId());
        }

        if (emailAddress != null) {
            customerAddress.addEmail(customerAddressRequest.getEmailAddress().getEmail())
                    .addEmailServerId(customerAddressRequest.getEmailAddress().getAddressId());
        }

        if (addressInfo != null) {
            customerAddress.addYearsInCurrentAddress(String.valueOf(addressInfo.getYearsAtAddress()))
                    .addHousingType(addressInfo.getOwnershipType())
                    .addNumPeopleLivingInAddress(String.valueOf(addressInfo.getNumberOfResidents()));
        }

        return customerAddress.build();
    }
}
