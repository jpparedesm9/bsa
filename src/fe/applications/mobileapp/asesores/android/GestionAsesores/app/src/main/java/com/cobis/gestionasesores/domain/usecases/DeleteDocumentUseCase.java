package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.DocumentRepository;
import com.cobis.gestionasesores.data.source.PersonDataSource;
import com.cobis.gestionasesores.domain.businesslogic.PersonValidator;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by Miguel on 06/08/2017.
 */

public class DeleteDocumentUseCase extends UseCase<DeleteDocumentUseCase.Params, Boolean> {
    private PersonDataSource mPersonDataSource;

    public DeleteDocumentUseCase(PersonDataSource mPersonDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        this.mPersonDataSource = mPersonDataSource;
    }

    @Override
    protected Observable<Boolean> createObservableUseCase(final Params parameter) {
        return Observable.fromCallable(new Callable<Boolean>() {
            @Override
            public Boolean call() throws Exception {
                //TODO: actually delete only local, implements delete remote
                Person person = mPersonDataSource.getPerson(parameter.personId);
                Section section = Person.getSection(SectionCode.CUSTOMER_DOCUMENTS, person.getSections());
                DocumentsData data = (DocumentsData) section.getSectionData();
                Document document = data.getDocumentByType(parameter.documentType);
                document.setStatus(SyncStatus.UNKNOWN);
                document.setImage(null);
                data.getDocuments().set(data.getDocuments().indexOf(document), document);

                //update references
                section.setSectionData(data);
                section.setStatus(DocumentRepository.getDocumentSyncStatus(data.getDocuments()));
                person.replaceSection(section);
                person.setStatus(PersonValidator.checkPersonStatus(person));
                mPersonDataSource.saveLocalPerson(person);
                return true;
            }
        });
    }

    public static class Params {
        private int personId;
        private String documentType;

        public Params(int personId, String documentType) {
            this.personId = personId;
            this.documentType = documentType;
        }
    }
}
