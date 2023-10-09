package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.source.CreditAppDataSource;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.functions.Function;
import io.reactivex.schedulers.Schedulers;

public class GetGroupCreditApp extends UseCase<Integer,CreditApp> {

    private CreditAppDataSource mCreditAppDataSource;

    public GetGroupCreditApp(CreditAppDataSource creditAppDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mCreditAppDataSource = creditAppDataSource;
    }

    @Override
    protected Observable<CreditApp> createObservableUseCase(Integer parameter) {
        return Observable.just(parameter)
                .map(new Function<Integer, CreditApp>() {
                    @Override
                    public CreditApp apply(Integer applicationId) throws Exception {
                        return mCreditAppDataSource.get(applicationId);
                    }
                });
    }
}
