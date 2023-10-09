package com.cobis.gestionasesores.presentation.solidaritypayment;

import com.cobis.gestionasesores.data.models.ServerAction;
import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import org.junit.Test;

import java.util.Arrays;

import static org.junit.Assert.assertTrue;

/**
 * Created by bqtdesa02 on 8/25/2017.
 */
public class SolidarityPaymentPresenterTest {
    @Test
    public void validateSolidarityPayment() throws Exception {
        SolidarityPaymentPresenter presenter = new SolidarityPaymentPresenter(mView, 0, null, null);

        SolidarityPayment solidarityPayment = new SolidarityPayment();
        solidarityPayment.setPaymentDue(26827.83);
        solidarityPayment.setMembers(
                Arrays.asList(
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.48),
                        new SolidarityMember(3353.47)));

        double calculated = solidarityPayment.getPaymentDue() / solidarityPayment.getMembers().size();

        System.out.println("Calculated: " + calculated);

        boolean isValidated = presenter.validateSolidarityPayment(solidarityPayment);
        assertTrue(isValidated);
    }

    private SolidarityPaymentContract.View mView = new SolidarityPaymentContract.View() {
        @Override
        public void setSolidarityPayment(SolidarityPayment payment) {

        }

        @Override
        public void showSaveProgress() {

        }

        @Override
        public void hideSaveProgress() {

        }

        @Override
        public void showNetworkError() {

        }

        @Override
        public void showSaveError(String error) {

        }

        @Override
        public void showSaveSuccess() {

        }

        @Override
        public void exit() {

        }

        @Override
        public void clearErrors() {

        }

        @Override
        public void showPaymentPrompt(SolidarityMember member, double suggestedAmount) {

        }

        @Override
        public void updateSolidarityMember(SolidarityMember member) {

        }

        @Override
        public void startMoreInformation(SolidarityPayment payment) {

        }

        @Override
        public void updateCoveredAmount(double coveredAmount) {

        }

        @Override
        public void showCoveredAmountError() {

        }

        @Override
        public void readOnly() {

        }

        @Override
        public void setPresenter(SolidarityPaymentContract.Presenter presenter) {

        }

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
    };
}