package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.enums.QuestionAnswer;
import com.cobis.gestionasesores.data.models.ComplementaryData;
import com.cobis.gestionasesores.data.models.requests.ComplementaryDataRemote;
import com.cobis.gestionasesores.data.models.requests.ComplementaryDataRequest;
import com.cobis.gestionasesores.data.models.requests.ComplementaryInfo;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class ComplementaryDataMapper {

    public static ComplementaryDataRequest complementaryDataToRequest(int personId, @NonNull ComplementaryData complementaryData, boolean isSync) {
        ComplementaryInfo complementaryInfo = new ComplementaryInfo();
        complementaryInfo.setPassport(complementaryData.getPassportNumber());
        complementaryInfo.setCodePerson(personId);
        complementaryInfo.setPhoneMessage(complementaryData.getMsgPhoneNumber());
        complementaryInfo.setIfeNumber(complementaryData.getIfeNumber());
        complementaryInfo.setSerialNumberSignatureElect(complementaryData.geteSignSN());
        complementaryInfo.setPersonMessage(complementaryData.getMsgDelegateName());
        complementaryInfo.setBuroAntecedent(complementaryData.hasAntecedentsBureau() ? QuestionAnswer.YES : QuestionAnswer.NO);

        ComplementaryDataRequest complementaryDataRequest = new ComplementaryDataRequest();
        complementaryDataRequest.setOnline(!isSync);
        complementaryDataRequest.setComplementary(complementaryInfo);
        return complementaryDataRequest;
    }

    public static ComplementaryData responseToComplementaryData(ComplementaryDataRemote dataRemote) {
        if (dataRemote == null) {
            return new ComplementaryData();
        }
        return new ComplementaryData.Builder()
                .addIfeNumber(dataRemote.getIfeNumber())
                .addPassportNumber(dataRemote.getPassport())
                .addeSignSN(dataRemote.getSerialNumberSignatureElect())
                .addMsgPhoneNumber(dataRemote.getPhoneMessage())
                .addMsgDelegateName(dataRemote.getPersonMessage())
                .addHasAntecedentsBureau(dataRemote.getBuroAntecedent())
                .addConventionalPhoneNumber(dataRemote.getLandlineOne())
                .build();
    }
}