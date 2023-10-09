package com.cobis.gestionasesores.presentation.sections.documents;

import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

public class DocumentListContract {
    public interface Presenter extends BasePresenter {

        void onDocumentSelect(Document document);

        void onDocumentResultOk();

        void onTryToExit();

        void cleanUp();
    }

    public interface View extends BaseView<Presenter> {

        void showDocuments(List<Document> documents);

        void startDocumentForm(int personId, @DocumentType String type, DocumentsData documents);

        void sendResult(int personId);

        void showLoadingProgress();

        void hideLoadingProgress();

        void showLoadingError();
    }
}
