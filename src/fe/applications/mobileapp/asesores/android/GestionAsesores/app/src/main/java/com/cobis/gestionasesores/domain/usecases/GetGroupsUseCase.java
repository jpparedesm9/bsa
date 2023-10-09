package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.List;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 10/30/2017.
 */

public class GetGroupsUseCase extends UseCase<String, List<Group>> {

    private GroupDataSource mGroupDataSource;

    public GetGroupsUseCase(GroupDataSource groupDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mGroupDataSource = groupDataSource;
    }

    @Override
    protected Observable<List<Group>> createObservableUseCase(final String query) {
        return Observable.fromCallable(new Callable<List<Group>>() {
            @Override
            public List<Group> call() throws Exception {
                return mGroupDataSource.getAllGroups(SyncStatus.UNKNOWN, query);
            }
        });
    }
}
