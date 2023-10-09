package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 8/3/2017.
 */

public class SaveGroupUseCase extends UseCase<Group, ResultData> {
    private GroupDataSource mGroupDataSource;

    public SaveGroupUseCase(GroupDataSource groupDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mGroupDataSource = groupDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Group parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return mGroupDataSource.save(parameter, false);
            }
        });
    }
}
