package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.source.TaskDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class SaveSolidarityPaymentUseCase extends UseCase<SolidarityPayment, ResultData> {
    private TaskDataSource mDataSource;

    public SaveSolidarityPaymentUseCase(TaskDataSource dataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mDataSource = dataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final SolidarityPayment parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return mDataSource.saveSolidarityPayment(parameter, false);
            }
        });
    }
}
