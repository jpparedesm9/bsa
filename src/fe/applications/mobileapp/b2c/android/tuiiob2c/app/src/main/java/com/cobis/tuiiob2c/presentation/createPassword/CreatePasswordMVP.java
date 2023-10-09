package com.cobis.tuiiob2c.presentation.createPassword;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface CreatePasswordMVP {

    interface CreatePasswordModel {

        Observable<BaseModel> validateCreatePassword(String password);
    }

    interface CreatePasswordView extends BaseView {

        void showCreatePasswordSuccess();

        void showCreatePasswordError(String message);
    }

    interface CreatePasswordPresenter extends BasePresenter {

        void setView(CreatePasswordMVP.CreatePasswordView createPasswordView);

        void onClickValidateCreatePassword(String password, String repeatPassword);
    }
}
