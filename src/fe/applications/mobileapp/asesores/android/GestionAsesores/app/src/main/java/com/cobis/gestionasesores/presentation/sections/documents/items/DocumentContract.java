package com.cobis.gestionasesores.presentation.sections.documents.items;

import android.content.Context;
import android.net.Uri;

import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 * Created by mnaunay on 14/06/2017.
 */

public final class DocumentContract {
    public interface Presenter extends BasePresenter {

        void onExpirationSet(int year, int month, int dayOfMonth);

        void onClickExpirationDate();

        void onClickTakePicture();

        void processResultBitmap(Uri selectedImageUri, boolean isCamera);

        boolean isEditMode();

        void saveDocument(String documentPath);

        void deleteDocument();

        boolean isEditable();
    }

    public interface View extends BaseView<Presenter> {
        void showDateDialog();

        void setDocument(Document document);

        void setExpirationDate(Long date);

        void clearErrors();

        void showCaptureError();

        void showDocumentImage(String documentPath);

        void openImageIntent(String path);

        Context getContext();

        void showExpirationDateError();

        void showImageEmpty();

        void sendResult();

        void showDocumentSave();

        void showDocumentEdit();

        void showDocumentDelete();

        void showDocumentSaveError();

        void showSaveError();

        void showSaveProgress();

        void dismissProgress();

        void showDeleteDocumentError();

        void showTitle(String documentType);

        void showNetworkError();
    }
}
