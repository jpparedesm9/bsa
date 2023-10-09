package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.impl;

import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.ApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationIndRequest;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CreditIndividualApplicationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CustomerSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationGroupSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DownloadParameter;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DownloadQuestion;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DownloadVerification;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DownloadVerificationIndividual;
import com.cobiscorp.ecobis.cobiscloudsynchronization.util.XmlConverter;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.xml.bind.JAXBException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by farid on 7/20/2017.
 */
public class XmlGenerator {

    public static void main(String[] args) throws JAXBException, ClassNotFoundException {

        //System.out.println(XmlConverter.dtoToXml(customerData));

/*
        CustomerSynchronizationData customerData = new CustomerSynchronizationData();
        String json = "{\"address\":{\"address\":{\"addressId\":2,\"addressInternalNumber\":4,\"addressNumber\":23123,\"cityCode\":18,\"countryCode\":484,\"neighborhoodCode\":3871,\"ownershipType\":\"test\",\"postalCode\":\"23423\",\"stateCode\":3,\"street\":\"Calle del Establo\",\"yearsAtAddress\":0},\"addressId\":2,\"cellphone\":{\"areaCode\":\"234\",\"number\":\"09345345345\",\"phoneId\":1},\"emailAddress\":{\"addressId\":3,\"email\":\"newaddress@asdfasdfasdf.com\"},\"geoReference\":{\"geoReferenceId\":5,\"latitude\":5421454,\"longitude\":54782},\"phone\":{\"areaCode\":\"234\",\"number\":\"223423423432\",\"phoneId\":2}},\"business\":{\"business\":{\"address\":{\"addressId\":0,\"addressInternalNumber\":0,\"addressNumber\":3,\"cityCode\":19,\"countryCode\":484,\"neighborhoodCode\":3929,\"ownershipType\":\"2\",\"postalCode\":\"343\",\"stateCode\":3,\"street\":\"Calle A\",\"townCode\":\"0\",\"yearsAtAddress\":4},\"businessId\":0,\"creditPurpose\":\"CT\",\"industry\":\"1001\",\"monthlyRevenue\":400000,\"name\":\"Negocio 2\",\"openDate\":\"2017-07-20T01:48:42.018Z\",\"phone\":\"2341234\",\"transfer\":\"A\",\"withWhatResourceWillPayForCredit\":\"ED\",\"yearsInBusiness\":4},\"geoReference\":{\"geoReferenceId\":5,\"latitude\":5421454,\"longitude\":54782}},\"customer\":{\"customer\":{\"birthDate\":\"2017-01-19T00:07:00-05:00\",\"cityBirth\":13,\"countryOfBirth\":13,\"customerId\":1693,\"documentNumber\":\"VA8dsjg7l9\",\"documentType\":\"CURP\",\"education\":\"002\",\"firstName\":\"hwrKokU4n7FJ\",\"gender\":\"M\",\"hasOtherIncome\":false,\"maritalStatus\":\"SO\",\"nationality\":484,\"numberOfCycles\":1,\"numberOfDependents\":4,\"otherIncome\":0,\"otherIncomeSource\":\"jasuel\",\"pepRelationship\":\"kasko\",\"personPep\":false,\"profession\":\"001\",\"rfc\":\"LOAO170719EC8\",\"secondName\":\"Augusto\",\"secondSurname\":\"Changed\",\"surname\":\"Loachamin\"}},\"paymentCapacity\":{\"paymentCapacity\":{\"monthlyBusinessExpenses\":2222.22,\"monthlyFamilyExpense\":3333.33,\"monthlyIncome\":1111.11}},\"references\":[{\"reference\":{\"emailAddress\":\"cesar@cobiscorp.com\",\"firstName\":\"Cesar\",\"surname\":\"Loachamin\",\"phone\":\"2324234234234\",\"referenceId\":1,\"timeOfRelationship\":1}},{\"reference\":{\"emailAddress\":\"cesar@cobiscorp.com\",\"firstName\":\"Cesar\",\"surname\":\"Loachamin\",\"phone\":\"2324234234234\",\"referenceId\":1,\"timeOfRelationship\":1}}],\"spouse\":{\"additional\":{\"countryOfBirth\":12,\"education\":\"001\",\"nationality\":23,\"profession\":\"32\",\"spouseId\":0},\"spouse\":{\"birthDate\":\"2017-07-27T15:21:22.332Z\",\"cityBirth\":29,\"firstName\":\"Maria\",\"gender\":\"F\",\"rfc\":\"2341324214123\",\"secondName\":\"Belen\",\"secondSurname\":\"Enriquez\",\"spouseId\":0,\"surname\":\"Cepeda\"}},\"spouseAddressData\":{\"address\":{\"addressId\":0,\"addressInternalNumber\":0,\"addressNumber\":234,\"cityCode\":29,\"countryCode\":9,\"neighborhoodCode\":34,\"ownershipType\":\"lasoep\",\"postalCode\":\"23412\",\"stateCode\":3,\"street\":\"asdfasdf\",\"yearsAtAddress\":0},\"addressId\":0,\"cellphone\":{\"areaCode\":\"593\",\"number\":\"0234234234\",\"phoneId\":0},\"workphone\":{\"areaCode\":\"593\",\"number\":\"0234234234\",\"phoneId\":0}}}";


        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(json, JsonObject.class);
        customerData = gson.fromJson(json, CustomerSynchronizationData.class);
        System.out.println(XmlConverter.dtoToXml(customerData));
        System.out.println(jsonObject);
*/

        /*
        SolidarityPaymentSynchronizationData solidarityPaymentSynchronizationData = new SolidarityPaymentSynchronizationData();
        SolidarityPaymentData solidarityPaymentData = new SolidarityPaymentData();
        solidarityPaymentData.setAmountChargeWholePayment(new BigDecimal(0));
        solidarityPaymentData.setApplicationDate("2017-07-21T18:26:00Z");
        solidarityPaymentData.setBranchOffice("La oficina de Manu");
        solidarityPaymentData.setCreditType("prueba");
        solidarityPaymentData.setDebitsSavingAccounts(true);
        solidarityPaymentData.setGroupAmount(new BigDecimal(0));
        solidarityPaymentData.setGroupCycle(5);
        solidarityPaymentData.setGroupName("Los amigos");
        solidarityPaymentData.setGroupId(1);
        solidarityPaymentData.setLatePayments(8);
        solidarityPaymentData.setLiquidCollateralBalance(new BigDecimal(0));
        solidarityPaymentData.setNextDueDate("2017-07-21T18:26:00Z");
        solidarityPaymentData.setRate("25");
        solidarityPaymentData.setResponsableOfficer("Manuel");
        solidarityPaymentData.setTerm("16 semanas");

        SolidarityPaymentCustomerData solidarityPaymentClientData = new SolidarityPaymentCustomerData();
        solidarityPaymentClientData.setAmountPayWholePayment(new BigDecimal(0));
        solidarityPaymentClientData.setCustomerName("Manuel");
        solidarityPaymentClientData.setCustomerId(5);
        List<SolidarityPaymentCustomerData> solidarityPaymentClientDataList = new ArrayList<SolidarityPaymentCustomerData>();
        solidarityPaymentClientDataList.add(solidarityPaymentClientData);
        solidarityPaymentClientDataList.add(solidarityPaymentClientData);
        solidarityPaymentSynchronizationData.setSolidarityPaymentCustomerData(solidarityPaymentClientDataList);
        solidarityPaymentSynchronizationData.setSolidarityPaymentData(solidarityPaymentData);
        */

        /*
        GroupSynchronizationData groupSynchronizationData = new GroupSynchronizationData();
        GroupData groupData = new GroupData();
        Group group = new Group();
        group.setBankCode("1");
        group.setCycle(4);
        group.setGroupId(1);
        group.setMeetingDay("Lunes");
        group.setMeetingHour("2017-07-21T18:26:00Z");
        group.setName("El grupo");
        group.setOffice(5);
        group.setOfficer(10);

        Member member = new Member();
        member.setAmountOfVoluntarySavings(new BigDecimal(10));
        member.setBankCode("1");
        member.setCustomerId(10);
        member.setCycle(1);
        member.setMeetingPlace("D");
        member.setName("Farid");
        member.setPosition("Presidente");
        member.setRelatedPersonRFC("56412145");
        member.setRfc("3232656");
        member.setRiskLevel("Rojo");
        member.setTypeOfRelationship("Madre");

        groupData.setGroup(group);
        List<Member> members = new ArrayList<Member>();
        members.add(member);
        members.add(member);
        Member[] memberList = new Member[members.size()];
        memberList = members.toArray(memberList);
        groupData.setMembers(memberList);
        groupSynchronizationData.setGroup(groupData);

        */

        /*
        CreditGroupApplicationSynchronizationData creditGroupApplicationSynchronizationData = new CreditGroupApplicationSynchronizationData();
        CreditApplicationRequest creditApplicationRequest = new CreditApplicationRequest();
        creditApplicationRequest.setApplicationDate("2017-07-21T18:26:00Z");
        creditApplicationRequest.setApplicationType("GRUPAL");
        creditApplicationRequest.setGroupAgreeRenew(true);
        creditApplicationRequest.setGroupAmount(8000);
        creditApplicationRequest.setGroupCycle(1);
        creditApplicationRequest.setGroupName("TEST");
        creditApplicationRequest.setGroupNumber(218);
        creditApplicationRequest.setOffice(1);
        creditApplicationRequest.setOfficer(1);
        creditApplicationRequest.setProcessInstance(0);
        creditApplicationRequest.setPromotion(true);
        creditApplicationRequest.setRate("12");
        creditApplicationRequest.setTerm("60");
        creditApplicationRequest.setReasonNotAccepting("Razon");

        List<MemberRequest> memberRequestList = new ArrayList<MemberRequest>();
        MemberRequest memberRequest = new MemberRequest();
        memberRequest.setAmountRequestedOriginal(2000);
        memberRequest.setAuthorizedAmount(2000);
        memberRequest.setCode(972);
        memberRequest.setCycleNumber(0);
        memberRequest.setLiquidGuarantee(2000);
        memberRequest.setName("TEST");
        memberRequest.setParticipant(true);
        memberRequest.setProposedMaximumAmount(10000);
        memberRequest.setRiskLevel("VERDE");
        memberRequest.setRole("G");
        memberRequest.setVoluntarySavings(20);

        memberRequestList.add(memberRequest);
        memberRequestList.add(memberRequest);

        creditApplicationRequest.setMembers(memberRequestList);
        creditGroupApplicationSynchronizationData.setCreditGroupApplication(creditApplicationRequest);
        */
        /*
        CreditIndividualApplicationSynchronizationData creditIndividualApplicationSynchronizationData = new CreditIndividualApplicationSynchronizationData();
        CreditApplicationIndRequest creditApplicationIndRequest = new CreditApplicationIndRequest();


        CustomerData customerData1 = new CustomerData();
        customerData1.setAgreeRenew(true);
        customerData1.setApplicationDate("2017-07-21T18:26:00Z");
        customerData1.setAvalCode(10);
        customerData1.setAvalName("Nombre");
        customerData1.setAvalRfc("54657");
        customerData1.setAvalRiskLevel("Rojo");
        customerData1.setName("Juan");
        customerData1.setCode(1);
        customerData1.setCycle(10);
        customerData1.setLastAmountApplication(100);
        customerData1.setOffice(1);
        customerData1.setOfficer(10);
        customerData1.setPartner(true);
        customerData1.setRfc("45121024");
        customerData1.setRiskLevel("Rojo");


        ApplicationData applicationData = new ApplicationData();
        applicationData.setAmountOriginalRequest(1000);
        applicationData.setApplicationType("Individual");
        applicationData.setTerm("100");
        applicationData.setRate("6");
        applicationData.setFrecuency("SEMANAL");
        applicationData.setPromotion(true);
        applicationData.setAmountOriginalRequest(55000);
        applicationData.setCreditDestination("ACTIVO FIJO");
        applicationData.setAuthorizedAmount(465784);

        creditApplicationIndRequest.setApplicationData(applicationData);
        creditApplicationIndRequest.setCustomerData(customerData1);

        creditIndividualApplicationSynchronizationData.setCreditIndividualApplication(creditApplicationIndRequest);

        */

        /*
        AgendaSynchronizationData agendaSynchronizationData = new AgendaSynchronizationData();
        AgendaData agendaData = new AgendaData();
        Agenda agendaGrupo = new Agenda();
        agendaGrupo.setAgendaId(2);
        agendaGrupo.setAddress("Av cocacola, diagonal a el mercado");
        agendaGrupo.setAssignedUser("admuser");
        agendaGrupo.setCategory("GRUPAL");
        agendaGrupo.setComments("OK");
        agendaGrupo.setConclusion("Texto abierto");
        agendaGrupo.setControlDate("2017-07-21T18:26:00Z");
        agendaGrupo.setExecutionDate("2017-07-21T18:26:00Z");
        agendaGrupo.setFinishTime("16:00");
        agendaGrupo.setEntityId(25);
        agendaGrupo.setOfficer("ASESORX");
        agendaGrupo.setEstablishedDate("2017-07-21T18:26:00Z");
        agendaGrupo.setStartTime("14:30");
        agendaGrupo.setStatus("PENDIENTE");
        agendaGrupo.setType("COBRANZA");
        agendaGrupo.setControlId(2);

        Agenda agendaGrupo2 = new Agenda();
        agendaGrupo2.setAddress("Av pepsi, diagonal a la casa de test");
        agendaGrupo2.setAssignedUser("admuser");
        agendaGrupo2.setCategory("INDIVIDUAL");
        agendaGrupo2.setEntityId(17);
        agendaGrupo2.setComments("OK");
        agendaGrupo2.setConclusion("Texto abierto");
        agendaGrupo2.setControlDate("2017-07-21T18:26:00Z");
        agendaGrupo2.setExecutionDate("2017-07-21T18:26:00Z");
        agendaGrupo2.setFinishTime("14:00");
        agendaGrupo2.setOfficer("ASESORX");
        agendaGrupo2.setEstablishedDate("2017-07-21T18:26:00Z");
        agendaGrupo2.setStartTime("12:30");
        agendaGrupo2.setStatus("PENDIENTE");
        agendaGrupo2.setType("COBRANZA");
        agendaGrupo2.setControlId(1);

        GeoReference geoReference = new GeoReference();
        geoReference.setLatitude(412563214);
        geoReference.setLongitude(254547811);

        GeoReference geoReference2 = new GeoReference();
        geoReference2.setLatitude(412512333);
        geoReference2.setLongitude(457888541);


        agendaData.setAgenda(agendaGrupo);
        agendaData.setGeoReference(geoReference);


        agendaSynchronizationData.setAgendaData(agendaData);

        */

        //printXML(generateVerificationSynchronizationDataForGroup());
        //  printXML(generateVerificationSynchronizationDataForIndividual());
        //printJSON(generateVerificationSynchronizationDataForIndividual());

        //printXML(generateVerificationSynchronizationDataForGroup());
    }

