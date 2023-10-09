package com.cobis.gestionasesores.presentation.sections;

import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

public interface SectionViewBase extends ErrorBaseContract.ErrorBaseView {
    void sendResult(boolean isSuccess, int personId);

    void showSaveProgress();

    void showSaveError(String message);

    void showNetworkError();

    void showFinishedMessage(boolean isSuccess, int personId, String message);

    void hideProgress();

    void showLoadSectionProgress();
}
