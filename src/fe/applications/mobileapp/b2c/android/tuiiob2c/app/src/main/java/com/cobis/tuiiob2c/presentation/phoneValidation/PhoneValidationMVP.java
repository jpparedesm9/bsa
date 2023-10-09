package com.cobis.tuiiob2c.presentation.phoneValidation;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface PhoneValidationMVP {

    interface PhoneValidationModel {

        Observable<BaseModel> changePhone(String phone);
    }

    interface PhoneValidationView extends BaseView {

        void showErrorValidateFields();

        void showPhoneValidationSuccess();

        void showPhoneValidationError(String message);

        void getEnrollmentData();

        void showValidationScreen();
    }

    interface PhoneValidationPresenter extends BasePresenter {

        void setView(PhoneValidationMVP.PhoneValidationView phoneValidationView);

        void onClickPhoneValidation(String phone);
    }
}
