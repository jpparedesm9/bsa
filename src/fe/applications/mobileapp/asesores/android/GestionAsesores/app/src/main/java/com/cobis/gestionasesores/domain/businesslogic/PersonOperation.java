package com.cobis.gestionasesores.domain.businesslogic;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.RiskLevel;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.mappers.RiskLevelMapper;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.requests.ValidatePersonRequest;
import com.cobis.gestionasesores.data.models.responses.ValidateResponse;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.source.PersonDataSource;

public class PersonOperation {

    private PersonDataSource mPersonDataSource;

    public PersonOperation() {
        mPersonDataSource = PersonRepository.getInstance();
    }

    public ResultData validatePerson(int personId) throws Exception {
        Person person = mPersonDataSource.getPerson(personId);
        ValidatePersonRequest request = new ValidatePersonRequest(true, new ValidatePersonRequest.DataStruct(person.getServerId()));
        ValidateResponse response = mPersonDataSource.isValidPerson(request);

        if (response.isResult()) {
            String value = response.getBuroResponse().getRuleExecutionResult();
            String riskLevel = RiskLevelMapper.fromRemote(value);
            person.setRiskLevel(riskLevel);

            boolean isValidated = RiskLevel.LOW.equals(riskLevel);

            person.setValidated(isValidated);

            mPersonDataSource.saveLocalPerson(person);
            return new ResultData(isValidated ? ResultType.SUCCESS : ResultType.FAILURE, response.getFirstMessage(), riskLevel);
        }
        //person.setStatus(SyncStatus.ERROR);
        person.setErrorMsg(response.getFirstMessage());
        mPersonDataSource.saveLocalPerson(person);
        return new ResultData(ResultType.FAILURE, response.getFirstMessage());
    }

    public ResultData aquireCustomerInfo(int personId) throws Exception {
        Person person = mPersonDataSource.getPerson(personId);
        ValidatePersonRequest request = new ValidatePersonRequest(true, new ValidatePersonRequest.DataStruct(person.getServerId()));
        ValidateResponse response = mPersonDataSource.getCustomerInfo(request);

        if (response.isResult()) {

            boolean isValid = StringUtils.isNotEmpty(response.getCustomerCoreInfo().getCustomerAccountId()) && StringUtils.isNotEmpty(response.getCustomerCoreInfo().getCustomerStdCode());

            if (person.getType() == PersonType.CUSTOMER) {
                CustomerData customerData = (CustomerData) Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections()).getSectionData();
                if (StringUtils.isNotEmpty(response.getCustomerCoreInfo().getCustomerStdCode())) {
                    customerData.setCustomerNumber(response.getCustomerCoreInfo().getCustomerStdCode());
                }
                if (StringUtils.isNotEmpty(response.getCustomerCoreInfo().getCustomerAccountId())) {
                    customerData.setCustomerAccountNumber(response.getCustomerCoreInfo().getCustomerAccountId());
                }
            }

            if (person.getType() == PersonType.PROSPECT) {
                ProspectData prospectData = (ProspectData) Person.getSection(SectionCode.PROSPECT_DATA, person.getSections()).getSectionData();
                if (StringUtils.isNotEmpty(response.getCustomerCoreInfo().getCustomerStdCode())) {
                    prospectData.setNumber(response.getCustomerCoreInfo().getCustomerStdCode());
                }
                if (StringUtils.isNotEmpty(response.getCustomerCoreInfo().getCustomerAccountId())) {
                    prospectData.setAccountNumber(response.getCustomerCoreInfo().getCustomerAccountId());
                }
            }

            mPersonDataSource.saveLocalPerson(person);
            return new ResultData(isValid ? ResultType.SUCCESS : ResultType.FAILURE, response.getFirstMessage(), person);
        }
        //person.setStatus(SyncStatus.ERROR);
        person.setErrorMsg(response.getFirstMessage());
        mPersonDataSource.saveLocalPerson(person);
        return new ResultData(ResultType.FAILURE, response.getFirstMessage());
    }
}
