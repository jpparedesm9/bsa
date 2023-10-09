package com.cobiscorp.ecobis.cloud.service.util;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

import java.math.BigDecimal;

public class ServiceRequestUtil {

    private ServiceRequestUtil() {
    }

    public static CustomerTotalRequest fromResponse(CustomerResponse response) {
        CustomerTotalRequest request = new CustomerTotalRequest();
        request.setAccountIndividual(response.getAccountIndividual());
        //request.setActivity(response.getCustomer);
        //request.setAsfi(response.ge);
        //request.setAssociated(response.ge);
        request.setBirthDate(CalendarUtil.from(response.getCustomerBirthdate()));
        //request.setBroadcastDate(response.getdat);
        request.setBusinessYears(response.getBusinessYears());
        request.setCategory(response.getAmlCategory());
        request.setChargePub(response.getChargePub());
        request.setCityBirth(response.getCityBirth());
        request.setCivilStatus(response.getCustomerMaritalStatus());
        //request.setCode(response.getCode);
        request.setCodeTutor(response.getTutor());
        request.setOtherIncomeSource(response.getOtherIncomeSource());
        request.setOtherIncome(new BigDecimal(response.getOtherIncomes()));
        request.setDependents(response.getDependentsNum());
        request.setCodePerson(response.getCustomerId());
        request.setNumCycles(response.getNumCycles());
        request.setCountyOfBirth(response.getCountyOfBirth());
        request.setCustomerRFC(response.getCustomerRFC());
        request.setExpirationDate(CalendarUtil.from(response.getExpirationDate()));
        request.setFirstSurname(response.getCustomerLastName());
        request.setGender(response.getGender() == null ?  ' ' : response.getGender().charAt(0));
        request.setHasOtherIncome(response.getHasOtherIncome());
        request.setIdentification(response.getCustomerIdentificaction());
        request.setIdentificationType(response.getIdentificationtype());
        request.setLevelStudy(response.getAcademicLevel());
        request.setName(response.getCustomerName());
        request.setNationality(response.getNationalityCountry());
        return request;
    }
}
