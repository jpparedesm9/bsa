package com.cobis.tuiiob2c.presentation.resetPassword;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface ResetPasswordMVP {
    interface ResetPasswordModel {

        Observable<BaseModel> validateResetPassword(String password);
    }

    interface ResetPasswordView extends BaseView {

        void showResetPasswordSuccess();

        void showResetPasswordError(String message);
    }

    interface ResetPasswordPresenter extends BasePresenter {

        void setView(ResetPasswordMVP.ResetPasswordView resetPasswordView);

        void onClickValidateResetPassword(String password, String repeatPassword);
    }
}
