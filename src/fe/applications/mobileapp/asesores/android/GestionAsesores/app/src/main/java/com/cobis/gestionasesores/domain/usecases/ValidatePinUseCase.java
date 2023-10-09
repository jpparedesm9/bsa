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
 * Created by jescudero on 31/08/2017.
 */

public class ValidatePinUseCase extends UseCase<ValidatePinUseCase.Params, ResultData> {


    public ValidatePinUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                boolean pinValid = SessionManager.getInstance().validatePIN(parameter.user, SecurityUtils.encodeWithSHA256(parameter.pin));
                return new ResultData(pinValid ? ResultType.SUCCESS : ResultType.FAILURE, null);
            }
        });
    }

    public static class Params {
        private String user;
        private String pin;

        public Params(String user, String pin) {
            this.user = user;
            this.pin = pin;
        }
    }
}
