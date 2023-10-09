package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.RiskLevel;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ReferencesData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.SectionData;
import com.cobis.gestionasesores.data.models.requests.CustomerDataRequest;
import com.cobis.gestionasesores.data.models.requests.PersonalInformationCustomer;
import com.cobis.gestionasesores.data.models.responses.CustomerDataResponse;
import com.cobis.gestionasesores.data.models.responses.CustomerEntity;
import com.cobis.gestionasesores.data.models.responses.CustomerResponseItem;
import com.cobis.gestionasesores.utils.DateUtils;

public class CustomerMapper {

    public static final String DOCUMENT_TYPE = "CURP";

    public static CustomerDataRequest customerToCustomerRequest(@NonNull Person person, boolean isSync) {
        Section section = Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections());
        CustomerData customerData = (CustomerData) section.getSectionData();

        GeneralPersonData generalPersonData = customerData.getGeneralPersonData();

        PersonalInformationCustomer personalInformation = new PersonalInformationCustomer();
        personalInformation.setCustomerId(person.getServerId());
        personalInformation.setFirstName(generalPersonData.getFirstName());
        personalInformation.setSecondName(generalPersonData.getSecondName());
        personalInformation.setSurname(generalPersonData.getLastName());
        personalInformation.setSecondSurname(generalPersonData.getSecondLastName());
        personalInformation.setBirthDate(DateUtils.formatDateForService(generalPersonData.getBirthDate()));
        personalInformation.setGender(generalPersonData.getSex());
        personalInformation.setMaritalStatus(customerData.getCivilStatus());
        personalInformation.setDocumentNumber(customerData.getCurp());
        personalInformation.setDocumentType(DOCUMENT_TYPE);
        personalInformation.setCityBirth(ConvertUtils.tryToInt(generalPersonData.getBirthEntityCode(), 0));
        personalInformation.setCountryOfBirth(ConvertUtils.tryToInt(generalPersonData.getBirthCountry(), 0));
        personalInformation.setNationality(ConvertUtils.tryToInt(generalPersonData.getNationality(), 0));
        personalInformation.setEducation(generalPersonData.getEducationLevel());
        personalInformation.setProfession(generalPersonData.getOccupation());
        personalInformation.setNumberOfDependents(ConvertUtils.tryToInt(customerData.getEconomicDependents(), 0));
        personalInformation.setRfc(generalPersonData.getRfc());
        personalInformation.setHasOtherIncome(customerData.hasOtherIncomeSources());
        personalInformation.setOtherIncomeSource(customerData.getOtherIncomeSources());
        personalInformation.setOtherIncome(customerData.getOtherIncomeSourcesAmount());
        personalInformation.setNumberOfCycles(customerData.getNumCyclesOtherInstitutions());
        personalInformation.setPersonPep(customerData.hasRelationshipPoliticallyExposed());
        personalInformation.setPepRelationship(customerData.getRelationship());

        CustomerDataRequest customerDataRequest = new CustomerDataRequest();
        customerDataRequest.setCustomer(personalInformation);
        customerDataRequest.setOnline(!isSync);

