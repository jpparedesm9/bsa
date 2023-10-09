package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.source.TaskDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class GetSolidarityPaymentUseCase extends UseCase<Integer, SolidarityPayment> {

    private TaskDataSource taskDataSource;

    public GetSolidarityPaymentUseCase(TaskDataSource taskDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        this.taskDataSource = taskDataSource;
    }

    @Override
    protected Observable<SolidarityPayment> createObservableUseCase(final Integer localId) {
        return Observable.fromCallable(new Callable<SolidarityPayment>() {
            @Override
            public SolidarityPayment call() throws Exception {
                return (SolidarityPayment) taskDataSource.get(localId);
            }
        });
    }
}
