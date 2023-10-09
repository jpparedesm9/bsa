package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.TaskDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class SaveMemberVerificationUseCase extends UseCase<SaveMemberVerificationUseCase.Params, ResultData> {
    private TaskDataSource mTaskDataSource;

    public SaveMemberVerificationUseCase(TaskDataSource dataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mTaskDataSource = dataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final SaveMemberVerificationUseCase.Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return mTaskDataSource.saveMemberVerification(parameter.verificationId, parameter.memberVerification, parameter.tryOnline, false);
            }
        });
    }

    public static class Params {
        private int verificationId;
        private MemberVerification memberVerification;
        private boolean tryOnline;

        public Params(int verificationId, MemberVerification memberVerification, boolean tryOnline) {
            this.verificationId = verificationId;
            this.memberVerification = memberVerification;
            this.tryOnline = tryOnline;
        }
    }
}