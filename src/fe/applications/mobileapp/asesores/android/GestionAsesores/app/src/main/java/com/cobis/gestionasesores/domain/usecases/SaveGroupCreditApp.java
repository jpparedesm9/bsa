package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.CreditAppDataSource;
import com.cobis.gestionasesores.domain.businesslogic.CreditAppOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class SaveGroupCreditApp extends UseCase<SaveGroupCreditApp.Params, ResultData> {
    private CreditAppDataSource mCreditAppDataSource;

    public SaveGroupCreditApp(CreditAppDataSource creditAppDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mCreditAppDataSource = creditAppDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final SaveGroupCreditApp.Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new CreditAppOperation().saveGroupCredit(parameter.groupCreditApp,parameter.isConfirmation,parameter.tryRemote);
            }
        });
    }

    public static class Params {
        private GroupCreditApp groupCreditApp;
        private boolean tryRemote;
        private boolean isConfirmation;

        public Params(GroupCreditApp groupCreditApp, boolean isConfirmation,boolean tryRemote) {
            this.groupCreditApp = groupCreditApp;
            this.tryRemote = tryRemote;
            this.isConfirmation = isConfirmation;
        }
    }
}