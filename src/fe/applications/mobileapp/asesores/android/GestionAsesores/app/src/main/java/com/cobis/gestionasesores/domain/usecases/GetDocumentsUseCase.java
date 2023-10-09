package com.cobis.gestionasesores.domain.usecases;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.source.DocumentDataSource;

import java.io.File;

import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.schedulers.Schedulers;

public class GetDocumentsUseCase extends UseCase<GetDocumentsUseCase.DocumentsRequest, DocumentsData> {

    private DocumentDataSource mDocumentDataSource;

    public GetDocumentsUseCase(DocumentDataSource documentDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mDocumentDataSource = documentDataSource;
    }

    @Override
    protected Observable<DocumentsData> createObservableUseCase(final DocumentsRequest parameter) {
        return Observable.create(new ObservableOnSubscribe<DocumentsData>() {
            @Override
            public void subscribe(@NonNull ObservableEmitter<DocumentsData> e) throws Exception {
                Person person = PersonRepository.getInstance().getPerson(parameter.personId);
                Section documentSection = Person.getSection(SectionCode.CUSTOMER_DOCUMENTS, person.getSections());
                DocumentsData documentsData = null;
                if (documentSection != null) {
                    documentsData = ((DocumentsData) documentSection.getSectionData());
                }
                if (documentsData == null) {
                    documentsData = DocumentsData.createInstance();
                    e.onNext(documentsData);
                } else {
                    documentsData = documentsData.merge(DocumentsData.createInstance());
                    e.onNext(documentsData);
                    if (parameter.tryOnline) {
                        for (int i = 0; i < documentsData.getDocuments().size(); i++) {
                            if (!e.isDisposed()) {
                                Document document = documentsData.getDocuments().get(i);
                                if (StringUtils.isNotEmpty(document.getImage()) && !new File(document.getImage()).exists()) {
                                    documentsData.getDocuments().set(i, mDocumentDataSource.getDocument(parameter.personId, document));
                                }
                                e.onNext(documentsData);
                            }
                        }
                    }
                }
                e.onComplete();
            }
        });
    }

    public static class DocumentsRequest {
        private int personId;
        private boolean tryOnline;

        public DocumentsRequest(int personId, boolean tryOnline) {
            this.personId = personId;
            this.tryOnline = tryOnline;
        }
    }
}
