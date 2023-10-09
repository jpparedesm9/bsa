package com.cobis.gestionasesores.presentation.sections.partnerwork;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.PartnerWork;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public interface PartnerWorkContract {

    interface PartnerWorkView extends SectionViewBase,BaseView<PartnerWorkPresenter>{
        void setPartnerWork(@NonNull PartnerWork partnerWork);
        void showWorkTelephoneError();
        void showCellphoneError();
        void clearErrors();
        void setAddressData(String addressData);
        void startAddressData(AddressData addressData);
        void showAddressError();
        void showSamePhonesError();
    }

    interface PartnerWorkPresenter extends BasePresenter{
        void onClickFinish(@NonNull PartnerWork partnerWork);
        void onClickAddressData();
        void onAddressDataResult(AddressData addressData);
    }
}
