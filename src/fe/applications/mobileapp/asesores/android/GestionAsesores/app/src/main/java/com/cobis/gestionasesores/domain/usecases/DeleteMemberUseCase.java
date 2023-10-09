package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.GroupOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 8/9/2017.
 */

public class DeleteMemberUseCase extends UseCase<DeleteMemberUseCase.DeleteMemberRequest,ResultData> {


    public DeleteMemberUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final DeleteMemberRequest parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new GroupOperation().deleteMember(parameter.groupId,parameter.member);
            }
        });
    }

    public static class DeleteMemberRequest{
        int groupId;
        Member member;

        public DeleteMemberRequest(int groupId, Member member) {
            this.groupId = groupId;
            this.member = member;
        }
    }
}
