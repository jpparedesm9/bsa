package com.cobis.gestionasesores.data.repositories;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.source.DocumentDataSource;
import com.cobis.gestionasesores.data.source.remote.DocumentService;
import com.cobis.gestionasesores.domain.businesslogic.PersonValidator;

import java.io.IOException;
import java.util.List;

/**
 * Created by mnaunay on 14/07/2017.
 */

public class DocumentRepository implements DocumentDataSource {
    private static DocumentRepository sInstance;

    public static DocumentRepository getInstance() {
        if (sInstance == null) {
            sInstance = new DocumentRepository();
        }
        return sInstance;
    }

    private DocumentRepository() {
    }

    @Override
    public ResultData saveDocument(int personId, DocumentsData data, @DocumentType String type) throws IOException {
        PersonRepository personRepository = PersonRepository.getInstance();
        Person person = personRepository.getPerson(personId);
        Document document = data.getDocumentByType(type);

        //upload to remote repository
        if (NetworkUtils.isOnline() && person.getServerId() > 0) {
            boolean uploaded = new DocumentService().upload(person.getServerId(), document);
            document.setStatus(uploaded ? SyncStatus.SYNCED : SyncStatus.PENDING);
        } else {
            document.setStatus(SyncStatus.PENDING);
        }
        data.replaceDocument(document);

        //update section data
        Section section = Person.getSection(SectionCode.CUSTOMER_DOCUMENTS, person.getSections());
        section.setSectionData(data);

        //update status section
        int syncStatus = getDocumentSyncStatus(data.getDocuments());
        section.setStatus(syncStatus);

        person.replaceSection(section);

        person.setStatus(PersonValidator.checkPersonStatus(person));
        if (person.getStatus() == SyncStatus.SYNCED) {
            person.setAction(null);
        }
        if (personRepository.saveLocalPerson(person) > 0) {
            return new ResultData(ResultType.SUCCESS, null, document);
        } else {
            return new ResultData(ResultType.FAILURE, null);
        }
    }

    @Override
    public Document getDocument(int localPersonId, Document oldDocument) throws IOException {
        PersonRepository personRepository = PersonRepository.getInstance();
        Person person = personRepository.getPerson(localPersonId);
        if (NetworkUtils.isOnline() && person.getServerId() > 0) {
            String path = new DocumentService().download(person.getServerId(), oldDocument.getType(), oldDocument.getExtension(), oldDocument.getImage());
            oldDocument.setImage(path);
        }
        return oldDocument;
    }

    public static int getDocumentSyncStatus(List<Document> documents) {
        int complete = 0, pending = 0;
        for (int i = 0; i < documents.size(); i++) {
            if (documents.get(i).getStatus() == SyncStatus.SYNCED) {
                complete++;
            }
            if (documents.get(i).getStatus() == SyncStatus.PENDING) {
                pending++;
            }
        }
        int sync;
        if (complete == documents.size()) {
            sync = SyncStatus.SYNCED;
        } else if ((pending + complete) == documents.size()) {
            sync = SyncStatus.PENDING;
        } else if (pending > 0 || complete > 0) {
            sync = SyncStatus.DRAFT;
        } else {
            sync = SyncStatus.UNKNOWN;
        }
        return sync;
    }
}
