package com.cobis.gestionasesores.presentation.sections.partnerdata;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

import java.util.List;

public interface PartnerDataContract {

    interface PartnerDataView extends SectionViewBase, BaseView<PartnerDataPresenter> {
        void setPartnerData(PartnerData partnerData);

        void clearErrors();

        void showSex(List<CatalogItem> sex);

        void showFederalEntities(List<PostalCode> federalEntities, String selectCode);

        void showBirthCountries(List<CatalogItem> countries, String selectCode);

        void showNationalities(List<CatalogItem> nationalities);

        void showEducationLevels(List<CatalogItem> educationLevels);

        void showOccupations(List<CatalogItem> occupations);

        void showFirstNameError();

        void showLastNameError();

        void showSexError();

        void showBirthDateError();

        void showBirthEntityError();

        void showBirthCountryError();

        void showNationalityError();

        void showEducationLevelError();

        void showOccupationError();

        void showDateDialog(Long maxDate);

        void setBirthDate(Long date);

        void showActivities(List<CatalogItem> items);

        void showActivityError();

        void showAdultAgeError(int minAge,int maxAge);

        void disableIdentificationFields();
    }

    interface PartnerDataPresenter extends BasePresenter {
        void onClickFinish(PartnerData partnerData);

        void onClickBirthDate();

        void onBirthDateSet(int year, int month, int dayOfMonth);
    }
}
