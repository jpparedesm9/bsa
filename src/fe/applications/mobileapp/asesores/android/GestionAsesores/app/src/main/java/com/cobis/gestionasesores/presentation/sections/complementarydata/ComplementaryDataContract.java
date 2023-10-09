package com.cobis.gestionasesores.presentation.sections.complementarydata;

import com.cobis.gestionasesores.data.models.ComplementaryData;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

public interface ComplementaryDataContract {

    interface ComplementaryDataView extends SectionViewBase, BaseView<ComplementaryDataPresenter> {
        void setComplementaryData(ComplementaryData complementaryData);

        void clearErrors();

        void showHasBureauAntecedentsError();

        void showTelephoneError();
    }

    interface ComplementaryDataPresenter extends BasePresenter {
        void onClickFinish(ComplementaryData complementaryData);
    }
}
