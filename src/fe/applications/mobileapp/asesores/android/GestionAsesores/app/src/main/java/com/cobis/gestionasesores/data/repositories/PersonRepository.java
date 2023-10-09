package com.cobis.gestionasesores.data.repositories;

import android.annotation.SuppressLint;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.CommonUtils;
import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.CivilStatus;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.mappers.ComplementaryDataMapper;
import com.cobis.gestionasesores.data.mappers.CustomerAddressMapper;
import com.cobis.gestionasesores.data.mappers.CustomerMapper;
import com.cobis.gestionasesores.data.mappers.CustomerWorkMapper;
import com.cobis.gestionasesores.data.mappers.PartnerDataMapper;
import com.cobis.gestionasesores.data.mappers.PartnerWorkMapper;
import com.cobis.gestionasesores.data.mappers.PaymentCapacityMapper;
import com.cobis.gestionasesores.data.mappers.ProspectMapper;
import com.cobis.gestionasesores.data.mappers.ReferenceMapper;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.ComplementaryData;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.data.models.CustomerBusiness;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.CustomerPayment;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.PartnerWork;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.ReferencesData;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.SectionData;
import com.cobis.gestionasesores.data.models.requests.ComplementaryDataRemote;
import com.cobis.gestionasesores.data.models.requests.CustomerAddressRequest;
import com.cobis.gestionasesores.data.models.requests.CustomerBusinessRemote;
import com.cobis.gestionasesores.data.models.requests.CustomerReferencesRemote;
import com.cobis.gestionasesores.data.models.requests.GetPersonsRequest;
import com.cobis.gestionasesores.data.models.requests.PartnerDataRemote;
import com.cobis.gestionasesores.data.models.requests.PartnerWorkRemote;
import com.cobis.gestionasesores.data.models.requests.ValidatePersonRequest;
import com.cobis.gestionasesores.data.models.responses.CustomerDataResponse;
import com.cobis.gestionasesores.data.models.responses.CustomerWorkResponse;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.data.models.responses.Message;
import com.cobis.gestionasesores.data.models.responses.PartnerDataResponse;
import com.cobis.gestionasesores.data.models.responses.PartnerWorkResponse;
import com.cobis.gestionasesores.data.models.responses.PaymentCapacityResponse;
import com.cobis.gestionasesores.data.models.responses.ProspectResponse;
import com.cobis.gestionasesores.data.models.responses.ReferenceResponse;
import com.cobis.gestionasesores.data.models.responses.SaveCustomerAddressResponse;
import com.cobis.gestionasesores.data.models.responses.SaveCustomerDataResponse;
import com.cobis.gestionasesores.data.models.responses.SaveProspectResponse;
import com.cobis.gestionasesores.data.models.responses.ServiceResponse;
import com.cobis.gestionasesores.data.models.responses.ValidateResponse;
import com.cobis.gestionasesores.data.source.PersonDataSource;
import com.cobis.gestionasesores.data.source.local.PersistencePerson;
import com.cobis.gestionasesores.data.source.remote.DocumentService;
import com.cobis.gestionasesores.data.source.remote.PersonService;
import com.cobis.gestionasesores.data.source.remote.ValidateService;
import com.cobis.gestionasesores.domain.businesslogic.PersonValidator;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.annotations.Nullable;

/**
 * Person repository access
 * Created by mnaunay on 28/06/2017.
 */

public class PersonRepository implements PersonDataSource {
    private static PersonRepository sInstance;

    private PersonRepository() {
    }

    public static PersonRepository getInstance() {
        if (sInstance == null) {
            sInstance = new PersonRepository();
        }
        return sInstance;
    }

