package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.requests.AddressRequest;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.data.models.requests.PersonalInformation;
import com.cobis.gestionasesores.data.models.requests.ProspectRequest;
import com.cobis.gestionasesores.data.models.responses.AddressDataResponse;
import com.cobis.gestionasesores.data.models.responses.PersonalInformationData;
import com.cobis.gestionasesores.data.models.responses.ProspectResponse;
import com.cobis.gestionasesores.utils.DateUtils;

public class ProspectMapper {

    public static final String DOCUMENT_TYPE = "CURP";

    public static ProspectRequest prospectToProspectRequest(@NonNull Person prospect, boolean isSync) {
        Section prospectDataSection = Person.getSection(SectionCode.PROSPECT_DATA, prospect.getSections());
        ProspectData prospectData = (ProspectData) prospectDataSection.getSectionData();

        PersonalInformation personalInformation = new PersonalInformation();
        personalInformation.setCustomerId(prospect.getServerId());
        personalInformation.setFirstName(prospectData.getFirstName());
        personalInformation.setSecondName(prospectData.getSecondName());
        personalInformation.setSurname(prospectData.getLastName());
        personalInformation.setSecondSurname(prospectData.getSecondLastName());
        personalInformation.setBirthDate(DateUtils.formatDateForService(prospectData.getBirthDate()));
        personalInformation.setGender(prospectData.getSex());
        personalInformation.setMaritalStatus(prospectData.getCivilStatus());
        personalInformation.setEmailAddress(prospectData.getEmail());
        personalInformation.setDocumentNumber(prospectData.getCurp());
        personalInformation.setDocumentType(DOCUMENT_TYPE);
        personalInformation.setCityBirth(ConvertUtils.tryToInt(prospectData.getBirthEntityCode(), 0));
//        personalInformation.setExpirationDate();

        AddressRequest addressRequest = new AddressRequest();
        AddressData addressData = prospectData.getAddressData();
        addressRequest.setCustomerId(prospect.getServerId());
        addressRequest.setAddressId(addressData.getServerId());
        // FIXME: 7/12/2017 Not sure if this is this value is taken from parameter
        addressRequest.setCountryCode(ConvertUtils.tryToInt(BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_COUNTRY), 0));
        addressRequest.setPostalCode(addressData.getPostalCode());
        addressRequest.setProvinceCode(ConvertUtils.tryToInt(addressData.getStateCode(), 0));
        addressRequest.setCityCode(ConvertUtils.tryToInt(addressData.getTownCode(), 0));
        addressRequest.setParishCode(ConvertUtils.tryToInt(addressData.getVillageCode(), 0));
        addressRequest.setStreet(addressData.getStreet());
        addressRequest.setDirectionNumber(addressData.getNumber());
        addressRequest.setDirectionNumberInternal(addressData.getInternalNumber());
        addressRequest.setReferenceLandmark(addressData.getCity());

        GeoReference geoReference = AddressMapper.transformToGeoReference(addressData.getLocationData());
//        GeoReference officialGeoReference = AddressMapper.transformToGeoReference(addressData.getOficialLocationData());

        ProspectRequest prospectRequest = new ProspectRequest();
        prospectRequest.setOnline(!isSync);
        prospectRequest.setProspect(personalInformation);
        prospectRequest.setAddress(addressRequest);
        prospectRequest.setGeoReference(geoReference);
//        prospectRequest.setOfficialGeoReference(officialGeoReference);

        return prospectRequest;
    }

    public static ProspectData responseToProspectData(ProspectResponse response) {
        PersonalInformationData prospect = response.getProspect();

        AddressDataResponse addressData = response.getAddress();

        LocationData locationData = AddressMapper.transformToLocationData(response.getGeoReference());

        int emailAddressId = prospect.getEmailAddressId() == null ? 0 : prospect.getEmailAddressId();

        AddressData address = null;
        if (addressData != null) {
            address = new AddressData();
            address.setServerId(addressData.getAddressId());
            address.setCountryCode(String.valueOf(addressData.getCountryCode()));
            address.setStateCode(String.valueOf(addressData.getProvinceCode()));
            address.setTownCode(String.valueOf(addressData.getCityCode()));
            address.setVillageCode(String.valueOf(addressData.getParishCode()));
            address.setStreet(addressData.getStreet());
            address.setPostalCode(addressData.getPostalCode());
            address.setNumber(addressData.getDirectionNumber());
            address.setInternalNumber(addressData.getDirectionNumberInternal());
            address.setCity(addressData.getReferenceLandmark());
            address.setLocationData(locationData);
        }
        return new ProspectData.Builder()
                .setAddressData(address)
                .setFirstName(prospect.getFirstName())
                .setSecondName(prospect.getSecondName())
                .setLastName(prospect.getSurname())
                .setSecondLastName(prospect.getSecondSurname())
                .setBirthDate(DateUtils.parseDateFromService(prospect.getBirthDate()))
                .setBirthEntityCode(String.valueOf(prospect.getCityBirth()))
                .setEmail(prospect.getEmailAddress())
                .setCivilStatus(prospect.getMaritalStatus())
                .setSex(prospect.getGender())
                .setCurp(prospect.getDocumentNumber())
                .setRfc(prospect.getRfc())
                .setEmailAddressId(emailAddressId)
                .build();
    }

    public static ProspectData generateProspectData(GeneralPersonData generalPersonData, String civilStatus) {
        return new ProspectData.Builder()
                .setFirstName(generalPersonData.getFirstName())
                .setSecondName(generalPersonData.getSecondName())
                .setLastName(generalPersonData.getLastName())
                .setSecondLastName(generalPersonData.getSecondLastName())
                .setSex(generalPersonData.getSex())
                .setRfc(generalPersonData.getRfc())
                .setCurp("")
                .setCivilStatus(civilStatus)
                .setBirthEntityCode(generalPersonData.getBirthEntityCode())
                .setBirthEntityAdditionalCode(generalPersonData.getBirthEntityAdditionalCode())
                .setBirthDate(generalPersonData.getBirthDate()).build();
    }
}
