package com.cobis.gestionasesores.presentation.person;

import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import java.util.List;

/**
 * Created by mnaunay on 05/06/2017.
 */

public class PersonContract {
    public interface Presenter extends BasePresenter, ErrorBaseContract.ErrorBasePresenter {
        void onSectionSelected(Section section);

        void onSectionChangedResult(int personId);

        void onClickDelete();

        void doDelete();

        void convertToCustomer();

        void onClickValidateProspect();

        void onClickCreateNewPartner();

        void onClickSelectPartner();

        void onSelectPartner(Person person);
    }

    public interface View extends BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {
        void showSections(List<Section> sections);

        void startCustomerDataSection(Person customer);

        void startPartnerDataSection(int personId, Section section);

        void startReferencesDataActivity(int personId, Section section);

        void startCustomerPaymentSection(int personId, Section section, double otherIncome);

        void startCustomerAddressSection(int personId, Section section);

        void startPartnerWorkSection(int personId, Section section);

        void startCustomerBusinessSection(int personId, Section section, AddressData optionalAddress);

        void startDocumentsSection(int personId, Section section);

        void startComplementaryDataSection(int personId, Section section);

        void showMessageFail();

        void showSaveError(String message);

        void showMessageDeleteSuccess(@PersonType int type);

        void toggleDeleteOption(boolean isVisible);

        void showConvertOption(boolean shouldShow);

        void closeAndExit();

        AddressData getCustomerAddressData();

        void showTitle(@PersonType int type);

        void showAlertDelete(@PersonType int type);

        void startProspectData(Person prospect);

        void showLoadingProgress();

        void showSaveProgress();

        void dismissProgress();

        void showValidateProgress();

        void showConvertProgress();

        void showNotNetworkConnection();

        void showValidateError(String error);

        void showErrorConvertToCustomer();

        void showPersonName(String name);

        void showValidateOption(boolean shouldShow);

        void showValidateSuccess(String message);

        void showNetworkError();

        void showNoValidateError();

        void showValidationLabel(boolean isValidated);

        void hideValidationLabel();

        void showPartnerDialog();

        void goToSelectPartner(int localId);
    }
}
