package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.GroupOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 10/2/2017.
 */

public class RemoveRelationshipUseCase extends UseCase<RemoveRelationshipUseCase.RemoveRelationRequest, ResultData> {


    public RemoveRelationshipUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final RemoveRelationRequest parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return new GroupOperation().removeMemberRelation(parameter.groupId, parameter.currentMember, parameter.memberToRemoveId);
            }
        });
    }

    public static class RemoveRelationRequest {
        private int groupId;
        private Member currentMember;
        private int memberToRemoveId;

        public RemoveRelationRequest(int groupId, Member currentMember, int memberToRemoveId) {
            this.groupId = groupId;
            this.currentMember = currentMember;
            this.memberToRemoveId = memberToRemoveId;
        }
    }
}
