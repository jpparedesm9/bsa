package com.cobis.tuiiob2c.presentation.forgotPassword;

import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Question;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import java.util.List;

import io.reactivex.Observable;

public interface ForgotPasswordMVP {

    interface ForgotPasswordModel {

        Observable<QuestionResponse> getQuestions();

        Observable<BaseModel> answerQuestions(List<Answer> answerList);
    }

    interface ForgotPasswordView extends BaseView {

        void setQuestions(List<Question> questions);

        void showForgotPasswordSuccess();

        void showForgotPasswordError(String message);
    }

    interface ForgotPasswordPresenter extends BasePresenter {

        void setView(ForgotPasswordMVP.ForgotPasswordView forgotPasswordView);

        void onClickAnswerQuestions(List<Answer> answerList);
    }
}
