package com.cobis.gestionasesores.presentation.error;

import com.cobis.gestionasesores.data.models.ServerAction;
import com.cobis.gestionasesores.data.models.Synchronizable;

public class ErrorBaseContract {

    public interface ErrorBaseView {

        void showSyncError(String message);

        void hideSyncError();

        void showAction(ServerAction action);

        void setErrorPresenter(ErrorBasePresenter presenter);

        void enableInfo();
    }

    public interface ErrorBasePresenter {
        void checkError(Synchronizable data);

        void onClickInfo();
    }
}
