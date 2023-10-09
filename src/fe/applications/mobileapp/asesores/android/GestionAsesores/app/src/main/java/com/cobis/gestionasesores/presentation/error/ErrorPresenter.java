package com.cobis.gestionasesores.presentation.error;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.models.ServerAction;
import com.cobis.gestionasesores.data.models.Synchronizable;

public class ErrorPresenter implements ErrorBaseContract.ErrorBasePresenter {

    protected ErrorBaseContract.ErrorBaseView mView;

    private ServerAction mAction;

    public ErrorPresenter(ErrorBaseContract.ErrorBaseView mView) {
        this.mView = mView;

        mView.setErrorPresenter(this);
    }

    @Override
    public void checkError(Synchronizable data) {
        if (data != null && data.getErrorMsg() != null && StringUtils.isNotEmpty(data.getErrorMsg().getMessage())) {
            mView.showSyncError(data.getErrorMsg().getMessage());
        } else {
            mView.hideSyncError();
        }

        if(data != null && data.getAction() != null){
            mView.enableInfo();
            mAction = data.getAction();
            mView.showAction(mAction);
        }
    }

    @Override
    public void onClickInfo() {
        if(mAction != null) {
            mView.showAction(mAction);
        }
    }
}
