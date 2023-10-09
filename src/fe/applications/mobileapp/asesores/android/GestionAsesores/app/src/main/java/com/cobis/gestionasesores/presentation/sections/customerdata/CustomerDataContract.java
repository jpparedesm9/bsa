package com.cobis.gestionasesores.presentation.sections.customerdata;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;
import com.cobis.gestionasesores.widgets.BooleanQuestionView;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/5/2017.
 */

public interface CustomerDataContract {

    interface CustomerDataView extends BaseView<CustomerDataPresenter>, SectionViewBase {
        void showSex(List<CatalogItem> sex);

        void showFederalEntities(List<PostalCode> federalEntities, String selectCode);

        void showBirthCountries(List<CatalogItem> countries, String selectCode);

        void showCivilStatus(List<CatalogItem> civilStatus);

        void showNationalities(List<CatalogItem> nationalities);

        void showEducationLevels(List<CatalogItem> educationLevels);

        void showOccupations(List<CatalogItem> occupations);

        void showTechnicalLevels(List<CatalogItem> technicalLevels);

        void showOtherIncomes(List<CatalogItem> otherIncomes);

        void showRelationships(List<CatalogItem> relationships);

        void showDateDialog(Long maxDate);

        void sendResult(boolean result, int customerId);

        void clearErrors();

        void showFirstNameError();

        void showLastNameError();

        void showSexError();

        void showBirthDateError();

        void showBirthEntityError();

        void showBirthCountryError();

        void showCivilStatusError();

        void showNationalityError();

        void showEducationLevelError();

        void showOccupationError();

        void showEconomicDependentsError(int min, int max);

        void showHasOtherIncomeSourcesError();

        void showOtherIncomeSourcesError();

        void showOtherIncomeSourcesAmountError();

        void showNumCyclesOtherInstitutionsError();

        void showHasRelationshipPoliticallyExposedError();

        void showRelationshipError();

        void setBirthDate(Long date);

        void setCustomerData(CustomerData customerData);

        void toggleOtherIncomeFields(boolean shouldShow);

        void clearOtherIncomeFields();

        void togglePoliticallyExposedFields(boolean shouldShow);

        void clearPoliticallyExposedFields();

        void togglePoliticallyExposedRelationship(boolean shouldShow);

        void clearPoliticallyExposedRelationship();

        void toggleRfc(boolean shouldShow);

        void toggleCurp(boolean shouldShow);

        void togglePoliticallyExposed(boolean shouldShow);

        void toggleTechnicalDegree(boolean shouldShow);

        void showLoadSectionProgress();

        void hideProgress();

        void showSaveProgress();

        void showNetworkError();

        void showSaveError(String message);

        void showAdultAgeError(int minAge,int maxAge);

        void disableIdentificationFields();
    }

    interface CustomerDataPresenter extends BasePresenter {
        void onClickFinish(CustomerData customerData);

        void onClickBirthDate();

        void onBirthDateSet(int year, int month, int dayOfMonth);

        void onCheckHasOtherIncome(@BooleanQuestionView.CheckOption int option);

        void onCheckIsPoliticallyExposed(@BooleanQuestionView.CheckOption int option);

        void onCheckHasPoliticallyExposedRelationship(@BooleanQuestionView.CheckOption int option);
    }
}
