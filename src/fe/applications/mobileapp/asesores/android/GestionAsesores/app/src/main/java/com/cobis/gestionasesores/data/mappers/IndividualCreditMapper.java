package com.cobis.gestionasesores.data.mappers;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.Guarantor;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.ServerAction;
import com.cobis.gestionasesores.data.models.requests.IndividualApplicationData;
import com.cobis.gestionasesores.data.models.requests.IndividualCustomerData;
import com.cobis.gestionasesores.data.models.requests.IndividualRequest;
import com.cobis.gestionasesores.data.models.responses.ActionResponse;
import com.cobis.gestionasesores.data.models.responses.IndividualCreditResponseItem;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 7/5/2017.
 */

public class IndividualCreditMapper {
    static final String APP_INDIVIDUAL_SERVER = "INDIVIDUAL";

    public static IndividualCreditApp fromCustomer(Person person) {
        if (person.getType() != PersonType.CUSTOMER) {
            throw new RuntimeException("Cant create a IndividualCreditApp from a person that is not a customer.");
        }
        CustomerData customerData = (CustomerData) Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections()).getSectionData();
        GeneralPersonData personData = customerData.getGeneralPersonData();

        return new IndividualCreditApp.Builder()
                .setApplicantName(person.getName())
                .setApplicantId(person.getId())
                .setCustomerNumber(customerData.getCustomerNumber())
                .setCustomerServerId(person.getServerId())
                .setRfc(personData.getRfc())
                .setCycle(customerData.getNumCyclesOtherInstitutions())
                .build();
    }

    public static Guarantor createGuarantor(Person person) {
        String rfc;
        switch (person.getType()) {
            case PersonType.CUSTOMER:
                CustomerData customerData = (CustomerData) Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections()).getSectionData();
                GeneralPersonData personData = customerData.getGeneralPersonData();
                rfc = personData.getRfc();
                break;
            case PersonType.PROSPECT:
                ProspectData prospectData = (ProspectData) Person.getSection(SectionCode.PROSPECT_DATA, person.getSections()).getSectionData();
                rfc = prospectData.getRfc();
                break;
            default:
                throw new RuntimeException("Cant create a IndividualCreditApp from a person of this type: " + String.valueOf(person.getType()));
        }

        return new Guarantor.Builder()
                .setName(person.getName())
                .setDocument(rfc)
                .setServerId(person.getServerId())
                .build();
    }

    public static IndividualRequest fromCreditApp(IndividualCreditApp creditApp, boolean isConfirmation) {
        IndividualRequest info = new IndividualRequest();
        info.setCustomerData(getCustomerData(creditApp));
        info.setApplicationData(getApplicationData(creditApp));
        info.setConfirmation(isConfirmation);
        return info;


    }

    private static IndividualCustomerData getCustomerData(IndividualCreditApp creditApp) {
        return new IndividualCustomerData.Builder().
                setCode(creditApp.getCustomerServerId()).
                setRfc(creditApp.getRfc()).
                setPartner(creditApp.isPartner()).
                setAgreeRenew(creditApp.isRenovation()).
                setAvalCode(creditApp.getGuarantor().getServerId()).
                setAvalRfc(creditApp.getGuarantor().getDocument()).
                build();
    }

    private static IndividualApplicationData getApplicationData(IndividualCreditApp creditApp) {
        return new IndividualApplicationData.Builder().
                setApplicationType(APP_INDIVIDUAL_SERVER).
                setCreditDestination(creditApp.getDestination()).
                setRate(creditApp.getRate()).
                setTerm(creditApp.getTerm()).
                setFrecuency(creditApp.getFrequency()).
                setPromotion(creditApp.isPromotion()).
                setAmountOriginalRequest(creditApp.getAmount()).
                setAuthorizedAmount(creditApp.getAuthorizedAmount()).
                build();
    }


    //------------------- DOWNLOAD MAPPER ------------------------//
    public static List<IndividualCreditApp> fromRemoteListItem(List<IndividualCreditResponseItem> items) {
        List<IndividualCreditApp> result = new ArrayList<>();
        for (IndividualCreditResponseItem item : items) {
            result.add(fromRemoteItem(item));
        }
        return result;
    }

    private static IndividualCreditApp fromRemoteItem(IndividualCreditResponseItem item) {
        IndividualCustomerData customer = item.getEntity().getCreditIndividualApplication().getCustomerData();
        IndividualApplicationData app = item.getEntity().getCreditIndividualApplication().getApplicationData();
        IndividualCreditApp creditApp = new IndividualCreditApp.Builder()
                .setServerId(app.getProcessInstance())
                .setDestination(app.getCreditDestination())
                .setRate(app.getRate())
                .setTerm(app.getTerm())
                .setFrequency(app.getFrecuency())
                .setPromotion(app.isPromotion())
                .setAmount(app.getAmountOriginalRequest())
                .setAuthorizedAmount(app.getAuthorizedAmount())
                .setCreationDate(DateUtils.parseDateFromService(customer.getApplicationDate()))
                .setCycle(customer.getCycle())
                .setApplicantName(customer.getName())
                .setCustomerServerId(customer.getCode())
                .setRfc(customer.getRfc())
                .setRiskLevel(RiskLevelMapper.fromRemote(customer.getRiskLevel()))
                .setPartner(customer.isPartner())
                .setRenovation(customer.isAgreeRenew())
                .setGuarantor(new Guarantor.Builder()
                        .setServerId(customer.getAvalCode())
                        .setDocument(customer.getAvalRfc())
                        .setName(customer.getAvalName())
                        .setRiskLevel(RiskLevelMapper.fromRemote(customer.getAvalRiskLevel()))
                        .build())
                .build();

        ActionResponse actionResponse = item.getAction();
        if (actionResponse != null && (StringUtils.isNotEmpty(actionResponse.getActionType())
                || StringUtils.isNotEmpty(actionResponse.getDescription()))) {
            creditApp.setAction(new ServerAction(actionResponse.getActionType(), actionResponse.getDescription()));
        }
        return creditApp;
    }
}
