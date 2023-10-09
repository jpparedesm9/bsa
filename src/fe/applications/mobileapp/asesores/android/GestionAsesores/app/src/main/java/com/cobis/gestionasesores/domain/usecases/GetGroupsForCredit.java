package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.List;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 10/24/2017.
 */

public class GetGroupsForCredit extends UseCase<GetGroupsForCredit.GetGroupsForCreditRequest, List<Group>> {

    private GroupDataSource mGroupDataSource;

    public GetGroupsForCredit(GroupDataSource groupDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mGroupDataSource = groupDataSource;
    }

    @Override
    protected Observable<List<Group>> createObservableUseCase(final GetGroupsForCreditRequest request) {
        return Observable.fromCallable(new Callable<List<Group>>() {
            @Override
            public List<Group> call() throws Exception {
                return mGroupDataSource.getForCreditApp(request.mQuery, request.mGroups);
            }
        });
    }

    public static class GetGroupsForCreditRequest {
        private String mQuery;
        private List<Group> mGroups;

        public GetGroupsForCreditRequest(String query, List<Group> groups) {
            mQuery = query;
            mGroups = groups;
        }
    }
}
