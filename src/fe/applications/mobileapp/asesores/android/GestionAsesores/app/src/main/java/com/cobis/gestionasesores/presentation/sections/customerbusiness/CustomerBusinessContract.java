package com.cobis.gestionasesores.presentation.sections.customerbusiness;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerBusiness;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

import java.util.List;

/**
 * Created by mnaunay on 07/06/2017.
 */

public class CustomerBusinessContract {
    public interface Presenter extends BasePresenter{
        void onClickFinish(CustomerBusiness customerBusiness);
        void onClickOpeningDate();
        void onOpeningDateSet(int year, int month, int dayOfMonth);
        void onClickAddressData();
        void onAddressDataResult(AddressData addressData);
        void onBusinessTypeChange(String code);
    }

    public interface View extends SectionViewBase, BaseView<CustomerBusinessContract.Presenter>{
        void setCustomerBusiness(CustomerBusiness customerBusiness);
        void clearErrors();
        void showAddressError();
        void showNameError();
        void showTurnaroundError();
        void showCreditDestinationError();
        void showPhoneNumberError();
        void showActivityError();
        void showTimeActivityError();
        void showTimeRootingError();
        void showOpeningDateError();
        void showCreditPayError();
        void showMonthlyIncomeError();
        void showLocationTypeError();
        void showTurnarounds(List<CatalogItem> turnarounds);
        void showActivities(List<CatalogItem> activities);
        void showBusinessTypes(List<CatalogItem> businessTypes);
        void showCreditDestinations(List<CatalogItem> creditDestinations);
        void showCreditPayResources(List<CatalogItem> creditPayResources);
        void showTimeActivity(List<CatalogItem> options);
        void showTimeRooting(List<CatalogItem> options);
        void showOpeningDateDialog(Long maxDate);
        void setOpeningDate(Long date);
        void setAddressData(String addressData);
        void startAddressData(AddressData addressData);
        void enableAddress(boolean enable);
        void showAddress(String address);
    }
}