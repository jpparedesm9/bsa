package com.cobis.gestionasesores.presentation.groupverification;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.domain.usecases.GetGroupVerificationUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

public class GroupVerificationPresenter extends ErrorPresenter implements GroupVerificationContract.Presenter {

    private GroupVerificationContract.View mView;
    private GetGroupVerificationUseCase mGetGroupVerificationUseCase;

    private int mVerificationId;
    private String mVerificationType;

    public GroupVerificationPresenter(GroupVerificationContract.View view, int verificationId, GetGroupVerificationUseCase getGroupVerificationUseCase, String verificationType) {
        super(view);
        mView = view;
        mVerificationId = verificationId;
        mGetGroupVerificationUseCase = getGroupVerificationUseCase;
        mVerificationType = verificationType;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.showTitle(mVerificationType);

        loadVerification();
    }

    private void loadVerification() {
        mView.showLoadProgress();
        mGetGroupVerificationUseCase.execute(mVerificationId, new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@NonNull ResultData resultData) {
                Verification verification = (Verification) resultData.getData();
                if (verification != null) {
                    if (verification.getType().equals(TaskType.GROUP_VERIFICATION)) {
                        mView.showGroupName(verification.getName());
                    } else {
                        mView.showGroupName(null);
                    }
                    if (verification.getMemberVerifications() != null) {
                        mView.showMemberVerifications(verification.getMemberVerifications());
                    }
                    if (verification.getStatus() == SyncStatus.SYNCED) {
                        mView.showMessageValidatedSuccess();
                    }
                }

                //Error in complete service
                if (resultData.getType() == ResultType.FAILURE) {
                    mView.showErrorValidate(resultData.getErrorMessage());
                }
                checkError(verification);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.hideProgress();
                mView.showLoadError();
                Log.e("GroupVerificationPresenter: loadVerification error! ", e);
            }

            @Override
            public void onComplete() {
                mView.hideProgress();
            }
        });
    }

    @Override
    public void onMemberVerificationResult() {
        loadVerification();
    }

    @Override
    public void onMemberVerificationSelected(MemberVerification member) {
        mView.startMemberVerification(mVerificationId, member);
    }
}
