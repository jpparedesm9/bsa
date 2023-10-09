package com.cobis.gestionasesores.presentation.changepin;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.usecases.RegisterPinUseCase;
import com.cobis.gestionasesores.domain.usecases.ValidatePinUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;

import io.reactivex.observers.DisposableObserver;

/**
 * Created by jescudero on 31/08/2017.
 */

public class ChangePinPresenter implements ChangePinContract.Presenter {

    private ChangePinContract.View mView;
    private ValidatePinUseCase mValidatePinUseCase;
    private RegisterPinUseCase mRegisterPinUseCase;
    private boolean isValidated;
    private String newPin;

    public ChangePinPresenter(ChangePinContract.View mView, ValidatePinUseCase validatePinUseCase, RegisterPinUseCase registerPinUseCase) {
        this.mView = mView;
        this.mValidatePinUseCase = validatePinUseCase;
        this.mRegisterPinUseCase = registerPinUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {

    }

    @Override
    public void handlePin(String pin) {
        if(isValidated && newPin != null){
            if(pin.equals(newPin)){
                registerPin(pin);
            }
            else{
                mView.showError(null);
            }
        }
        else if(isValidated){
            newPin = pin;
            mView.requestPinConfirm();
        }
        else{
            validatePin(pin);
        }
    }

    private void validatePin(String pin) {
        mView.showLoading();
        String userName = SessionManager.getInstance().getLastUserLogin();
        mValidatePinUseCase.execute(new ValidatePinUseCase.Params(userName, pin), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(ResultData resultData) {
                if(resultData.getType() == ResultType.SUCCESS){
                    isValidated = true;
                    mView.showRegisterPin();
                } else {
                    mView.showError(resultData.getErrorMessage());
                }
                mView.hideLoading();
            }

            @Override
            public void onError(Throwable e) {
                mView.hideLoading();
                mView.showError(null);
            }

            @Override
            public void onComplete() {
                mView.hideLoading();
            }
        });
    }

    private void registerPin(String pin) {
        String userName = SessionManager.getInstance().getLastUserLogin();
        mView.showLoading();
        mRegisterPinUseCase.execute(new RegisterPinUseCase.Params(userName, pin), new DisposableObserver<ResultData>() {

            @Override
            public void onNext(ResultData resultData) {
                mView.hideLoading();
                if(resultData.getType() == ResultType.SUCCESS){
                    mView.showRegisterSuccess();
                }
                else{
                    mView.showError(resultData.getErrorMessage());
                }
            }

            @Override
            public void onError(Throwable e) {
                mView.hideLoading();
                mView.showError(null);
            }

            @Override
            public void onComplete() {
                mView.hideLoading();
            }
        });
    }
}
