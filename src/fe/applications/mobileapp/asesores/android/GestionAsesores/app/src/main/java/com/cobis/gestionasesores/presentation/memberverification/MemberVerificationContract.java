package com.cobis.gestionasesores.presentation.memberverification;

import android.location.Location;

import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;
import com.cobis.gestionasesores.widgets.GeoReferenceDialog;

import java.util.List;

public interface MemberVerificationContract {

    interface Presenter extends BasePresenter {
        void onSave(List<Question> questions);

        void onSaveDraft(List<Question> questions, boolean exit);

        void onChangeQuestion(Question question, String newValue, String oldValue);

        void onTryToExit();

        void onGpsMapDialogClick(Question question);

        void activateQuestion(Question question);

        void updateQuestionGeoreference(Question question, Location markLocation, Location officialLocation);

        void setGpsToQuestion(Question question);
    }

    interface View extends BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {

        void showName(String name);

        void showQuestions(List<Question> questions);

        void showSaveProgress();

        void hideSaveProgress();

        void showSaveError(String error);

        void showConfirmSaveChanges();

        void showNetworkError();

        void showSaveSuccess(String message, boolean exit);

        void showQuestionError(String code);

        void clearErrors();

        void sendResult();

        void exit();

        void viewQuestion(String code);

        void updateQuestion(Question question);

        void requestGeoReference(GeoReferenceDialog.GeoReferenceListener listener);

        void hideActions(boolean isEnabled);

        void showGpsMapDialog(Question question, GeoReference homeAddressGeoReference);

        void showGeoLocationError();

        void activateQuestion(Question question);

        void activateGpsQuestions();

        void showGpsIsTooFar(Location Userlocation, Location questionLocation);
    }
}