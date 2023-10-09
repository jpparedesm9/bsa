package com.cobis.gestionasesores.presentation.sections.references.items;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

import java.util.List;

/**
 * Created by Miguel on 11/06/2017.
 */

public final class ReferenceContract {
    public interface Presenter extends BasePresenter, ErrorBaseContract.ErrorBasePresenter {
        void saveReference(Reference reference);

        boolean isDeleteEnabled();

        void deleteReference();

        void acceptWarning();
    }

    public interface View extends SectionViewBase, BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {
        void setReference(Reference reference);

        void returnToList(boolean success);

        void showReferenceSave(String message);

        void clearErrors();

        void showNameError();

        void showPhoneError();

        void showEmailError();

        void showTimeToMeetError();

        void showReferenceDeleted();

        void showTimeToMeeting(List<CatalogItem> items);

        void showReferenceExistError();

        void showLastNameError();

    }
}