    public static void printXML(Object object) {
        try {
            System.out.println(XmlConverter.dtoToXml(object));
        } catch (JAXBException e) {
            e.printStackTrace();
        }

    }

    public static void printJSON(Object object) {
        Gson gson = new Gson();
        String json = gson.toJson(object);
        System.out.println(json);
    }

    public static VerificationGroupSynchronizationData generateVerificationSynchronizationDataForGroup() {
        VerificationGroupSynchronizationData verificationGroupSynchronizationData = new VerificationGroupSynchronizationData();
        verificationGroupSynchronizationData.setGroupId(508);
        verificationGroupSynchronizationData.setName("Grupo 508");
        verificationGroupSynchronizationData.setProcessInstance(4104);
        verificationGroupSynchronizationData.setVerification(generateListVerification());
        return verificationGroupSynchronizationData;
    }

    public static VerificationSynchronizationData generateVerificationSynchronizationDataForIndividual() {
        VerificationSynchronizationData verificationSynchronizationData = new VerificationSynchronizationData();
        verificationSynchronizationData.setProcessInstance(4102);
        verificationSynchronizationData.setVerification(generateIndividualVerificationData());
        return verificationSynchronizationData;
    }


    public static List<DownloadVerificationIndividual> generateIndividualVerificationData() {


        List<DownloadVerificationIndividual> verifications = new ArrayList<DownloadVerificationIndividual>();
        DownloadVerificationIndividual verification;

        for (int i = 0; i <= 1; i++) {
            verification = new DownloadVerificationIndividual();
            verification.setApplicationId(1245785);
            verification.setCustomerId(457);
            verification.setCustomerName("Manuel Freire");
            verification.setResult(8.5);
            verification.setGroup(false);
            verification.setDate("2017/01/01");
            verification.setQuestions(generateIndividualQuestionVerificationData());

            verification.setAval(true);

            verifications.add(verification);
        }


        return verifications;


    }

