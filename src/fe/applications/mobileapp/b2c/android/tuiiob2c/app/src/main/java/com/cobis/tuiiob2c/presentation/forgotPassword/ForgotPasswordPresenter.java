package com.cobis.tuiiob2c.presentation.forgotPassword;

import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;

import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class ForgotPasswordPresenter implements ForgotPasswordMVP.ForgotPasswordPresenter {

    private ForgotPasswordMVP.ForgotPasswordView forgotPasswordView;
    private ForgotPasswordMVP.ForgotPasswordModel forgotPasswordModel;

    private Disposable disposable;

    public ForgotPasswordPresenter(ForgotPasswordMVP.ForgotPasswordModel forgotPasswordModel) {
        this.forgotPasswordModel = forgotPasswordModel;
    }

    @Override
    public void setView(ForgotPasswordMVP.ForgotPasswordView forgotPasswordView) {
        this.forgotPasswordView = forgotPasswordView;
    }

    @Override
    public void onClickAnswerQuestions(List<Answer> answerList) {
        forgotPasswordView.showLoading();
        disposable = forgotPasswordModel.answerQuestions(answerList)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<BaseModel>() {
                    @Override
                    public void onNext(BaseModel baseModel) {
                        if (baseModel.isResult()) {
                            forgotPasswordView.showForgotPasswordSuccess();
                        } else {
                            forgotPasswordView.showForgotPasswordError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        forgotPasswordView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        forgotPasswordView.hideLoading();
                    }
                });
    }

    @Override
    public void start() {
        forgotPasswordView.showLoading();
        disposable = forgotPasswordModel.getQuestions()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<QuestionResponse>() {
                    @Override
                    public void onNext(QuestionResponse questionResponse) {
                        forgotPasswordView.setQuestions(questionResponse.getData());
                    }

                    @Override
                    public void onError(Throwable e) {
                        forgotPasswordView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        forgotPasswordView.hideLoading();
                    }
                });
    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }
}
