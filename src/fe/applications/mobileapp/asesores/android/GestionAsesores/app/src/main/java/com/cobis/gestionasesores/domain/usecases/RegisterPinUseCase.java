package com.cobis.gestionasesores.domain.usecases;

import com.bayteq.libcore.util.SecurityUtils;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.infrastructure.SessionManager;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by jescudero on 22/08/2017.
 */

public class RegisterPinUseCase extends UseCase<RegisterPinUseCase.Params, ResultData> {

    public RegisterPinUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final RegisterPinUseCase.Params parameters) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                SessionManager sessionManager = SessionManager.getInstance();
                sessionManager.registerPin(parameters.user, SecurityUtils.encodeWithSHA256(parameters.pin));
                return new ResultData(ResultType.SUCCESS, null);
            }
        });
    }

    public static class Params{
        private String user;
        private String pin;

        public Params(String user, String pin) {
            this.user = user;
            this.pin = pin;
        }
    }
}
