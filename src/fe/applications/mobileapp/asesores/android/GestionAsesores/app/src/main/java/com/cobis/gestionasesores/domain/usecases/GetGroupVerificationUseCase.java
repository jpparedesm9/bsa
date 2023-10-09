package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.VerificationOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class GetGroupVerificationUseCase extends UseCase<Integer, ResultData> {

    public GetGroupVerificationUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Integer parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new VerificationOperation().validateVerification(parameter, false);
            }
        });
    }
}
