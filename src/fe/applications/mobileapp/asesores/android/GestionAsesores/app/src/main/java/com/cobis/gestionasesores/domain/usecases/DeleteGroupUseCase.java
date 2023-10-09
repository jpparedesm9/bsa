package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 8/25/2017.
 */

public class DeleteGroupUseCase extends UseCase<Integer, ResultData> {


    private GroupDataSource mGroupDataSource;

    public DeleteGroupUseCase(GroupDataSource groupDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mGroupDataSource = groupDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Integer parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return mGroupDataSource.delete(parameter);
            }
        });
    }
}
