package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.RegisterDeviceDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by jescudero on 8/19/2017.
 */

public class RegisterDeviceUseCase extends UseCase<RegisterDeviceUseCase.Params, ResultData> {

    private RegisterDeviceDataSource mRegisterDeviceDataSource;

    public RegisterDeviceUseCase(RegisterDeviceDataSource registerDeviceDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mRegisterDeviceDataSource = registerDeviceDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final RegisterDeviceUseCase.Params parameter) {
       return Observable.fromCallable(new Callable<ResultData>() {
           @Override
           public ResultData call() throws Exception {
               return mRegisterDeviceDataSource.registerDevice(parameter.alias, parameter.description);
           }
       });
    }

    public static class Params {
        String alias;
        String description;

        public Params(String alias, String description) {
            this.alias = alias;
            this.description = description;
        }
    }
}
