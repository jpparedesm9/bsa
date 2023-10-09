package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.UnlockQuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.mainActivity.settings.SettingsMVP;
import com.cobis.tuiiob2c.presentation.unlock.UnlockMVP;
import com.cobis.tuiiob2c.usecases.source.LockSource;
import com.cobis.tuiiob2c.usecases.source.UnlockSource;

import java.util.List;

import io.reactivex.Observable;

public class LockUnlockUseCase implements SettingsMVP.SettingsModel, UnlockMVP.UnlockModel {

    private LockSource lockSource;
    private UnlockSource unlockSource;

    public LockUnlockUseCase(LockSource lockSource) {
        this.lockSource = lockSource;
    }

    public LockUnlockUseCase(UnlockSource unlockSource) {
        this.unlockSource = unlockSource;
    }

    @Override
    public Observable<QuestionResponse> getQuestions() {
        String idClient = SessionManager.getInstance().getValuesEnrollment().getIdCliente();
        String phone = SessionManager.getInstance().getValuesEnrollment().getTelefono();

        return Observable.fromCallable(() -> unlockSource.getQuestions(new UnlockQuestionRequest(idClient, phone)));
    }

    @Override
    public Observable<BaseModel> lock() {
        return Observable.fromCallable(() -> lockSource.lock());
    }

    @Override
    public Observable<BaseModel> unlock(List<Answer> answerList) {
        return Observable.fromCallable(() -> unlockSource.unlock(new AnswerRequest(answerList)));
    }
}
