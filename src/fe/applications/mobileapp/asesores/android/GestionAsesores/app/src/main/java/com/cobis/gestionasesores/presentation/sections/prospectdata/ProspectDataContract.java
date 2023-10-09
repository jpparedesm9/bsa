package com.cobis.gestionasesores.presentation.sections.prospectdata;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

import java.util.List;

public interface ProspectDataContract {

    interface Presenter extends BasePresenter {
        void onClickFinish(ProspectData prospectData);
        void onBirthDateSet(int year, int month, int dayOfMonth);
        void onAddressDataResult(AddressData addressData);
        void onClickBirthDate();
        void onClickAddressData();
    }

    interface View extends BaseView<Presenter>, SectionViewBase {
        void sendResult(boolean isSuccess, int prospectId);

        void setProspectData(ProspectData prospectData);

        void setAddressData(String addressData);

        void startAddressData(AddressData addressData);

        void showSex(List<CatalogItem> sex);

        void showCivilStatus(List<CatalogItem> civilStatus);

        void showBirthEntities(List<PostalCode> birthEntities, String selectCode);

        void setBirthDate(Long date);

        void showBirthDatePicker(Long maxDate);

        void toggleRfc(boolean shouldShow);

        void toggleCurp(boolean shouldShow);

        void clearErrors();

        void showFirstNameError();

        void showLastNameError();

        void showEmailError();

        void showAddressError();

        void showSexError();

        void showCivilStatusError();

        void showBirthDateError();

        void showBirthEntityError();

        void disableFirstName();

        void disableSecondName();

        void disableLastName();

        void disableSecondLastName();

        void disableBirthDate();

        void disableBirthEntity();

        void disableSex();

        void hideProgress();

        void showSaveProgress();

        void showLoadSectionProgress();

        ProspectData getProspectData();

        void showSaveError(String message);

        void showNetworkError();

        void showAdultAgeError(int minAge,int maxAge);

        void disableIdentificationFields();
    }
}