package com.cobis.tuiiob2c.usecases;

import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.AnswerRequest;
import com.cobis.tuiiob2c.data.models.requests.QuestionRequest;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.forgotPassword.ForgotPasswordMVP;
import com.cobis.tuiiob2c.usecases.source.ForgotPasswordSource;

import java.util.List;

import io.reactivex.Observable;

public class ForgotPasswordUseCase implements ForgotPasswordMVP.ForgotPasswordModel {

    private ForgotPasswordSource forgotPasswordSource;

    public ForgotPasswordUseCase(ForgotPasswordSource forgotPasswordSource) {
        this.forgotPasswordSource = forgotPasswordSource;
    }

    @Override
    public Observable<QuestionResponse> getQuestions() {
        return Observable.fromCallable(() -> {
            String idClient = SessionManager.getInstance().getValuesEnrollment().getIdCliente();

            return forgotPasswordSource.getQuestions(new QuestionRequest(idClient));
        });
    }

    @Override
    public Observable<BaseModel> answerQuestions(List<Answer> answerList) {
        return Observable.fromCallable(() -> forgotPasswordSource.answerQuestions(new AnswerRequest(answerList)));
    }
}
