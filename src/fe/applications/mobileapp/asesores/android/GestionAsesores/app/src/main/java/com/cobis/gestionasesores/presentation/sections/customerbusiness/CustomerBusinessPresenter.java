package com.cobis.gestionasesores.presentation.sections.customerbusiness;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.BusinessType;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerBusiness;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.ValidationUtils;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by mnaunay on 07/06/2017.
 */

public class CustomerBusinessPresenter extends SectionPresenter implements CustomerBusinessContract.Presenter {
    private CustomerBusinessContract.View mView;
    private Section mSection;
    private AddressData mSelectedAddress;
    private AddressData mOptionalAddress;
    private int mPersonId;
    private int mAddressServerId;
    private GetAddressNameUseCase mAddressUseCase;

    public CustomerBusinessPresenter(CustomerBusinessContract.View view, int personId, Section section, AddressData optionalAddress, GetSectionDataUseCase getSectionDataUseCase, SaveSectionUseCase saveSectionUseCase, GetAddressNameUseCase getAddressNameUseCase) {
        super(view, saveSectionUseCase, getSectionDataUseCase);
        mView = view;
        mSection = section;
        mPersonId = personId;
        mOptionalAddress = optionalAddress;
        mOptionalAddress.setServerId(0);
        mAddressUseCase = getAddressNameUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadSection(mPersonId, mSection);
    }

    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        loadCatalogs();
    }


    @Override
    public void onClickFinish(CustomerBusiness customerBusiness) {
        if (mSelectedAddress != null) {
            mSelectedAddress.setServerId(mAddressServerId);
        }
        customerBusiness = customerBusiness.buildUpon()
                .addAddressData(mSelectedAddress)
                .build();
        if (validateCustomerBusiness(customerBusiness)) {
            CustomerBusiness old = (CustomerBusiness) mSection.getSectionData();
            if (old != null) {
                customerBusiness.setServerId(old.getServerId());
                customerBusiness = customerBusiness.buildUpon().addPhoneId(old.getPhoneId()).build();
            }
            mSection.setSectionData(customerBusiness);
            saveSection(mPersonId, mSection);
        }
    }

    @Override
    public void onClickOpeningDate() {
        mView.showOpeningDateDialog(Calendar.getInstance().getTimeInMillis());
    }

    @Override
    public void onOpeningDateSet(int year, int month, int dayOfMonth) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, dayOfMonth);
        mView.setOpeningDate(calendar.getTimeInMillis());
    }

    @Override
    public void onClickAddressData() {
        mView.startAddressData(mSelectedAddress);
    }

    @Override
    public void onAddressDataResult(AddressData addressData) {
        mSelectedAddress = addressData;
        if (addressData != null) {
            mAddressUseCase.execute(mSelectedAddress, new DisposableObserver<String>() {
                @Override
                public void onNext(@NonNull String result) {
                    mView.setAddressData(result);
                }

                @Override
                public void onError(@NonNull Throwable e) {
                }

                @Override
                public void onComplete() {
                }
            });
        }
    }

    @Override
    public void onBusinessTypeChange(String code) {
        CustomerBusiness customerBusiness = (CustomerBusiness) mSection.getSectionData();
        if (BusinessType.TYPE_SAME_ADDRESS.equals(code) && mOptionalAddress != null) {//Picks same address and customer address section has saved address
            onAddressDataResult(mOptionalAddress);
            mView.enableAddress(false);
        } else if (customerBusiness == null) {//Section has not been saved before
            mView.enableAddress(true);
        } else if (customerBusiness.getLocationType() != null && !customerBusiness.getLocationType().equals(code)) { //Picks a location type different to the one selected last time
            mView.enableAddress(true);
        } else {
            onAddressDataResult(customerBusiness.getAddressData());
            mView.enableAddress(true);
        }
    }

    private void initCustomerBusiness(CustomerBusiness customerBusiness) {
        if (customerBusiness != null) {
            mView.setCustomerBusiness(customerBusiness);
            onAddressDataResult(customerBusiness.getAddressData());
            String businessType = customerBusiness.getLocationType();
            if (customerBusiness.getAddressData() != null) {
                mAddressServerId = customerBusiness.getAddressData().getServerId();
            }
            mView.enableAddress(!BusinessType.TYPE_SAME_ADDRESS.equals(businessType));
        }
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_ACTIVITY,
                Catalog.CAT_QUANTITY,
                Catalog.CAT_TURNAROUND,
                Catalog.CAT_CREDIT_DESTINATION,
                Catalog.CAT_CREDIT_PAY_RES,
                Catalog.CAT_BUSINESS_TYPE};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initCustomerBusiness((CustomerBusiness) mSection.getSectionData());
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("CustomerBusinessPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_ACTIVITY:
                mView.showActivities(items);
                break;
            case Catalog.CAT_QUANTITY:
                mView.showTimeActivity(items);
                mView.showTimeRooting(items);
                break;
            case Catalog.CAT_TURNAROUND:
                mView.showTurnarounds(items);
                break;
            case Catalog.CAT_BUSINESS_TYPE:
                mView.showBusinessTypes(items);
                break;
            case Catalog.CAT_CREDIT_DESTINATION:
                mView.showCreditDestinations(items);
                break;
            case Catalog.CAT_CREDIT_PAY_RES:
                mView.showCreditPayResources(items);
                break;
        }
    }

    private boolean validateCustomerBusiness(CustomerBusiness customerBusiness) {
        boolean isValid = true;

        mView.clearErrors();

        String name = customerBusiness.getName();
        if (name == null || name.isEmpty()) {
            isValid = false;
            mView.showNameError();
        }

        /*Cobis: Turnaround is not visible!
        String turnaround = customerBusiness.getTurnaround();
        if (turnaround == null || turnaround.isEmpty()) {
            isValid = false;
            mView.showTurnaroundError();
        }*/

        String creditDestination = customerBusiness.getCreditDestination();
        if (creditDestination == null || creditDestination.isEmpty()) {
            isValid = false;
            mView.showCreditDestinationError();
        }

        String phoneNumber = customerBusiness.getPhoneNumber();
        if (!ValidationUtils.isValidTelephone(phoneNumber)) {
            isValid = false;
            mView.showPhoneNumberError();
        }

        String activity = customerBusiness.getActivity();
        if (activity == null || activity.isEmpty()) {
            isValid = false;
            mView.showActivityError();
        }

        String timeActivity = customerBusiness.getTimeActivity();
        if (timeActivity == null || timeActivity.isEmpty()) {
            isValid = false;
            mView.showTimeActivityError();
        }

        String timeRooting = customerBusiness.getTimeRooting();
        if (timeRooting == null || timeRooting.isEmpty()) {
            isValid = false;
            mView.showTimeRootingError();
        }

        if (customerBusiness.getOpeningDate() == null) {
            isValid = false;
            mView.showOpeningDateError();
        }

        String creditPay = customerBusiness.getCreditPay();
        if (creditPay == null || creditPay.isEmpty()) {
            isValid = false;
            mView.showCreditPayError();
        }

        if (customerBusiness.getMonthlyIncome() == 0.0) {
            isValid = false;
            mView.showMonthlyIncomeError();
        }

        String locationType = customerBusiness.getLocationType();
        if (locationType == null || locationType.isEmpty()) {
            isValid = false;
            mView.showLocationTypeError();
        } else if (mSelectedAddress == null) {
            isValid = false;
            mView.showAddressError();
        }
        return isValid;
    }
}