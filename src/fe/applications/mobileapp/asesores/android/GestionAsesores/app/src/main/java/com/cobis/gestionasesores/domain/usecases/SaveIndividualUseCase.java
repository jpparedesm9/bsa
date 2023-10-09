package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.CreditAppOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class SaveIndividualUseCase extends UseCase<SaveIndividualUseCase.Params, ResultData> {


    public SaveIndividualUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new CreditAppOperation().saveIndividualCredit(parameter.creditApp,parameter.isConfirmation,parameter.tryRemote);
            }
        });
    }

    public static class Params {
        private IndividualCreditApp creditApp;
        private boolean tryRemote;
        private boolean isConfirmation;

        public Params(IndividualCreditApp creditApp,boolean isConfirmation,boolean tryRemote) {
            this.creditApp = creditApp;
            this.tryRemote = tryRemote;
            this.isConfirmation = isConfirmation;
        }
    }
}