    @Override
    public Observable<Boolean> delete(final int id) {
        return Observable.fromCallable(new Callable<Boolean>() {
            @Override
            public Boolean call() throws Exception {
                boolean result = false;
                PersistencePerson persistence = null;
                try {
                    persistence = new PersistencePerson();
                    result = persistence.deletePerson(id);
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });
    }

    @Override
    public List<Person> getAllForSync(int type, int[] status) {
        List<Person> result = getAll(new GetPersonsRequest.Builder().setType(type).setStatus(status).build());
        List<Person> tmp = new ArrayList<>();
        for (Person person : result) {
            if (person.getStatus() == SyncStatus.DRAFT) {
                for (Section section : person.getSections()) {
                    if (section.getStatus() == SyncStatus.PENDING) {
                        tmp.add(person);
                        break;
                    }
                }
            } else {
                tmp.add(person);
            }
        }
        return tmp;
    }

    @Override
    public List<Person> getAll(GetPersonsRequest request) {
        PersistencePerson persistence = null;
        List<Person> result;
        try {
            persistence = new PersistencePerson();
            result = persistence.getAll(request.getKeyword(), request.getType(), request.getStatus(), request.getCreditType(), request.getValidated(), request.getInGroup(), request.getHasPartner());
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public Person getPerson(int id) {
        PersistencePerson persistence = null;
        Person result = null;
        try {
            persistence = new PersistencePerson();
            result = persistence.get(id);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public Person getPersonByServerId(int serverId) {
        PersistencePerson persistence = null;
        Person result = null;
        try {
            persistence = new PersistencePerson();
            result = persistence.getByServerId(serverId);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public SectionData getSectionData(int personId, @SectionCode String sectionCode, boolean tryOnline) throws Exception {
        Person person = getPerson(personId);
        Section section = Person.getSection(sectionCode, person.getSections());

        //only for partner Work check person validation
        if (SectionCode.PARTNER_DATA.equals(section.getCode()) && person.getSpouseId() > 0) {
            PartnerData spouseData = getSpouseData(person.getSpouseId());
            if (spouseData != null) {
                PartnerData originalData = (PartnerData) section.getSectionData();
                if (originalData != null) {
                    section.setSectionData(originalData.merge(spouseData));
                } else {
                    section.setStatus(SyncStatus.DRAFT);
                    section.setSectionData(spouseData);
                }
            }
        }
        if (NetworkUtils.isOnline() && person.getServerId() > 0 && tryOnline) {
            PersonService service = new PersonService();
            SectionData remoteData = null;
            switch (sectionCode) {
                case SectionCode.PROSPECT_DATA:
                    ProspectResponse prospectResponse = service.getProspectData(person.getServerId());
                    if (prospectResponse != null) {
                        ProspectData prospectData = (ProspectData) section.getSectionData();
                        if (prospectData != null) {
                            remoteData = prospectData.merge(ProspectMapper.responseToProspectData(prospectResponse));
                        } else {
                            remoteData = ProspectMapper.responseToProspectData(prospectResponse);
                        }
                    }
                    break;
                case SectionCode.CUSTOMER_DATA:
                    CustomerDataResponse response = service.getCustomerData(person.getServerId());
                    if (response != null) {
                        remoteData = CustomerMapper.responseToCustomerData(response);
                    }
                    break;
                case SectionCode.CUSTOMER_ADDRESS:
                    CustomerAddress sectionData = (CustomerAddress) section.getSectionData();
                    if (sectionData != null && sectionData.getAddressData() != null) {
                        CustomerAddressRequest responseAddress = service.getCustomerAddress(person.getServerId(), sectionData.getAddressData().getServerId(), sectionData.getEmailServerId(), sectionData.getPhoneServerId(), sectionData.getCellphoneServerId());
                        if (responseAddress != null) {
                            remoteData = CustomerAddressMapper.responseToCustomerAddress(responseAddress);
                        }
                    }
                    break;
                case SectionCode.CUSTOMER_REFERENCES:
                    List<CustomerReferencesRemote.ReferenceInfo> references = service.getCustomerReferences(person.getServerId());
                    if (references != null) {
                        ReferencesData referencesData = new ReferencesData();
                        referencesData.setReferences(ReferenceMapper.reponsesToRefrences(references));
                        remoteData = referencesData.merge((ReferencesData) section.getSectionData());
                    }
                    break;
                case SectionCode.CUSTOMER_PAYMENTS:
                    PaymentCapacityResponse paymentResponse = service.getPaymentCapacity(person.getServerId());
                    if (paymentResponse != null) {
                        CustomerPayment customerPayment = (CustomerPayment) section.getSectionData();
                        if (customerPayment != null) {
                            remoteData = customerPayment.merge(PaymentCapacityMapper.responseToCustomerPayment(paymentResponse));
                        } else {
                            remoteData = PaymentCapacityMapper.responseToCustomerPayment(paymentResponse);
                        }
                    }
                    break;
                case SectionCode.CUSTOMER_BUSINESS:
                    CustomerBusiness customerBusiness = (CustomerBusiness) section.getSectionData();
                    if (customerBusiness != null && customerBusiness.getServerId() > 0) {
                        CustomerBusinessRemote customerWorkRemote = service.getCustomerWork(person.getServerId(), customerBusiness.getServerId());
                        remoteData = CustomerWorkMapper.responseToCustomerBusiness(customerWorkRemote);
                    }
                    break;
                case SectionCode.PARTNER_DATA:
                    PartnerData partnerData = (PartnerData) section.getSectionData();
                    PartnerDataRemote partnerDataRemote = service.getPartnerData(person.getServerId());
                    if (partnerDataRemote != null) {
                        if (partnerData != null) {
                            remoteData = partnerData.merge(PartnerDataMapper.responseToPartnerData(partnerDataRemote));
                        } else {
                            remoteData = PartnerDataMapper.responseToPartnerData(partnerDataRemote);
                        }
                    }
                    break;
                case SectionCode.PARTNER_WORK:
                    PartnerWork partnerWork = (PartnerWork) section.getSectionData();
                    if (partnerWork != null && partnerWork.getAddressData() != null && partnerWork.getAddressData().getServerId() > 0) {
                        PartnerWorkRemote partnerWorkResponse = service.getPartnerWork(person.getServerId(), partnerWork.getAddressData().getServerId(), partnerWork.getWorkphoneServerId(), partnerWork.getCellphoneServerId());
                        remoteData = PartnerWorkMapper.responseToPartnerWork(partnerWorkResponse);
                    }
                    break;
                case SectionCode.COMPLEMENTARY_DATA:
                    ComplementaryDataRemote dataRemote = service.getComplementaryData(person.getServerId());
                    if (dataRemote != null) {
                        remoteData = ComplementaryDataMapper.responseToComplementaryData(dataRemote);
                    }
                    break;
                default:
                    throw new RuntimeException("Get section data from remote is not implemented for section: " + sectionCode);
            }

            //replace section in local person
            if (remoteData != null) {
                section.setSectionData(remoteData);
                person.replaceSection(section);
                saveLocalPerson(person);
            }
        }
        return section.getSectionData();
    }

    @Override
    public ValidateResponse isValidPerson(ValidatePersonRequest request) throws Exception {
        return new ValidateService().isValidProspect(request);
    }

    @Override
    public ValidateResponse getCustomerInfo(ValidatePersonRequest request) throws Exception {
        return new ValidateService().getCustomerInfo(request);
    }

    @Override
    public ResultData saveReference(int personId, Reference reference, boolean isSync) throws Exception {
        Person person = getPerson(personId);

        ResultData result;
        //detect is online or not
        if (NetworkUtils.isOnline()) {
            //save remote
            boolean isUpdate = (reference.getServerId() > 0);
            PersonService service = new PersonService();
            ReferenceResponse response;
            if (isUpdate) {
                response = service.updateReference(person.getServerId(), ReferenceMapper.referenceToReferenceRequest(reference, isSync));
            } else {
                response = service.createReference(person.getServerId(), ReferenceMapper.referenceToReferenceRequest(reference, isSync));
            }
            if (response.isResult()) {
                reference.setStatus(SyncStatus.SYNCED);
                if (!isUpdate) {
                    reference.setServerId(response.getData().getReferenceId());
                }
                reference.setErrorMsg(null);
                result = new ResultData(ResultType.SUCCESS, response.getFirstMessage());
            } else {
                reference.setStatus(SyncStatus.ERROR);
                reference.setErrorMsg(response.getFirstMessage());
                result = new ResultData(ResultType.FAILURE, response.getFirstMessage());
            }
        } else {
            reference.setStatus(SyncStatus.PENDING);
            reference.setErrorMsg(null);
            result = new ResultData(ResultType.SUCCESS, null);
        }

        if (result.getType() == ResultType.SUCCESS || isSync) {
            saveReferenceLocal(person, reference);
        }

        return result;
    }

    @Override
    public int countPeople(@PersonType int type, @SyncStatus int[] status) throws Exception {
        return getAllForSync(type, status).size();
    }

    private void saveReferenceLocal(Person person, Reference reference) {
        Section section = Person.getSection(SectionCode.CUSTOMER_REFERENCES, person.getSections());
        ReferencesData sectionData = (ReferencesData) section.getSectionData();
        if (sectionData == null) {
            sectionData = new ReferencesData();
        }

        int position = sectionData.indexOf(reference.getId());
        if (position >= 0) {
            sectionData.getReferences().set(position, reference);
        } else {
            reference.setId(UUID.randomUUID().toString());
            sectionData.getReferences().add(reference);
        }

        section.setSectionData(sectionData);

        //update section status
        int max = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_REFERENCES);
        int referencesSize = sectionData.getReferences().size();
        int sync = getReferencesStatusCount(sectionData.getReferences(), SyncStatus.SYNCED);
        int error = getReferencesStatusCount(sectionData.getReferences(), SyncStatus.ERROR);

        if (error > 0) {
            section.setStatus(SyncStatus.ERROR);
        } else if (referencesSize >= max) {
            if (sync == referencesSize) {
                section.setStatus(SyncStatus.SYNCED);
            } else {
                section.setStatus(SyncStatus.PENDING);
            }
        } else if (referencesSize > 0) {
            section.setStatus(SyncStatus.DRAFT);
        } else {
            section.setStatus(SyncStatus.UNKNOWN);
        }
        person.replaceSection(section);
        person.setStatus(PersonValidator.checkPersonStatus(person));
        if (person.getStatus() == SyncStatus.SYNCED) {
            person.setAction(null);
        }
        saveLocalPerson(person);
    }

    private int getReferencesStatusCount(List<Reference> references, @SyncStatus int status) {
        int count = 0;
        for (Reference reference : references) {
            if (reference.getStatus() == status) {
                count++;
            }
        }
        return count;
    }

    @Override
    public ResultData saveSection(int personId, Section section, boolean isSync) throws Exception {
        Person person = getPerson(personId);
        return saveSection(person, section, isSync);
    }

    @Override
    public ResultData saveSection(Person person, Section section, boolean isSync) throws Exception {
        ResultData result;
        int personId = person.getId();

        //detect is online or not
        if (NetworkUtils.isOnline()) {
            //save remote
            result = saveSectionRemote(person, section, isSync);
            if (result.getType() == ResultType.SUCCESS) {
                section.setStatus(SyncStatus.SYNCED);
                section.setErrorMsg(null);
            } else {
                section.setStatus(SyncStatus.ERROR);
                section.setErrorMsg(result.getError());
            }
        } else {
            //change status
            section.setStatus(SyncStatus.PENDING);
            section.setErrorMsg(null);
            result = new ResultData(ResultType.SUCCESS, null);
        }

        if (result.getType() == ResultType.SUCCESS || isSync) {
            person.replaceSection(section);
            personId = saveSectionLocal(person, section);
        }
        result.setData(personId);

        return result;
    }

    @SuppressLint("WrongConstant")
    private ResultData saveSectionRemote(Person person, Section section, boolean isSync) throws Exception {
        switch (section.getCode()) {
            case SectionCode.PROSPECT_DATA:
                return saveProspectData(person, section, isSync);
            case SectionCode.CUSTOMER_DATA:
                return saveCustomerData(person, section, isSync);
            case SectionCode.CUSTOMER_ADDRESS:
                return saveCustomerAddress(person, section, isSync);
            case SectionCode.CUSTOMER_PAYMENTS:
                return saveCustomerPayment(person, section, isSync);
            case SectionCode.CUSTOMER_BUSINESS:
                return saveCustomerBusiness(person, section, isSync);
            case SectionCode.PARTNER_DATA:
                return savePartnerData(person, section, isSync);
            case SectionCode.PARTNER_WORK:
                return savePartnerWork(person, section);
            case SectionCode.CUSTOMER_DOCUMENTS:
                return saveCustomerDocuments(person, section);
            case SectionCode.CUSTOMER_REFERENCES:
                return saveCustomerReferences(person, section, isSync);
            case SectionCode.COMPLEMENTARY_DATA:
                return saveComplementaryData(person, section, isSync);
            default:
                throw new RuntimeException("Save Remote not implemented for section: " + section.getCode());
        }
    }

    private ResultData saveCustomerReferences(Person person, Section section, boolean isSync) {
        ResultData result = null;
        if (section.getSectionData() != null) {
            boolean validAll = true;
            ReferencesData data = (ReferencesData) section.getSectionData();
            for (Reference ref : data.getReferences()) {
                try {
                    ResultData rd = saveReference(person.getId(), ref, isSync);
                    if (rd.getType() == ResultType.FAILURE) {
                        validAll = false;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (validAll) {
                return new ResultData(ResultType.SUCCESS, null);
            } else {
                return new ResultData(ResultType.FAILURE, null);
            }
        }
        return result;
    }

    private ResultData saveComplementaryData(Person person, Section section, boolean isSync) throws Exception {
        PersonService service = new PersonService();
        ComplementaryData complementaryData = (ComplementaryData) section.getSectionData();
        //this section does not has a remote identifier, so we always use put or post
        GenericResponse response = service.updateComplementaryData(person.getServerId(), ComplementaryDataMapper.complementaryDataToRequest(person.getServerId(), complementaryData, isSync));
        if (response.isResult()) {
            return new ResultData(ResultType.SUCCESS, response.getFirstMessage());
        } else {
            return new ResultData(ResultType.FAILURE, response.getFirstMessage());
        }
    }

    private ResultData saveCustomerDocuments(Person person, Section section) {
        if (section.getSectionData() != null) {
            DocumentsData data = (DocumentsData) section.getSectionData();
            for (Document document : data.getDocuments()) {
                if (NetworkUtils.isOnline() && person.getServerId() > 0 && document.getStatus() == SyncStatus.PENDING) {
                    boolean uploaded = false;
                    try {
                        uploaded = new DocumentService().upload(person.getServerId(), document);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    if (uploaded) {
                        document.setStatus(SyncStatus.SYNCED);
                    } else {
                        document.setStatus(SyncStatus.PENDING);
                    }
                    data.replaceDocument(document);
                }
            }

            //update section data
            section.setSectionData(data);
            int syncStatus = DocumentRepository.getDocumentSyncStatus(data.getDocuments());
            section.setStatus(syncStatus);
            person.replaceSection(section);
            saveLocalPerson(person);
            return new ResultData(syncStatus == SyncStatus.SYNCED ? ResultType.SUCCESS : ResultType.FAILURE, null);
        }
        return null;
    }

    private ResultData savePartnerData(Person person, Section section, boolean isSync) throws Exception {
        PartnerData partnerData = (PartnerData) section.getSectionData();
        boolean isUpdate = (partnerData.getServerId() > 0);
        PersonService service = new PersonService();

        PartnerDataResponse response;
        if (isUpdate) {
            response = service.updatePartnerData(person.getServerId(), PartnerDataMapper.partnerToPartnerDataRequest(partnerData, isSync));
        } else {
            response = service.createPartnerData(person.getServerId(), PartnerDataMapper.partnerToPartnerDataRequest(partnerData, isSync));
        }

        if (response.getSpouse() != null && response.getSpouse().isResult()) {
            if (!isUpdate) {
                partnerData.setServerId(response.getSpouse().getData().getCustomerId());
            }
            section.setSectionData(partnerData);
            if (response.getAdditional() != null && response.getAdditional().isResult()) {
                return new ResultData(ResultType.SUCCESS, response.getSpouse().getFirstMessage());
            } else {
                return new ResultData(ResultType.FAILURE, response.getAdditional() != null ? response.getAdditional().getFirstMessage() : null);
            }
        } else {
            return new ResultData(ResultType.FAILURE, response.getSpouse() != null ? response.getSpouse().getFirstMessage() : null);
        }
    }

    private ResultData savePartnerWork(Person person, Section section) throws Exception {
        PartnerWork partnerWork = (PartnerWork) section.getSectionData();
        int addressId = (partnerWork.getAddressData() != null ? partnerWork.getAddressData().getServerId() : -1);
        boolean isUpdate = addressId > 0;
        PersonService service = new PersonService();

        PartnerWorkResponse response;
        if (isUpdate) {
            response = service.updatePartnerWork(person.getServerId(), PartnerWorkMapper.partnerWorkToRemote(partnerWork));
        } else {
            response = service.createPartnerWork(person.getServerId(), PartnerWorkMapper.partnerWorkToRemote(partnerWork));
        }

        if (response.getAddress() != null || response.getCellphone() != null || response.getWorkphone() != null) {
            if (response.getAddress() != null && response.getAddress().getData() != null) {
                partnerWork.getAddressData().setServerId(response.getAddress().getData().getAddressId());
            }
            PartnerWork.Builder partnerWorkBuilder = partnerWork.buildUpon();
            if (response.getCellphone() != null && response.getCellphone().getData() != null) {
                partnerWorkBuilder.addCellphoneServerId(response.getCellphone().getData().getPhoneId());
            }

            if (response.getWorkphone() != null && response.getWorkphone().getData() != null) {
                partnerWorkBuilder.addWorkphoneServerId(response.getWorkphone().getData().getPhoneId());
            }
            partnerWork = partnerWorkBuilder.build();
            section.setSectionData(partnerWork);
            return new ResultData(ResultType.SUCCESS, response.getAddress().getFirstMessage());
        } else {
            return new ResultData(ResultType.FAILURE, response.getAddress() != null ? response.getAddress().getFirstMessage() : null);
        }
    }

    private ResultData saveCustomerBusiness(Person person, Section section, boolean isSync) throws Exception {
        CustomerBusiness customerBusiness = (CustomerBusiness) section.getSectionData();
        PersonService service = new PersonService();
        ServiceResponse<CustomerWorkResponse> response;
        boolean isUpdate = (person.getServerId() > 0 && customerBusiness.getServerId() > 0 && customerBusiness.getAddressData().getServerId() > 0);
        if (isUpdate) {
            response = service.updateCustomerWork(person.getServerId(), CustomerWorkMapper.customerBusinessToCustomerBusinessRemote(customerBusiness, isSync));
        } else {
            response = service.createCustomerWork(person.getServerId(), CustomerWorkMapper.customerBusinessToCustomerBusinessRemote(customerBusiness, isSync));
        }
        if (response.isResult()) {
            Message message = null;
            CustomerWorkResponse workResponse = response.getData();
            if (workResponse != null) {
                if (workResponse.getBusiness() != null && workResponse.getBusiness().getData() != null) {
                    customerBusiness.setServerId(workResponse.getBusiness().getData().getBusinessId());
                    customerBusiness = customerBusiness.buildUpon().addPhoneId(workResponse.getBusiness().getData().getPhoneId()).build();
                    message = workResponse.getBusiness().getFirstMessage();
                }
                if (workResponse.getAddress() != null && workResponse.getAddress().getData() != null) {
                    customerBusiness.getAddressData().setServerId(workResponse.getAddress().getData().getAddressId());
                }
                section.setSectionData(customerBusiness);
            }
            return new ResultData(ResultType.SUCCESS, message);
        } else {
            return new ResultData(ResultType.FAILURE, response.getData().getBusiness() != null ? response.getData().getBusiness().getFirstMessage() : null);
        }
    }

    private ResultData saveCustomerPayment(Person person, Section section, boolean isSync) throws Exception {
        PersonService service = new PersonService();
        CustomerPayment customerPayment = (CustomerPayment) section.getSectionData();
        //MNA: this section not has remote identifier, for this reason always use put or post
        GenericResponse response = service.updatePaymentCapacity(person.getServerId(), PaymentCapacityMapper.customerPaymentToRequest(customerPayment, isSync));
        if (response != null && response.isResult()) {
            return new ResultData(ResultType.SUCCESS, response.getFirstMessage());
        } else {
            return new ResultData(ResultType.FAILURE, response != null ? response.getFirstMessage() : null);
        }
    }

    private ResultData saveCustomerAddress(Person customer, Section section, boolean isSync) throws Exception {
        customer.replaceSection(section);
        CustomerAddress customerAddress = (CustomerAddress) section.getSectionData();

        PersonService service = new PersonService();

        //TODO: Check geo-references
        boolean isUpdate = (customer.getServerId() > 0 && customerAddress.getAddressData().getServerId() > 0 && customerAddress.getEmailServerId() > 0 && customerAddress.getPhoneServerId() > 0 && customerAddress.getCellphoneServerId() > 0);
        SaveCustomerAddressResponse response;
        if (isUpdate) {
            response = service.updateCustomerAddress(customer.getServerId(), CustomerAddressMapper.personToCustomerAddressRequest(customer, isSync));
        } else {
            response = service.createCustomerAddress(customer.getServerId(), CustomerAddressMapper.personToCustomerAddressRequest(customer, isSync));
        }

        ResultData result;
        if (response.getAddress() != null && response.getAddress().isResult()) {
            //address
            result = new ResultData(ResultType.SUCCESS, response.getAddress().getFirstMessage());

            if (!isUpdate && response.getAddress().getData() != null) {
                customerAddress.getAddressData().setServerId(response.getAddress().getData().getAddressId());
            }

            //email
            if (response.getEmail() != null && response.getEmail().isResult()) {
                if (!isUpdate) {
                    customerAddress.setEmailServerId(response.getEmail().getData().getAddressId());
                }
            } else if (response.getEmail() == null && isUpdate) {
                result.setType(ResultType.FAILURE);
                result.addError(response.getEmail() != null ? response.getEmail().getFirstMessage() : null);
            }

            //phone
            if (response.getPhone() != null && response.getPhone().isResult()) {
                if (!isUpdate) {
                    customerAddress.setPhoneServerId(response.getPhone().getData().getPhoneId());
                }
            } else if (response.getPhone() == null && isUpdate) {
                result.setType(ResultType.FAILURE);
                result.addError(response.getPhone().getFirstMessage());
            }

            //cellphone
            if (response.getCellphone() != null && response.getCellphone().isResult()) {
                if (!isUpdate) {
                    customerAddress.setCellphoneServerId(response.getCellphone().getData().getPhoneId());
                }
            } else if (response.getCellphone() == null && isUpdate) {
                result.setType(ResultType.FAILURE);
                result.addError(response.getPhone().getFirstMessage());
            }

            section.setSectionData(customerAddress);
        } else {
            result = new ResultData(ResultType.FAILURE, response.getAddress() != null ? response.getAddress().getFirstMessage() : null);
        }
        return result;
    }

    private ResultData saveCustomerData(Person customer, Section section, boolean isSync) throws Exception {
        SaveCustomerDataResponse response;
        PersonService service = new PersonService();
        boolean isUpdate = customer.getServerId() > 0;
        if (isUpdate) {
            response = service.updateCustomerData(CustomerMapper.customerToCustomerRequest(customer, isSync));
        } else {
            response = service.createCustomerData(CustomerMapper.customerToCustomerRequest(customer, isSync));
        }

        ResultData result;
        CustomerData customerData = (CustomerData) section.getSectionData();
        if (response.getCustomer() != null && response.getCustomer().isResult()) {
            if (!isUpdate) {
                customer.setServerId(response.getCustomer().getData().getCustomerId());
                //TODO: here retrieve CURP and RFC
                section.setSectionData(customerData);
            }
            result = new ResultData(ResultType.SUCCESS, response.getCustomer().getFirstMessage());
        } else {
            result = new ResultData(ResultType.FAILURE, response.getCustomer() != null ? response.getCustomer().getFirstMessage() : null);
        }
        return result;
    }

    private ResultData saveProspectData(Person prospect, Section section, boolean isSync) throws Exception {
        ProspectData prospectData = (ProspectData) section.getSectionData();
        ResultData result = null;
        SaveProspectResponse response;

        boolean isUpdated = (prospect.getServerId() > 0 && (prospectData.getAddressData() != null && prospectData.getAddressData().getServerId() > 0));
        PersonService service = new PersonService();
        if (isUpdated) {
            response = service.updateProspectData(ProspectMapper.prospectToProspectRequest(prospect, isSync));
        } else {
            response = service.createProspectData(ProspectMapper.prospectToProspectRequest(prospect, isSync));
        }

        boolean resultSave;
        if (response.getProspect() != null && response.getProspect().isResult()) {
            if (!isUpdated) {
                prospect.setServerId(response.getProspect().getData().getCustomerId());
            }

            if (response.getProspect().getData() != null) {
                prospectData.setEmailAddressId(response.getProspect().getData().getEmailAddressId());
            }
            resultSave = true;
        } else if (response.getProspect() != null) {
            resultSave = false;
        } else {
            resultSave = (prospect.getServerId() > 0);
        }

        if (resultSave) {
            if (response.getAddress() != null && response.getAddress().isResult()) {
                if (!isUpdated) {
                    prospectData.getAddressData().setServerId(response.getAddress().getData().getAddressId());
                    section.setSectionData(prospectData);
                }
                result = new ResultData(ResultType.SUCCESS, response.getProspect() != null ? response.getProspect().getFirstMessage() : response.getAddress().getFirstMessage());
            } else {
                result = new ResultData(ResultType.FAILURE, response.getAddress() != null ? response.getAddress().getFirstMessage() : null);
            }
        } else {
            result = new ResultData(ResultType.FAILURE, response.getProspect() != null ? response.getProspect().getFirstMessage() : null);
        }
        return result;
    }

    /**
     * @param person
     * @return Return Person Identifier
     */
    @Override
    public int saveLocalPerson(Person person) {
        int personId = -1;
        PersistencePerson persistence = null;
        try {
            persistence = new PersistencePerson();
            personId = persistence.saveOrUpdate(person);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        //update data group
        if (person.getServerId() > 0 && person.getGroupId() > 0) {
            Group group = GroupRepository.getInstance().getById(person.getGroupId());
            if (group != null && !CommonUtils.isNullOrEmpty(group.getMembers())) {
                for (Member member : group.getMembers()) {
                    if (member.getServerId() == person.getServerId()) {
                        member.updateName(person.getName());
                        member.updateRfc(person.getDocument());
                        member.setLocalSpouseId(person.getSpouseId());
                        GroupRepository.getInstance().saveGroupLocal(group);
                        break;
                    }
                }
            }
        }
        return personId;
    }

    @Override
    public int getPersonStatus(int serverId) {
        int status;
        PersistencePerson persistence = null;
        try {
            persistence = new PersistencePerson();
            status = persistence.getStatus(serverId);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return status;
    }

    private PartnerData getSpouseData(int spouseId) {
        Person spouse = getPerson(spouseId);
        PartnerData partnerData = null;
        if (spouse != null) {
            if (spouse.getType() == PersonType.PROSPECT) {
                ProspectData prospectData = (ProspectData) Person.getSection(SectionCode.PROSPECT_DATA, spouse.getSections()).getSectionData();
                partnerData = PartnerDataMapper.fromProspectData(prospectData);
            } else if (spouse.getType() == PersonType.CUSTOMER) {
                CustomerData customerData = (CustomerData) Person.getSection(SectionCode.CUSTOMER_DATA, spouse.getSections()).getSectionData();
                partnerData = new PartnerData.Builder().addGeneralPersonData(customerData.getGeneralPersonData()).build();
            } else {
                Log.w("Type not supported!");
            }
            if (partnerData != null) {
                partnerData.setServerId(spouse.getServerId());
            }
        }
        return partnerData;
    }

    private Person saveSpouseData(Person person, Section section) {
        PersistencePerson persistence = null;
        try {
            persistence = new PersistencePerson();
            PartnerData partnerData = (PartnerData) section.getSectionData();
            GeneralPersonData generalPersonData = partnerData.getGeneralPersonData();
            Person personSpouse = getPersonByServerId(partnerData.getServerId());
            if (personSpouse == null) {
                personSpouse = findSpouse(person);
            }
            if (personSpouse == null) {
                personSpouse = new Person.Builder().setType(PersonType.PROSPECT).setDocument(generalPersonData.getRfc()).setName(generalPersonData.getName()).setStatus(SyncStatus.DRAFT).setSpouseId(person.getId()).setServerId(partnerData.getServerId()).build();
            }

            CustomerData customerData = (CustomerData) Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections()).getSectionData();
            if (personSpouse.getType() == PersonType.PROSPECT) {
                Section sectionProspect = Person.getSection(SectionCode.PROSPECT_DATA, personSpouse.getSections());
                ProspectData existProspectData = (ProspectData) sectionProspect.getSectionData();
                ProspectData newProspectData = ProspectMapper.generateProspectData(generalPersonData, customerData.getCivilStatus());
                if (existProspectData != null) {
                    sectionProspect.setSectionData(existProspectData.merge(newProspectData));
                } else {
                    sectionProspect.setStatus(SyncStatus.DRAFT);
                    sectionProspect.setSectionData(newProspectData);
                }
                personSpouse.replaceSection(sectionProspect);
            } else if (personSpouse.getType() == PersonType.CUSTOMER) {
                personSpouse = changeCivilStatus(personSpouse, customerData.getCivilStatus());

                Section partnerCustomerData = Person.getSection(SectionCode.CUSTOMER_DATA, personSpouse.getSections());
                CustomerData customerPartnerExist = (CustomerData) partnerCustomerData.getSectionData();
                customerPartnerExist.mergeGeneralData(generalPersonData);
                partnerCustomerData.setSectionData(customerPartnerExist);
                personSpouse.replaceSection(partnerCustomerData);

                Section spousePartnerDataSection = Person.getSection(SectionCode.PARTNER_DATA, person.getSections());
                PartnerData originalPartnerData = (PartnerData) spousePartnerDataSection.getSectionData();
                PartnerData personPartnerData = new PartnerData.Builder().addGeneralPersonData(customerData.getGeneralPersonData()).build();
                if (originalPartnerData == null) {
                    originalPartnerData = personPartnerData;
                } else {
                    originalPartnerData.merge(personPartnerData);
                }
                spousePartnerDataSection.setSectionData(originalPartnerData);
                spousePartnerDataSection.setStatus(originalPartnerData.isComplete() ? SyncStatus.SYNCED : SyncStatus.DRAFT);
                personSpouse.replaceSection(spousePartnerDataSection);
            } else {
                Log.e("Not type supported!!");
            }
            //save spouse person
            if (partnerData.getServerId() > 0) {
                personSpouse.setServerId(partnerData.getServerId());
            }
            personSpouse.setSpouseId(person.getId());
            int spouseId = saveLocalPerson(personSpouse);

            //update person
            person.setSpouseId(spouseId);
            section.setSectionData(partnerData);
            person.replaceSection(section);
        } catch (Exception ex) {
            Log.e("PersonRepository::createPartnerPerson: ", ex);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return person;
    }

    private int saveSectionLocal(Person person, Section section) {
        Person spouse = null;
        switch (section.getCode()) {
            case SectionCode.PARTNER_DATA:
                person = saveSpouseData(person, section);
                person = shareWorkData(person);
                break;
            case SectionCode.PROSPECT_DATA:
            case SectionCode.CUSTOMER_DATA:
                person = processPartnerRelation(person);
                break;
            case SectionCode.PARTNER_WORK:
                spouse = sharePartnerWork(person, findSpouse(person));
                if (spouse != null) {
                    saveLocalPerson(spouse);
                }
                break;
            case SectionCode.CUSTOMER_BUSINESS:
                spouse = shareCustomerBusiness(person, findSpouse(person));
                if (spouse != null) {
                    saveLocalPerson(spouse);
                }
                break;
        }

        //Cleanup person sections and set correct status
        person = new Person.Builder().build(person);
        int status = PersonValidator.checkPersonStatus(person);
        person.setStatus(status);
        if (status == SyncStatus.SYNCED) {
            person.setAction(null);
        }
        return saveLocalPerson(person);
    }

    private Person processPartnerRelation(Person person) {
        if (PersonValidator.isSingle(person)) {
            //if single then look for partner
            Person personSpouse = findSpouse(person);
            //If partner exists
            if (personSpouse != null) {
                personSpouse = makeSingle(personSpouse);
                saveLocalPerson(personSpouse);
            }
            person.setSpouseId(-1);
        }
        return person;
    }

    private Person changeCivilStatus(Person person, String civilStatus) {
        if (PersonType.CUSTOMER == person.getType()) {
            //if partner exists change to single and refresh sections
            Section customerDataSection = Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections());
            CustomerData partnerCustomerData = (CustomerData) customerDataSection.getSectionData();
            if (partnerCustomerData != null) {
                partnerCustomerData.setCivilStatus(civilStatus);
                person.replaceSection(customerDataSection);
            }

        } else if (PersonType.PROSPECT == person.getType()) {
            Section prospectDataSection = Person.getSection(SectionCode.PROSPECT_DATA, person.getSections());
            ProspectData prospectData = (ProspectData) prospectDataSection.getSectionData();
            if (prospectData != null) {
                prospectData.setCivilStatus(civilStatus);
                person.replaceSection(prospectDataSection);
            }
        } else {
            Log.e("Not type supported!!");
        }
        //save partner
        person = new Person.Builder().build(person);
        int status = PersonValidator.checkPersonStatus(person);
        person.setStatus(status);
        return person;
    }

    private Person makeSingle(Person person) {
        person = changeCivilStatus(person, CivilStatus.SINGLE);
        //save partner
        person.setSpouseId(-1);
        person = new Person.Builder().build(person);
        int status = PersonValidator.checkPersonStatus(person);
        person.setStatus(status);
        return person;
    }

    private Person shareWorkData(Person person) {
        Person spouse = findSpouse(person);
        if (spouse != null) {
            if (person.getType() == PersonType.CUSTOMER && spouse.getType() == PersonType.CUSTOMER) {
                //Person gives customer work --> Partner Work
                spouse = shareCustomerBusiness(person, spouse);
                if (spouse != null) {
                    saveLocalPerson(spouse);
                }
                //Spouse gives customer work --> Partner Work
                person = shareCustomerBusiness(spouse, person);
            }
        }
        return person;
    }

    private Person shareCustomerBusiness(Person personSharing, Person personReceiving) {
        //if we find a partner then share business data with partner
        if (personReceiving != null && personReceiving.getType() == PersonType.CUSTOMER && personReceiving.getType() == PersonType.CUSTOMER) {
            Section customerBusinessSection = Person.getSection(SectionCode.CUSTOMER_BUSINESS, personSharing.getSections());
            if (customerBusinessSection != null && customerBusinessSection.getSectionData() != null) {
                CustomerBusiness customerBusiness = (CustomerBusiness) customerBusinessSection.getSectionData();
                AddressData addressData = customerBusiness.getAddressData();
                personReceiving = new Person.Builder().build(personReceiving);
                Section partnerWorkSection = Person.getSection(SectionCode.PARTNER_WORK, personReceiving.getSections());

                PartnerWork partnerWork = (PartnerWork) partnerWorkSection.getSectionData();
                if (partnerWork != null) {
                    partnerWork = partnerWork.buildUpon()
                            .addTelephoneWork(customerBusiness.getPhoneNumber())
                            .addWorkphoneServerId(customerBusiness.getPhoneId())
                            .addAddressData(addressData)
                            .build();
                } else {
                    partnerWork = new PartnerWork.Builder()
                            .addTelephoneWork(customerBusiness.getPhoneNumber())
                            .addWorkphoneServerId(customerBusiness.getPhoneId())
                            .addAddressData(addressData)
                            .build();
                }
                partnerWorkSection.setSectionData(partnerWork);
                // TODO: 1/15/2018 determine section state
                personReceiving.replaceSection(partnerWorkSection);
                personReceiving = new Person.Builder().build(personReceiving);
                int status = PersonValidator.checkPersonStatus(personReceiving);
                personReceiving.setStatus(status);
            }
        }
        return personReceiving;
    }

    private Person sharePartnerWork(Person personSharing, Person personReceiving) {
        //if we find a partner then share partner work with partner
        if (personReceiving != null && personReceiving.getType() == PersonType.CUSTOMER && personReceiving.getType() == PersonType.CUSTOMER) {
            Section partnerWorkSection = Person.getSection(SectionCode.PARTNER_WORK, personSharing.getSections());
            if (partnerWorkSection != null && partnerWorkSection.getSectionData() != null) {
                PartnerWork partnerWork = (PartnerWork) partnerWorkSection.getSectionData();
                AddressData addressData = partnerWork.getAddressData();
                Section customerBusinessSection = Person.getSection(SectionCode.CUSTOMER_BUSINESS, personReceiving.getSections());
                CustomerBusiness customerBusiness = (CustomerBusiness) customerBusinessSection.getSectionData();
                if (customerBusiness != null) {
                    customerBusiness = customerBusiness.buildUpon()
                            .addPhoneId(partnerWork.getWorkphoneServerId())
                            .addPhoneNumber(partnerWork.getTelephoneWork())
                            .addAddressData(addressData)
                            .build();
                } else {
                    customerBusiness = new CustomerBusiness.Builder()
                            .addPhoneId(partnerWork.getWorkphoneServerId())
                            .addPhoneNumber(partnerWork.getTelephoneWork())
                            .addAddressData(addressData)
                            .build();
                }
                customerBusinessSection.setSectionData(customerBusiness);
                // TODO: 1/15/2018 Determine section status
                personReceiving.replaceSection(customerBusinessSection);
                personReceiving = new Person.Builder().build(personReceiving);
                int status = PersonValidator.checkPersonStatus(personReceiving);
                personReceiving.setStatus(status);
            }
        }
        return personReceiving;
    }

    @Override
    public void applyPartnerInfo(Person person) {
        Person personSpouse = findSpouse(person);

        if (personSpouse != null) {
            person = shareCustomerBusiness(personSpouse, person);
            person = sharePartnerWork(personSpouse, person);
            saveLocalPerson(person);
        }
    }

    @Nullable
    private Person findSpouse(Person person) {
        Section partnerDataSection = Person.getSection(SectionCode.PARTNER_DATA, person.getSections());

        int partnerServerId = 0;
        if (partnerDataSection != null && partnerDataSection.getSectionData() != null) {
            partnerServerId = ((PartnerData) partnerDataSection.getSectionData()).getServerId();
        }

        Person personSpouse = null;
        if (person.getSpouseId() > 0) {
            personSpouse = getPerson(person.getSpouseId());
        }
        if (personSpouse == null && partnerServerId > 0) {
            personSpouse = getPersonByServerId(partnerServerId);
        }
        return personSpouse;
    }

    /**
     * Allows delete the reference of the group
     *
     * @param groupId Group identifier
     * @return True if references was deleted, false in otherwise
     */
    public boolean deleteRelationGroup(int groupId) {
        PersistencePerson persistence = null;
        boolean result = false;
        try {
            persistence = new PersistencePerson();
            persistence.deleteRelationGroup(groupId);
            result = true;
        } catch (Exception ex) {
            Log.e("PersonRepository::deleteRelationGroup: ", ex);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    public boolean updateRelationGroup(int serverId, int groupId) {
        return updateRelationGroup(new int[]{serverId}, groupId);
    }

    public boolean updateRelationGroup(int[] serverId, int groupId) {
        PersistencePerson persistence = null;
        boolean result = false;
        try {
            persistence = new PersistencePerson();
            persistence.updateRelationGroup(serverId, groupId);
            result = true;
        } catch (Exception ex) {
            Log.e("PersonRepository::updateRelationGroup: ", ex);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public boolean cleanUpPersonRelationsGroup(Group group) {
        PersistencePerson persistence = null;
        boolean result = false;
        try {
            persistence = new PersistencePerson();
            List<Person> people = persistence.getByGroupId(group.getId());
            List<Integer> serverIds = new ArrayList<>();
            for (Person person : people) {
                if (!group.isPersonMember(person)) {
                    serverIds.add(person.getServerId());
                }
            }
            int[] ids = new int[serverIds.size()];
            for (int i = 0; i < serverIds.size(); i++) {
                ids[i] = serverIds.get(i);
            }
            updateRelationGroup(ids, -1);

            result = true;
        } catch (Exception ex) {
            Log.e("PersonRepository::cleanUpPersonRelationsGroup: ", ex);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }
}