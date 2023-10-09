package com.cobis.tuiiob2c.presentation.changePassword;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface ChangePasswordMVP {

    interface ChangePasswordModel {

        Observable<BaseModel> validateChangePassword(String oldPAssword, String newPassword);
    }

    interface ChangePasswordView extends BaseView {

        void showChangePasswordSuccess();

        void showChangePasswordError(String message);
    }

    interface ChangePasswordPresenter extends BasePresenter {

        void setView(ChangePasswordMVP.ChangePasswordView createPasswordView);

        void onClickValidateCreatePassword(String oldPassword, String password, String repeatPassword);
    }
}
