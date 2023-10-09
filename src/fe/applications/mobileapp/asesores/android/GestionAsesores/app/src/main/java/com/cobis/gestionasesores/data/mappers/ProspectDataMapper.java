package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.requests.CustomerAddressRequest;
import com.cobis.gestionasesores.data.models.requests.PersonalInformationCustomer;
import com.cobis.gestionasesores.data.models.responses.CustomerEntity;
import com.cobis.gestionasesores.utils.DateUtils;

/**
 * Created by bqtdesa02 on 11/10/2017.
 */

public class ProspectDataMapper {

    public static ProspectData responseToProspectData(@NonNull CustomerEntity entity) {

        PersonalInformationCustomer customer = entity.getCustomer().getCustomer();
        CustomerAddressRequest customerAddress = entity.getAddress();

        ProspectData.Builder data = new ProspectData.Builder();
        if (entity.getCustomer() != null && entity.getCustomer().getCustomer() != null) {
            data.setFirstName(customer.getFirstName())
                    .setSecondName(customer.getSecondName())
                    .setLastName(customer.getSurname())
                    .setSecondLastName(customer.getSecondSurname())
                    .setBirthEntityCode(String.valueOf(customer.getCityBirth()))
                    .setBirthDate(DateUtils.parseDateFromService(customer.getBirthDate()))
                    .setSex(customer.getGender())
                    .setCivilStatus(customer.getMaritalStatus())
                    .setRfc(customer.getRfc())
                    .setCurp(customer.getDocumentNumber())
                    .setNumber(customer.getBankCode())
                    .setAccountNumber(customer.getBankAccount());
        }

        if (customerAddress != null) {
            data.setAddressData(AddressMapper.customerAddressToAddressData(customerAddress));
            if (customerAddress.getEmailAddress() != null) {
                data.setEmail(customerAddress.getEmailAddress().getEmail());
            }

        }

        return data.build();
    }
}
