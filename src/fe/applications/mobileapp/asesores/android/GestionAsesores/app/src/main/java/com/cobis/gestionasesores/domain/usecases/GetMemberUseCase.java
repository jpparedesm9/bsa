package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 10/3/2017.
 */

public class GetMemberUseCase extends UseCase<GetMemberUseCase.GetMemberRequest, Member> {

    private GroupDataSource mGroupDataSource;

    public GetMemberUseCase(GroupDataSource groupDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mGroupDataSource = groupDataSource;
    }

    @Override
    protected Observable<Member> createObservableUseCase(final GetMemberRequest parameter) {
        return Observable.fromCallable(new Callable<Member>() {
            @Override
            public Member call() throws Exception {
                return mGroupDataSource.getMember(parameter.localGroupId, parameter.serverMemberId);
            }
        });
    }

    public static class GetMemberRequest {
        int localGroupId;
        int serverMemberId;

        public GetMemberRequest(int localGroupId, int serverMemberId) {
            this.localGroupId = localGroupId;
            this.serverMemberId = serverMemberId;
        }
    }
}
