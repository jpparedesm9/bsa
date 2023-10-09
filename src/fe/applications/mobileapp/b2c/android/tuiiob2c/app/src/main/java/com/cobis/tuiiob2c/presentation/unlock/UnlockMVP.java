package com.cobis.tuiiob2c.presentation.unlock;

import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Question;
import com.cobis.tuiiob2c.data.models.responses.QuestionResponse;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import java.util.List;

import io.reactivex.Observable;

public interface UnlockMVP {

    interface UnlockModel {

        Observable<QuestionResponse> getQuestions();

        Observable<BaseModel> unlock(List<Answer> answerList);
    }

    interface UnlockView extends BaseView {

        void setQuestions(List<Question> questions);

        void showUnlockSuccess();

        void showUnlockResponseError(String message);
    }

    interface UnlockPresenter extends BasePresenter {

        void setView(UnlockMVP.UnlockView unlockView);

        void onClickAnswerQuestions(List<Answer> answerList);
    }
}
