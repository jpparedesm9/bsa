package com.cobis.tuiiob2c.presentation.enrollment;

import com.cobis.tuiiob2c.BuildConfig;
import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.data.models.responses.EnrollmentResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.root.App;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class EnrollmentPresenter implements EnrollmentMVP.EnrollmentPresenter {

    private EnrollmentMVP.EnrollmentView enrollmentView;
    private EnrollmentMVP.EnrollmentModel enrollmentModel;

    private Disposable disposable;

    public EnrollmentPresenter(EnrollmentMVP.EnrollmentModel enrollmentModel) {
        this.enrollmentModel = enrollmentModel;
    }

    @Override
    public void setView(EnrollmentMVP.EnrollmentView enrollmentView) {
        this.enrollmentView = enrollmentView;
    }

    @Override
    public void onClickValidatePinEnrollment(String pin) {
        if (validatePin(pin)) {
            enrollmentView.showLoading();
            disposable = enrollmentModel.validatePinEnrollment(pin)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<EnrollmentResponse>() {
                        @Override
                        public void onNext(EnrollmentResponse enrollmentResponse) {
                            if (enrollmentResponse.isResult()) {
                                enrollmentView.showEnrollmentSuccess();
                            } else {
                                enrollmentView.showEnrollmentError(enrollmentResponse.getFirstMessage() == null ? "" : enrollmentResponse.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            enrollmentView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            enrollmentView.hideLoading();
                        }
                    });
        } else {
            enrollmentView.showErrorValidateFields();
        }
    }

    @Override
    public void onClickTermsAndConditions() {
        enrollmentView.showTermsAndConditions();
    }

    @Override
    public void onEnvironmentSelected(Environment environment) {
        SessionManager.getInstance().saveLastEnviromentSwitch(environment);
        App.getInstance().setEnvironment(environment);
        enrollmentView.restartAppForEnviroment();
    }

    @Override
    public void start() {
        enrollmentView.showVersionInfo(BuildConfig.VERSION_NAME, String.valueOf(BuildConfig.VERSION_CODE));
        enrollmentView.showEnvironmentSelector(App.getInstance().getConfig().isEnvironmentSelectorEnabled());
        enrollmentView.setEnvironment(App.getInstance().getConfig().getEnvironment());
    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }

    private boolean validatePin(String pin) {
        return pin != null && !pin.isEmpty();
    }
}
