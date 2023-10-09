package com.cobis.gestionasesores.presentation.comments;

import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.TraceReport;
import com.cobis.gestionasesores.domain.usecases.SendCommentaryUserCase;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

import static com.bayteq.libcore.LibCore.getApplicationContext;

public class CommentsPresenter implements CommentsContract.Presenter {

    private CommentsContract.View mView;
    private SendCommentaryUserCase mUseCase;

    public CommentsPresenter (CommentsContract.View view, SendCommentaryUserCase userCase){
        mView = view;
        mUseCase = userCase;
        mView.setPresenter(this);
    }

    public void start() {

    }

    @Override
    public void sendCommentaries(String commentaries) {
        mView.clearAllErrors();
        if (!commentaries.equals("")){
            mView.showLoading();
            TraceReport traceReport = new TraceReport();
            traceReport.setSubject(getApplicationContext().getResources().getString(R.string.comments_subject,String.valueOf(System.currentTimeMillis())));
            traceReport.setAccount(getApplicationContext().getResources().getString(R.string.comments_sender_account));
            traceReport.setAccountPassword(getApplicationContext().getResources().getString(R.string.comments_sender_password));
            traceReport.setFrom(BuildConfig.COMMENTS_FROM);
            traceReport.setTo(BuildConfig.COMMENTS_TO);
            traceReport.addItemData(TraceReport.TraceData.COMMENT,commentaries);

            mUseCase.execute(traceReport, new DisposableObserver<Boolean>() {
                @Override
                public void onNext(@NonNull Boolean aBoolean) {
                    mView.hideLoading();
                    if (aBoolean){
                        mView.showSendComplete();
                        mView.clearScreen();
                    }
                    else{
                        mView.showSendError();
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {

                }

                @Override
                public void onComplete() {

                }
            });
        }
        else {
            mView.showInputCommentariesError();
        }

    }

}