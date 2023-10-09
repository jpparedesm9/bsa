package com.cobis.gestionasesores.domain.usecases;

import android.util.SparseIntArray;

import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.SynchronizationOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class GetPendingSyncItemCountUseCase extends UseCase<SparseIntArray, ResultData> {

    public GetPendingSyncItemCountUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final SparseIntArray parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new SynchronizationOperation().getPendingItemCount(parameter);
            }
        });
    }
}
