package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.GroupOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class SaveMemberUseCase extends UseCase<SaveMemberUseCase.SaveMemberRequest, ResultData> {

    public SaveMemberUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final SaveMemberRequest parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new GroupOperation().saveMember(parameter.groupId, parameter.member);
            }
        });
    }

    public static class SaveMemberRequest {
        int groupId;
        Member member;

        public SaveMemberRequest(int groupId, Member member) {
            this.groupId = groupId;
            this.member = member;
        }
    }
}
