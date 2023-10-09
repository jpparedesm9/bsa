package com.cobis.gestionasesores.presentation.sections.customeraddress;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public interface CustomerAddressContract {

    interface CustomerAddressView extends BaseView<CustomerAddressPresenter>, SectionViewBase {
        void clearErrors();
        void setCustomerAddress(@NonNull CustomerAddress customerAddress);
        void showTelephoneError();
        void showEmailError();
        void showCellphoneError();
        void showYearsCurrentAddressError();
        void showHousingTypeError();
        void showNumPeopleLivingInAddressError();
        void showAddressError();
        void showYearsCurrentAddress(List<CatalogItem> options);
        void showHousingTypes(List<CatalogItem> housingTypes);
        void showNumPeopleLivingInAddress(List<CatalogItem> options);
        void startAddressData(AddressData addressData);
        void setAddressData(String addressData);
    }

    interface CustomerAddressPresenter extends BasePresenter{
        void onClickFinish(CustomerAddress customerAddress);
        void onClickAddress();
        void onAddressDataResult(AddressData addressData);
    }
}
