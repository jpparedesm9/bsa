package com.cobis.gestionasesores.presentation.sections.references;

import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

import java.util.List;

/**
 * Created by mnaunay on 09/06/2017.
 */

public class ReferenceListContract {
    public interface Presenter extends BasePresenter {
        void loadReferences();

        void updateReferences();

        void onAddNewReference();

        void onEditReference(Reference reference);

        void onTryToExit();
    }

    public interface View extends SectionViewBase, BaseView<Presenter> {
        void showReferences(List<Reference> references);

        void startReference(int personId, Reference reference, List<Reference> referenceList);

        void sendResult(Section section);

        void showCaption(int maxReferences);

        void showButtonAdd(boolean visible);
    }
}
