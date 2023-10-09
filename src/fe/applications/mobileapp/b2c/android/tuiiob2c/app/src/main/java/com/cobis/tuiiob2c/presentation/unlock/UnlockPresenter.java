package com.cobis.tuiiob2c.presentation.unlock;

import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;

import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class UnlockPresenter implements UnlockMVP.UnlockPresenter {

    private UnlockMVP.UnlockView unlockView;
    private UnlockMVP.UnlockModel unlockModel;

    private Disposable disposable;

    public UnlockPresenter(UnlockMVP.UnlockModel unlockModel) {
        this.unlockModel = unlockModel;
    }

    @Override
    public void setView(UnlockMVP.UnlockView settingsView) {
        this.unlockView = settingsView;
    }

    @Override
    public void start() {
        unlockView.showLoading();
        disposable = unlockModel.getQuestions()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<QuestionResponse>() {
                    @Override
                    public void onNext(QuestionResponse questionResponse) {
                        unlockView.setQuestions(questionResponse.getData());
                    }

                    @Override
                    public void onError(Throwable e) {
                        unlockView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        unlockView.hideLoading();
                    }
                });
    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }

    @Override
    public void onClickAnswerQuestions(List<Answer> answerList) {
        unlockView.showLoading();
        disposable = unlockModel.unlock(answerList)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<BaseModel>() {
                    @Override
                    public void onNext(BaseModel baseModel) {
                        if (baseModel.isResult()) {
                            unlockView.showUnlockSuccess();
                        } else {
                            unlockView.showUnlockResponseError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        unlockView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        unlockView.hideLoading();
                    }
                });
    }
}
