package com.cobis.gestionasesores.presentation.comments;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

public interface CommentsContract {
    interface Presenter extends BasePresenter {
        void sendCommentaries (String commentaries);
    }

    interface View extends BaseView<Presenter> {
        void showSendComplete();
        void showSendError();
        void showInputCommentariesError();
        void clearAllErrors();
        void showLoading();
        void hideLoading();
        void clearScreen();
    }

}