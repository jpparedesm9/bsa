package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.enums.QuestionLocationCode;
import com.cobis.gestionasesores.data.enums.QuestionType;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.requests.QuestionRequest;
import com.cobis.gestionasesores.data.models.requests.VerificationRequest;
import com.cobis.gestionasesores.data.models.requests.VerificationRequestInternal;

import java.util.ArrayList;
import java.util.List;

public class VerificationMapper {
    public static VerificationRequest memberToVerificationRequest(boolean isGroup, MemberVerification verification) {
        VerificationRequestInternal internal = new VerificationRequestInternal();
        internal.setApplicationId(verification.getApplicationId());
        internal.setCustomerId(verification.getServerId());
        internal.setGroup(isGroup);

        if (isGroup) {
//            internal.setHomeAddressGeoReference(AddressMapper.transformToGeoReference(verification.getLocationDataByCode(QuestionLocationCode.GROUP_QUESTION6)));
//            internal.setBusinessAddressGeoReference(AddressMapper.transformToGeoReference(verification.getLocationDataByCode(QuestionLocationCode.GROUP_QUESTION12)));
//            internal.setOfficialGeoReference(AddressMapper.transformToGeoReference(verification.getOfficialGeoReference()));
            internal.setHomeAddressGeoReference(verification.getLocationDataByCode(QuestionLocationCode.GROUP_QUESTION6));
            internal.setBusinessAddressGeoReference(verification.getLocationDataByCode(QuestionLocationCode.GROUP_QUESTION12));
            internal.setOfficialGeoReference(verification.getOfficialGeoReference());
        } else {
//            internal.setHomeAddressGeoReference(AddressMapper.transformToGeoReference(verification.getLocationDataByCode(QuestionLocationCode.INDIVIDUAL_QUESTION3)));
//            internal.setBusinessAddressGeoReference(AddressMapper.transformToGeoReference(verification.getLocationDataByCode(QuestionLocationCode.INDIVIDUAL_QUESTION9)));
//            internal.setOfficialGeoReference(AddressMapper.transformToGeoReference(verification.getOfficialGeoReference()));
            internal.setHomeAddressGeoReference(verification.getLocationDataByCode(QuestionLocationCode.INDIVIDUAL_QUESTION3));
            internal.setBusinessAddressGeoReference(verification.getLocationDataByCode(QuestionLocationCode.INDIVIDUAL_QUESTION9));
            internal.setOfficialGeoReference(verification.getOfficialGeoReference());

        }

        internal.setQuestions(questionToRequests(verification.getQuestions()));

        VerificationRequest request = new VerificationRequest();
        request.setVerification(internal);
        return request;
    }

    private static List<QuestionRequest> questionToRequests(List<Question> questions) {
        List<QuestionRequest> questionRequests = new ArrayList<>();
        for (Question question : questions) {
            if (question.getType() != QuestionType.HEADER) {
                questionRequests.add(new QuestionRequest(question.getValue()));
            }
        }
        return questionRequests;
    }
}