        return customerDataRequest;
    }

    public static CustomerData responseToCustomerData(CustomerDataResponse response) {
        PersonalInformationCustomer customer = response.getCustomer();
        int countryOfBirth = customer.getCountryOfBirth();
        GeneralPersonData generalPersonData = new GeneralPersonData.Builder()
                .setFirstName(customer.getFirstName())
                .setSecondName(customer.getSecondName())
                .setLastName(customer.getSurname())
                .setSecondLastName(customer.getSecondSurname())
                .setSex(customer.getGender())
                .setBirthDate(DateUtils.parseDateFromService(customer.getBirthDate()))
                .setBirthCountry(countryOfBirth <= 0 ? null : String.valueOf(customer.getCountryOfBirth()))
                .setBirthEntityCode(String.valueOf(customer.getCityBirth()))
                .setNationality(String.valueOf(customer.getNationality()))
                .setEducationLevel(customer.getEducation())
                .setOccupation(customer.getProfession())
                .setRfc(customer.getRfc())
                .build();

        return new CustomerData.Builder().addGeneralPersonData(generalPersonData)
                .addCustomerNumber(customer.getBankCode())
                .addCustomerAccountNumber(customer.getBankAccount())
                .addCivilStatus(customer.getMaritalStatus())
                .addEconomicDependents(String.valueOf(customer.getNumberOfDependents()))
                .addCurp(customer.getDocumentNumber())
//                .addTechnicalDegree()
                .addHasOtherIncomeSources(customer.hasOtherIncome())
                .addOtherIncomeSources(customer.getOtherIncomeSource())
                .addOtherIncomeSourcesAmount(customer.getOtherIncome())
                .addNumCyclesOtherInstitutions(customer.getNumberOfCycles())
//                .addIsPoliticallyExposed() // TODO: 7/27/2017 These fields are not available
//                .addFunctionPerformed()
                .addHasRelationshipPoliticallyExposed(customer.isPersonPep())
                .addRelationship(customer.getPepRelationship())
                .build();
    }

    public static Person parseRemoteCustomer(CustomerResponseItem item, Person localPerson) {
        CustomerEntity entity = item.getEntity();
        Person person = null;
        if (entity != null && entity.getCustomer() != null && entity.getCustomer().getCustomer() != null) {
            int type = determinePersonType(item.getEntity());
            if (type != PersonType.UNKNOWN) {
                if (localPerson != null) {
                    if (localPerson.getType() != type) {
                        localPerson.setSections(null);
                        localPerson.setType(type);
                    }
                }
                person = new Person.Builder()
                        .setType(type)
                        .setServerId(entity.getCustomer().getCustomer().getCustomerId())
                        .build(localPerson);
                person = customerToPerson(entity, person);
                String riskLevel = entity.getCustomer().getCustomer().getRiskBureau();
                person.setRiskLevel(RiskLevelMapper.fromRemote(riskLevel));
                person.setValidated(RiskLevel.LOW.equals(riskLevel) || type == PersonType.CUSTOMER);
            }
        }
        return person;
    }

    public static Person customerToPerson(CustomerEntity entity, Person person) {
        SectionData sectionData;
        for (Section section : person.getSections()) {
            sectionData = null;
            switch (section.getCode()) {
                case SectionCode.CUSTOMER_ADDRESS:
                    sectionData = CustomerAddressMapper.responseToCustomerAddress(entity.getAddress());
                    break;
                case SectionCode.CUSTOMER_BUSINESS:
                    sectionData = CustomerWorkMapper.responseToCustomerBusiness(entity.getBusiness());
                    break;
                case SectionCode.CUSTOMER_DATA:
                    sectionData = responseToCustomerData(entity.getCustomer());
                    break;
                case SectionCode.PROSPECT_DATA:
                    sectionData = ProspectDataMapper.responseToProspectData(entity);
                    break;
                case SectionCode.CUSTOMER_PAYMENTS:
                    sectionData = PaymentCapacityMapper.responseToCustomerPayment(entity.getPaymentCapacity());
                    break;
                case SectionCode.CUSTOMER_REFERENCES:
                    if (entity.getReferences() != null) {
                        ReferencesData referencesData = new ReferencesData();
                        referencesData.setReferences(ReferenceMapper.toReferencesInfo(entity.getReferences()));
                        sectionData = referencesData;
                    }
                    break;
                case SectionCode.PARTNER_DATA:
                    if (entity.getSpouse() != null) {
                        sectionData = PartnerDataMapper.responseToPartnerData(entity.getSpouse());
                    }
                    break;
                case SectionCode.PARTNER_WORK:
                    if (entity.getSpouseAddressData() != null) {
                        sectionData = PartnerWorkMapper.responseToPartnerWork(entity.getSpouseAddressData());
                    }
                    break;
                case SectionCode.CUSTOMER_DOCUMENTS:
                    if (entity.getDocuments() != null && entity.getDocuments().getDocument() != null) {
                        sectionData = DocumentsDataMapper.toDocumentsData(entity);
                    }
                    break;
                case SectionCode.COMPLEMENTARY_DATA:
                        sectionData = ComplementaryDataMapper.responseToComplementaryData(entity.getComplementaryRequest());
                    break;
                default:
                    sectionData = null;
            }
            if (sectionData != null) {
                section.setSectionData(sectionData);
                section.setStatus(sectionData.isComplete() ? SyncStatus.SYNCED : SyncStatus.DRAFT);
            }
            person.replaceSection(section);
        }
        return person;
    }

    @PersonType
    private static int determinePersonType(CustomerEntity entity) {
        int type = PersonType.UNKNOWN;
        if (entity != null && entity.getCustomer() != null) {
            PersonalInformationCustomer customer = entity.getCustomer().getCustomer();
            String bankCode = customer.getBankCode();
            String bankAccount = customer.getBankAccount();
            type = StringUtils.isNotEmpty(bankAccount) && StringUtils.isNotEmpty(bankCode) ? PersonType.CUSTOMER : PersonType.PROSPECT;
        }
        return type;
    }
}
