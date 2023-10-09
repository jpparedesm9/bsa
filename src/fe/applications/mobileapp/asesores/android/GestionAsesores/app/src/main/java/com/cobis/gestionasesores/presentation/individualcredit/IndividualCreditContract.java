package com.cobis.gestionasesores.presentation.individualcredit;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Guarantor;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.responses.Message;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import java.util.List;

public interface IndividualCreditContract {
    interface Presenter extends BasePresenter {
        void onClickSave(IndividualCreditApp creditApp);

        void onClickDelete();

        void onConfirmDelete();

        void onClickSelectGuarantor();

        void onGuarantorSelected(Person guarantor);

        void onClickConfirmation();

        void onClickLocalSave();

        void onTryToExit();


    }

    interface View extends BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {

        void setIndividualCreditApp(IndividualCreditApp creditApp);

        void showCreditDestinations(List<CatalogItem> items);

        void showCreditTerms(List<CatalogItem> items);

        void showCreditFrequency(List<CatalogItem> items);

        void setFixedCreditFrequency(String code);

        void toggleApplicationDate(boolean shouldShow);

        void toggleAdviser(boolean shouldShow);

        void toggleBranchOffice(boolean shouldShow);

        void toggleRate(boolean shouldShow);

        void toggleRenew(boolean shouldShow);

        void togglePreviousCredit(boolean shouldShow);

        void drawRiskLevel(String riskLevel);

        void hideRiskLevel();

        void hideGuarantorRiskLevel();

        void showDeleteOption();

        void drawGuarantorRiskLevel(String riskLevel);

        void showConfirmDeleteDialog();

        void showUpdateSuccess();

        void showSaveSuccess(String message);

        void showSaveError();

        void showSaveError(Message message);

        void showDeleteSuccess();

        void showDeleteError();

        void exit();

        void startSelectGuarantor(int[] customersSelected);

        void setGuarantor(Guarantor guarantor);

        void showDestinationError();

        void showTermError();

        void showFrequencyError();

        void showGuarantorError();

        void showRequestAmountError();

        void clearErrors();

        void showMessageExit();

        void setReadOnly(boolean isReadOnly);

        void showSavingProgress();

        void hideProgress();

        void showNetworkError();

        void showCustomerNotSyncedError();

        void showWarningMessage(String warning);
    }
}