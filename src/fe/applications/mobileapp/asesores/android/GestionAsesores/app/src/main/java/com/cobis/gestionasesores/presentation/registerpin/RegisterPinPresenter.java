package com.cobis.gestionasesores.presentation.registerpin;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.usecases.RegisterPinUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

/**
 * Created by jescudero on 22/08/2017.
 */

public class RegisterPinPresenter implements RegisterPinContract.RegisterPinPresenter {

    RegisterPinContract.RegisterPinView mView;
    private String pin;
    private RegisterPinUseCase mRegisterPinUseCase;
    public RegisterPinPresenter(RegisterPinContract.RegisterPinView view, RegisterPinUseCase registerPinUseCase) {
        mView = view;
        mRegisterPinUseCase = registerPinUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {

    }

    @Override
    public void registerPin(String pin) {
        if(this.pin == null){
            this.pin = pin;
            mView.promptPinConfirm();

        } else if (this.pin.equals(pin)){
            String user = SessionManager.getInstance().getLastUserLogin();
            mRegisterPinUseCase.execute(new RegisterPinUseCase.Params(user, pin), new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData resultData) {
                    if(resultData.getType() == ResultType.SUCCESS) {
                        mView.navigateToMenu(resultData.getErrorMessage());
                    } else {
                        mView.showError(resultData.getErrorMessage());
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    mView.showError(null);
                }

                @Override
                public void onComplete() {

                }
            });
        } else{
            mView.showError(null);
        }

    }
}
