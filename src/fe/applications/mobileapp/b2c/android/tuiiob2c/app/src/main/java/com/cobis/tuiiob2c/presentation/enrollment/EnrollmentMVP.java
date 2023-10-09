package com.cobis.tuiiob2c.presentation.enrollment;

import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.data.models.responses.EnrollmentResponse;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface EnrollmentMVP {

    interface EnrollmentModel {

        Observable<EnrollmentResponse> validatePinEnrollment(String pin);
    }

    interface EnrollmentView extends BaseView {

        void showErrorValidateFields();

        void showEnrollmentSuccess();

        void showEnrollmentError(String message);

        void showTermsAndConditions();

        void showVersionInfo(String versionName, String versionCode);

        void setEnvironment(Environment environment);

        void showEnvironmentSelector(boolean shouldShow);

        void restartAppForEnviroment();
    }

    interface EnrollmentPresenter extends BasePresenter {

        void setView(EnrollmentMVP.EnrollmentView enrollmentView);

        void onClickValidatePinEnrollment(String pin);

        void onClickTermsAndConditions();

        void onEnvironmentSelected(Environment environment);
    }
}
