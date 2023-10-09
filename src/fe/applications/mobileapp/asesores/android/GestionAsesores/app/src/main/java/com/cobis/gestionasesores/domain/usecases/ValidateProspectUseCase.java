package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.PersonOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class ValidateProspectUseCase extends UseCase<Integer, ResultData> {

    public ValidateProspectUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Integer parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new PersonOperation().validatePerson(parameter);
            }
        });
    }
}
