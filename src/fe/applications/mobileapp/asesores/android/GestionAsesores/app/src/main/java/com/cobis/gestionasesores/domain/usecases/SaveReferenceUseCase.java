package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class SaveReferenceUseCase extends UseCase<SaveReferenceUseCase.Params, ResultData> {
    private PersonDataSource mPersonDataSource;

    public SaveReferenceUseCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return mPersonDataSource.saveReference(parameter.personId, parameter.reference, false);
            }
        });
    }

    public static class Params {
        private int personId;
        private Reference reference;

        public Params(int personId, Reference reference) {
            this.personId = personId;
            this.reference = reference;
        }
    }
}
