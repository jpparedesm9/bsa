package com.cobis.gestionasesores.presentation.registerdevice;

import android.os.Build;
import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.DeviceUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.usecases.RegisterDeviceUseCase;
import com.cobis.gestionasesores.utils.Util;

import io.reactivex.observers.DisposableObserver;

/**
 * Created by jescudero on 8/19/2017.
 */

public class RegisterDevicePresenter implements RegisterDeviceContract.RegisterDevicePresenter {

    private RegisterDeviceContract.RegisterDeviceView mView;
    private RegisterDeviceUseCase mRegisterDeviceUseCase;

    public RegisterDevicePresenter(RegisterDeviceContract.RegisterDeviceView view, RegisterDeviceUseCase registerDeviceUseCase) {
        mView = view;
        mView.setPresenter(this);
        mRegisterDeviceUseCase = registerDeviceUseCase;
    }

    @Override
    public void start() {
    }

    @Override
    public void registerDevice(@NonNull String alias) {
        mView.clearError();
        if(validate(alias)) {
            mView.showLoading();
            String description = DeviceUtils.getDeviceName() + " (Android " + Build.VERSION.RELEASE + ")";
            mRegisterDeviceUseCase.execute(new RegisterDeviceUseCase.Params(alias, description), new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData result) {
                    mView.hideLoading();
                    if (result.getType() == ResultType.SUCCESS) {
                        mView.navigateToRegisterPin(result.getErrorMessage());
                    } else {
                        mView.showError(result.getErrorMessage());
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    Log.d("LinkUser error =>  " + e.toString());
                    mView.hideLoading();
                    if(Util.isNetworkError(e)){
                        mView.showNetworkError();
                    }else{
                        mView.showError(null);
                    }
                }

                @Override
                public void onComplete() {
                }
            });
        }
    }

    private boolean validate(String alias) {
        int minLength = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_LENGTH_ALIAS);
        int maxLength = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_LENGTH_ALIAS);
        if(StringUtils.isEmpty(alias) || alias.length() < minLength){
           mView.showErrorLength(minLength,maxLength);
            return false;
        }
        return true;
    }
}
