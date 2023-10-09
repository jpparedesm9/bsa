package com.cobis.gestionasesores.presentation.memberverification;

import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.ServerAction;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;
import com.cobis.gestionasesores.widgets.GeoReferenceDialog;

import org.junit.Test;

import java.util.List;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Created by bqtdesa02 on 8/18/2017.
 */
public class MemberVerificationPresenterTest {
    @Test
    public void checkValuesChanged() throws Exception {
        MemberVerificationPresenter presenter = new MemberVerificationPresenter(mView, 0, null, null);
        assertFalse(presenter.valuesChanged(null, null));
        assertTrue(presenter.valuesChanged("V", null));
        assertFalse(presenter.valuesChanged("V", "V"));
        assertTrue(presenter.valuesChanged("V1", "V2"));
        assertTrue(presenter.valuesChanged(null, "V"));
    }

    private MemberVerificationContract.View mView = new MemberVerificationContract.View() {
        @Override
        public void showSyncError(String message) {

        }

        @Override
        public void hideSyncError() {

        }

        @Override
        public void showAction(ServerAction action) {

        }

        @Override
        public void setErrorPresenter(ErrorBaseContract.ErrorBasePresenter presenter) {

        }

        @Override
        public void enableInfo() {

        }

        @Override
        public void showName(String name) {

        }

        @Override
        public void showQuestions(List<Question> questions) {

        }

        @Override
        public void showSaveProgress() {

        }

        @Override
        public void hideSaveProgress() {

        }

        @Override
        public void showSaveError(String error) {

        }

        @Override
        public void showConfirmSaveChanges() {

        }

        @Override
        public void showNetworkError() {

        }

        @Override
        public void showSaveSuccess() {

        }

        @Override
        public void showQuestionError(String code) {

        }

        @Override
        public void clearErrors() {

        }

        @Override
        public void sendResult() {

        }

        @Override
        public void exit() {

        }

        @Override
        public void viewQuestion(String code) {

        }

        @Override
        public void updateQuestion(Question question) {

        }

        @Override
        public void requestGeoReference(GeoReferenceDialog.GeoReferenceListener listener) {

        }

        @Override
        public void hideActions(boolean isEnabled) {

        }

        @Override
        public void setPresenter(MemberVerificationContract.Presenter presenter) {

        }
    };

}