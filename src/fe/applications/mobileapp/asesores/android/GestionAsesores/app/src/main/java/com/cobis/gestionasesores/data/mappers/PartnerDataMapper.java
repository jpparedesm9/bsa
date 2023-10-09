package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.requests.PartnerAdditionalInfo;
import com.cobis.gestionasesores.data.models.requests.PartnerDataRemote;
import com.cobis.gestionasesores.data.models.requests.PartnerInfo;
import com.cobis.gestionasesores.utils.DateUtils;

/**
 * Created by bqtdesa02 on 7/31/2017.
 */

public class PartnerDataMapper {

    public static PartnerDataRemote partnerToPartnerDataRequest(@NonNull PartnerData partnerData, boolean isSync) {

        GeneralPersonData generalPersonData = partnerData.getGeneralPersonData();

        PartnerInfo partnerInfo = new PartnerInfo();
        partnerInfo.setSpouseId(partnerData.getServerId());
        partnerInfo.setFirstName(generalPersonData.getFirstName());
        partnerInfo.setSecondName(generalPersonData.getSecondName());
        partnerInfo.setSurname(generalPersonData.getLastName());
        partnerInfo.setSecondSurname(generalPersonData.getSecondLastName());
        partnerInfo.setBirthDate(DateUtils.formatDateForService(generalPersonData.getBirthDate()));
        partnerInfo.setGender(generalPersonData.getSex());
        partnerInfo.setCityBirth(ConvertUtils.tryToInt(generalPersonData.getBirthEntityCode(), 0));
        partnerInfo.setRfc(generalPersonData.getRfc());

        PartnerAdditionalInfo partnerAdditionalInfo = new PartnerAdditionalInfo();
        partnerAdditionalInfo.setSpouseId(partnerData.getServerId());
        partnerAdditionalInfo.setCountryOfBirth(ConvertUtils.tryToInt(generalPersonData.getBirthCountry(), 0));
        partnerAdditionalInfo.setNationality(ConvertUtils.tryToInt(generalPersonData.getNationality(), 0));
        partnerAdditionalInfo.setEducation(generalPersonData.getEducationLevel());
        partnerAdditionalInfo.setProfession(generalPersonData.getOccupation());

        PartnerDataRemote request = new PartnerDataRemote();
        request.setOnline(!isSync);
        request.setSpouse(partnerInfo);
        request.setAdditional(partnerAdditionalInfo);
        request.setEconomicActivity(partnerData.getActivity());
        return request;
    }

    public static PartnerData responseToPartnerData(PartnerDataRemote response) {
        PartnerInfo partnerInfo = response.getSpouse();
        PartnerAdditionalInfo partnerAdditionalInfo = response.getAdditional();

        GeneralPersonData.Builder generalPersonData = new GeneralPersonData.Builder();
        if (partnerInfo != null) {
            generalPersonData.setFirstName(partnerInfo.getFirstName())
                    .setSecondName(partnerInfo.getSecondName())
                    .setLastName(partnerInfo.getSurname())
                    .setSecondLastName(partnerInfo.getSecondSurname())
                    .setBirthDate(DateUtils.parseDateFromService(partnerInfo.getBirthDate()))
                    .setBirthEntityCode(String.valueOf(partnerInfo.getCityBirth()))
                    .setSex(partnerInfo.getGender())
                    .setRfc(partnerInfo.getRfc());
        }
        if (partnerAdditionalInfo != null) {
            generalPersonData.setBirthCountry(String.valueOf(partnerAdditionalInfo.getCountryOfBirth()))
                    .setNationality(String.valueOf(partnerAdditionalInfo.getNationality()))
                    .setEducationLevel(partnerAdditionalInfo.getEducation())
                    .setOccupation(partnerAdditionalInfo.getProfession());
        }

        return new PartnerData.Builder()
                .addServerId(partnerInfo != null? partnerInfo.getSpouseId(): 0)
                .addActivity(response.getEconomicActivity())
                .addGeneralPersonData(generalPersonData.build())
                .build();
    }


    public static PartnerData fromProspectData(ProspectData prospectData) {
        return new PartnerData.Builder()
                .addGeneralPersonData(new GeneralPersonData.Builder()
                        .setBirthEntityAdditionalCode(prospectData.getBirthEntityAdditionalCode())
                        .setBirthDate(prospectData.getBirthDate())
                        .setBirthEntityCode(prospectData.getBirthEntityCode())
                        .setFirstName(prospectData.getFirstName())
                        .setLastName(prospectData.getLastName())
                        .setRfc(prospectData.getRfc())
                        .setSecondLastName(prospectData.getSecondLastName())
                        .setSecondName(prospectData.getSecondName())
                        .setSex(prospectData.getSex())
                        .build())
                .build();
    }
}