    public static List<DownloadVerification> generateListVerification() {

        List<DownloadVerification> verifications = new ArrayList<DownloadVerification>();
        DownloadVerification verification;
        for (int i = 0; i <= 5; i++) {
            verification = new DownloadVerification();
            verification.setGroup(true);
            verification.setApplicationId(1245785);
            verification.setDate("2017/01/01");
            verification.setCustomerId(457);
            verification.setCustomerName("Manuel Freire");
            verification.setResult(8.5);
            verification.setQuestions(generateGroupQuestionVerificationData());
            verifications.add(verification);
        }

        return verifications;

    }

    public static void addGeoreferencesToIndividualQuestions(List<DownloadQuestion> questions) {
        GeoReference geoReference = new GeoReference();
        geoReference.setLongitude(0.255455);
        geoReference.setLatitude(0.6854532);

    }

    public static void addGeoreferencesToGroupQuestions(List<DownloadQuestion> questions) {
        GeoReference geoReference = new GeoReference();

    }


    public static DownloadQuestion generateQuestion(String selectedOption, String[] parameters) {
        DownloadQuestion question = new DownloadQuestion();
        question.setAnswer(selectedOption);
        List<DownloadParameter> parameterList = new ArrayList<DownloadParameter>();
        DownloadParameter parameterTemp;
        for (String parameter : parameters) {
            parameterTemp = new DownloadParameter();
            parameterTemp.setValue(parameter);
            parameterList.add(parameterTemp);
        }
        question.setParameters(parameterList);
        return question;
    }

