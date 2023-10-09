package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.QuestionType;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.GroupVerification;
import com.cobis.gestionasesores.data.models.IndividualVerification;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.responses.QuestionRemote;
import com.cobis.gestionasesores.data.models.responses.VerificationGroupRemote;
import com.cobis.gestionasesores.data.models.responses.VerificationGroupResponseItem;
import com.cobis.gestionasesores.data.models.responses.VerificationIndividualRemote;
import com.cobis.gestionasesores.data.models.responses.VerificationIndividualResponseItem;
import com.cobis.gestionasesores.data.models.responses.VerificationRemote;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.utils.GsonHelper;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class TaskMapper {
    public static List<GroupVerification> fromRemoteList(List<VerificationGroupResponseItem> remoteItems) {
        List<GroupVerification> results = new ArrayList<>();
        for (VerificationGroupResponseItem item : remoteItems) {
            results.add(fromRemote(item.getEntity()));
        }
        return results;
    }

    public static List<IndividualVerification> fromIndividualRemoteList(List<VerificationIndividualResponseItem> remoteItems) {
        List<IndividualVerification> results = new ArrayList<>();
        for (VerificationIndividualResponseItem item : remoteItems) {
            results.add(fromIndividualRemote(item.getEntity()));
        }
        return results;
    }

    public static GroupVerification fromRemote(VerificationGroupRemote item) {
        GroupVerification group = new GroupVerification();
        group.setName(item.getName());
        group.setServerId(item.getProcessInstance());// identifier for cobis!!!
        group.setGroupId(item.getGroupId());
        group.setMemberVerifications(fromRemoteVerifications(item.getVerification()));
        return group;
    }

    public static IndividualVerification fromIndividualRemote(VerificationIndividualRemote item) {
        IndividualVerification individual = new IndividualVerification();
        individual.setServerId(item.getProcessInstance()); // identifier for cobis!!!
        for (VerificationRemote member: item.getVerification()) {
            if(!member.isAval()){
                individual.setName(member.getCustomerName());
            }
        }
        individual.setMemberVerifications(fromRemoteVerifications(item.getVerification()));
        return individual;
    }

    private static List<MemberVerification> fromRemoteVerifications(List<VerificationRemote> verificationRemotes) {
        List<MemberVerification> result = new ArrayList<>();
        for (VerificationRemote member : verificationRemotes) {
            result.add(fromRemoteVerification(member));
        }
        return result;
    }

    private static MemberVerification fromRemoteVerification(VerificationRemote verificationRemote) {
        MemberVerification member = new MemberVerification();
        member.setApplicationId(verificationRemote.getApplicationId());
        member.setServerId(verificationRemote.getCustomerId());
        member.setAval(verificationRemote.isAval());
        member.setName(verificationRemote.getCustomerName());
        member.setGroup(verificationRemote.isGroup());
        member.setScore(verificationRemote.getResult());
        member.setQuestions(fromQuestionRemotes(verificationRemote.isGroup(), verificationRemote.getQuestions()));
        member.setBusinessAddressGeoReference(verificationRemote.getBusinessAddressGeoReference());
        member.setHomeAddressGeoReference(verificationRemote.getHomeAddressGeoReference());
        return member;
    }

    private static List<Question> fromQuestionRemotes(boolean isFromGroup, List<QuestionRemote> remotes) {
        //retrieve questions raw values from catalog
        List<CatalogItem> questionsRaw = CatalogRepository.getInstance().getCatalogItemsByCode(isFromGroup ? Catalog.CAT_QUESTIONS_GROUP : Catalog.CAT_QUESTIONS_INDIVIDUAL);

        //--COBIS definition: Server not return code for question, the code is the position of the question remote
        List<Question> questions = new ArrayList<>();
        Question question = null;
        for (int code = 0; code < remotes.size(); code++) {
            question = createQuestion(String.valueOf(code + 1), remotes.get(code), questionsRaw);
            if (question != null) {
                questions.add(question);
            }
        }

        for (CatalogItem raw : questionsRaw) {
            question = GsonHelper.getGson().fromJson(raw.getValue(), Question.class);
            if (question.getType() == QuestionType.HEADER) {
                question.setQuestion(question.getTemplate());
                questions.add(question);
            }
        }

        return questions;
    }

    public static Question createQuestion(String code, QuestionRemote remote, List<CatalogItem> questionsRaw) {
        Question question;
        for (CatalogItem raw : questionsRaw) {
            if (raw.getCode().equals(code)) {
                question = GsonHelper.getGson().fromJson(raw.getValue(), Question.class);
                String questionText = question.getTemplate();
                if (remote.getParameters() != null) {
                    for (int i = 0; i < remote.getParameters().size(); i++) {
                        questionText = questionText.replace(("#" + i), remote.getParameters().get(i).getValue());
                    }
                }
                question.setQuestion(questionText);
                question.setValue(remote.getAnswer());
                return question;
            }
        }
        return null;
    }
}
