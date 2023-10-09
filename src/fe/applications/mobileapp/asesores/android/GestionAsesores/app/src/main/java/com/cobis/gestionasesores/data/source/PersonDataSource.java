package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.SectionData;
import com.cobis.gestionasesores.data.models.requests.GetPersonsRequest;
import com.cobis.gestionasesores.data.models.requests.ValidatePersonRequest;
import com.cobis.gestionasesores.data.models.responses.ValidateResponse;

import java.util.List;

import io.reactivex.Observable;

/**
 * Person data source interface
 * Created by mnaunay on 09/06/2017.
 */

public interface PersonDataSource {
    Observable<Boolean> delete(int id);

    List<Person> getAllForSync(int type, int[] status);

    List<Person> getAll(GetPersonsRequest request);

    Person getPerson(int id);

    Person getPersonByServerId(int serverId);

    ValidateResponse isValidPerson(ValidatePersonRequest request) throws Exception;

    ValidateResponse getCustomerInfo(ValidatePersonRequest request) throws Exception;

    SectionData getSectionData(int personId, @SectionCode String sectionCode, boolean tryOnline) throws Exception;

    ResultData saveSection(int personId, Section section, boolean isSync) throws Exception;

    ResultData saveSection(Person prospect, Section section, boolean isSync) throws Exception;

    int saveLocalPerson(Person person);

    @SyncStatus
    int getPersonStatus(int serverId);

    ResultData saveReference(int personId, Reference reference, boolean isSync) throws Exception;

    int countPeople(@PersonType int type, @SyncStatus int[] status) throws Exception;

    void applyPartnerInfo(Person person);

    boolean cleanUpPersonRelationsGroup(Group group);
}
