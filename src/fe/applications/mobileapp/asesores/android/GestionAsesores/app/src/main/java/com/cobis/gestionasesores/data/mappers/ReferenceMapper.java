package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.requests.CustomerReferencesRemote;
import com.cobis.gestionasesores.data.models.requests.ReferenceRequest;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class ReferenceMapper {

    public static ReferenceRequest referenceToReferenceRequest(Reference reference, boolean isSync) {
        CustomerReferencesRemote.ReferenceInfo referenceInfo = new CustomerReferencesRemote.ReferenceInfo();
        referenceInfo.setReferenceId(reference.getServerId());
        referenceInfo.setEmailAddress(reference.getEmail());
        referenceInfo.setFirstName(reference.getName());
        referenceInfo.setSurname(reference.getLastName());

        referenceInfo.setPhone(reference.getPhone());
        referenceInfo.setTimeOfRelationship(ConvertUtils.tryToInt(reference.getTimeToMeet(), 0));

        ReferenceRequest referenceRequest = new ReferenceRequest();
        referenceRequest.setOnline(!isSync);
        referenceRequest.setReference(referenceInfo);
        return referenceRequest;
    }

    public static Reference responseToReference(CustomerReferencesRemote.ReferenceInfo referenceInfo) {
        Reference reference = new Reference();
        reference.setStatus(SyncStatus.SYNCED);//MNA: when download default is synchronized!!
        reference.setServerId(referenceInfo.getReferenceId());
        reference.setEmail(referenceInfo.getEmailAddress());

        reference.setPhone(referenceInfo.getPhone());


        reference.setTimeToMeet(String.valueOf(referenceInfo.getTimeOfRelationship()));
        reference.setName(referenceInfo.getFirstName());
        reference.setLastName(referenceInfo.getSurname());

        return reference;
    }

    public static List<Reference> reponsesToRefrences(@NonNull List<CustomerReferencesRemote.ReferenceInfo> referenceInfos) {
        List<Reference> result = new ArrayList<>();
        for (CustomerReferencesRemote.ReferenceInfo referenceInfo : referenceInfos) {
            result.add(responseToReference(referenceInfo));
        }
        return result;
    }

    public static List<Reference> toReferencesInfo(@NonNull CustomerReferencesRemote references) {
        List<Reference> result = new ArrayList<>();
        if(references.getReference() != null) {
            for (CustomerReferencesRemote.ReferenceInfo referenceInfo : references.getReference()) {
                result.add(responseToReference(referenceInfo));
            }
        }
        return result;
    }
}