    public static DownloadQuestion generateQuestionWithGeoReference(Integer id, String selectecOption, DownloadParameter[] parameters) {
        DownloadQuestion question = new DownloadQuestion();
        question.setAnswer(selectecOption);
        List<DownloadParameter> parameterList = new ArrayList<DownloadParameter>();
        parameterList.addAll(Arrays.asList(parameters));
        question.setParameters(parameterList);
        return question;
    }


    public static List<DownloadQuestion> generateIndividualQuestionVerificationData() {
        List<DownloadQuestion> questions = new ArrayList<DownloadQuestion>();
        questions.add(generateQuestion("S", new String[]{"25000"}));
        questions.add(generateQuestion("S", new String[]{"5000"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Ruta 45 y Calle 12"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Ruta 45 y Calle 12", "3 meses"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Pescador"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Los pescados de Carlos"}));
        questions.add(generateQuestion("N", new String[]{"Carlos Hernandez de Jiron"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Los pescados de Carlos", "5 años"}));
        questions.add(generateQuestion("S", new String[]{"Privado"}));
        questions.add(generateQuestion("S", new String[]{}));
        questions.add(generateQuestion("D", new String[]{}));
        questions.add(generateQuestion("F", new String[]{}));
        questions.add(generateQuestion("O", new String[]{}));
        questions.add(generateQuestion("P", new String[]{}));
        //addGeoreferencesToIndividualQuestions(questions);
        return questions;
    }

    public static List<DownloadQuestion> generateGroupQuestionVerificationData() {
        List<DownloadQuestion> questions = new ArrayList<DownloadQuestion>();
        questions.add(generateQuestion("S", new String[]{"25000"}));
        questions.add(generateQuestion("S", new String[]{"5000"}));
        questions.add(generateQuestion("S", new String[]{"El grupo"}));
        questions.add(generateQuestion("S", new String[]{}));
        questions.add(generateQuestion("N", new String[]{"Fernanda Alvarez Garzon"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Ruta 45 y Calle 12"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Ruta 45 y Calle 12", "3 meses"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Pescador"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Los pescados de Carlos"}));
        questions.add(generateQuestion("N", new String[]{"Carlos Hernandez de Jiron"}));
        questions.add(generateQuestion("S", new String[]{"Carlos Hernandez de Jiron", "Los pescados de Carlos", "5 años"}));
        questions.add(generateQuestion("S", new String[]{"Privado"}));
        questions.add(generateQuestion("S", new String[]{}));
        questions.add(generateQuestion("D", new String[]{}));
        questions.add(generateQuestion("F", new String[]{}));
        questions.add(generateQuestion("O", new String[]{}));
        questions.add(generateQuestion("P", new String[]{}));

        return questions;
    }

    public static CreditIndividualApplicationSynchronizationData generateCreditIndApplication() {

        CreditIndividualApplicationSynchronizationData creditIndividualApplicationSynchronizationData =
                new CreditIndividualApplicationSynchronizationData();

        CreditApplicationIndRequest creditApplicationIndRequest = new CreditApplicationIndRequest();
        creditIndividualApplicationSynchronizationData.setCreditIndividualApplication(creditApplicationIndRequest);
        creditApplicationIndRequest.setApplicationData(getApplicationData());
        creditApplicationIndRequest.setCustomerData(getCustomerData());

        return creditIndividualApplicationSynchronizationData;
    }


    public static ApplicationData getApplicationData() {

        ApplicationData applicationData = new ApplicationData();
        applicationData.setAmountOriginalRequest(2000);
        applicationData.setProcessInstance(2765);
        applicationData.setApplicationType("INDIVIDUAL");
        applicationData.setCreditDestination("Consumo");
        applicationData.setAuthorizedAmount(2000);
        applicationData.setFrecuency("MENSUAL");
        applicationData.setPromotion(false);
        applicationData.setRate("3");
        applicationData.setTerm("12");
        applicationData.setProcessInstance(2521);
        return applicationData;
    }

    public static CustomerData getCustomerData() {

        CustomerData customerData = new CustomerData();
        customerData.setCode(1);
        customerData.setName("TEST TEST");
        customerData.setCycle(0);
        customerData.setLastAmountApplication(2000);
        customerData.setOffice(1);
        customerData.setOfficer(1);
        customerData.setPartner(false);
        customerData.setAgreeRenew(true);
        customerData.setApplicationDate("01/01/2017");
        customerData.setAvalCode(1);
        customerData.setAvalName("TEST TEST");
        customerData.setAvalRfc("515335");
        customerData.setAvalRiskLevel("VERDE");


        return customerData;
    }

}
