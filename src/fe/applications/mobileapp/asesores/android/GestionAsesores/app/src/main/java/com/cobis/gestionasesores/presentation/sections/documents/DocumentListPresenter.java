package com.cobis.gestionasesores.presentation.sections.documents;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.domain.usecases.GetDocumentsUseCase;

import java.util.List;

import io.reactivex.observers.DisposableObserver;

public class DocumentListPresenter implements DocumentListContract.Presenter {
    @NonNull
    private DocumentListContract.View mView;
    private GetDocumentsUseCase mGetDocumentsUseCase;
    private Section mSection;
    private int mPersonId;

    public DocumentListPresenter(@NonNull DocumentListContract.View mView, Section section, int personId, GetDocumentsUseCase getDocumentsUseCase) {
        this.mView = mView;
        this.mView.setPresenter(this);
        mGetDocumentsUseCase = getDocumentsUseCase;
        mSection = section;
        mPersonId = personId;
    }

    @Override
    public void start() {
        loadDocuments(NetworkUtils.isOnline());
    }

    private void loadDocuments(boolean tryOnline) {
        mView.showLoadingProgress();
        mGetDocumentsUseCase.execute(new GetDocumentsUseCase.DocumentsRequest(mPersonId, tryOnline), new DisposableObserver<DocumentsData>() {
            @Override
            public void onNext(@NonNull DocumentsData documentsData) {
                mSection.setSectionData(documentsData);
                mView.showDocuments(getDocuments());
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.hideLoadingProgress();
                mView.showLoadingError();
            }

            @Override
            public void onComplete() {
                mView.hideLoadingProgress();
            }
        });
    }

    private List<Document> getDocuments() {
        return ((DocumentsData) mSection.getSectionData()).getDocuments();
    }

    @Override
    public void onDocumentSelect(Document document) {
        mView.startDocumentForm(mPersonId, document.getType(), (DocumentsData) mSection.getSectionData());
    }

    @Override
    public void onDocumentResultOk() {
        loadDocuments(false);
    }

    @Override
    public void onTryToExit() {
        mView.sendResult(mPersonId);
    }

    @Override
    public void cleanUp() {
        mGetDocumentsUseCase.dispose();
    }
}
