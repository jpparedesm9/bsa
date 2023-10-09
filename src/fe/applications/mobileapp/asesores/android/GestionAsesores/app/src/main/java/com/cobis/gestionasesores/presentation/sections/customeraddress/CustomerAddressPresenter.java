package com.cobis.gestionasesores.presentation.sections.customeraddress;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.CommonUtils;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.ValidationUtils;

import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class CustomerAddressPresenter extends SectionPresenter implements CustomerAddressContract.CustomerAddressPresenter {
    private CustomerAddressContract.CustomerAddressView mView;
    private Section mSection;
    private AddressData mAddressData;
    private int mCustomerId;
    private GetAddressNameUseCase mAddressUseCase;

    public CustomerAddressPresenter(CustomerAddressContract.CustomerAddressView view, int customerId, Section section, GetSectionDataUseCase getSectionDataUseCase, SaveSectionUseCase saveProspectUseCase, GetAddressNameUseCase addressUseCase) {
        super(view, saveProspectUseCase, getSectionDataUseCase);
        mView = view;
        mSection = section;
        mCustomerId = customerId;
        mAddressUseCase = addressUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadSection(mCustomerId, mSection);
    }

    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        loadCatalogs();
    }

    @Override
    public void onClickFinish(CustomerAddress customerAddress) {
        customerAddress.setAddressData(mAddressData);
        if (validateCustomerAddress(customerAddress)) {
            customerAddress.mergeIdentifierWith((CustomerAddress) mSection.getSectionData());
            mSection.setSectionData(customerAddress);
            saveSection(mCustomerId, mSection);
        }
    }

    @Override
    public void onClickAddress() {
        mView.startAddressData(mAddressData);
    }

    @Override
    public void onAddressDataResult(AddressData addressData) {
        mAddressData = addressData;
        if (mAddressData != null) {
            mAddressUseCase.execute(mAddressData, new DisposableObserver<String>() {
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

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_QUANTITY, Catalog.CAT_HOUSING_TYPE};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initCustomerAddress((CustomerAddress) mSection.getSectionData());
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("CustomerAddressPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void initCustomerAddress(CustomerAddress customerAddress) {
        if (customerAddress != null) {
            mView.setCustomerAddress(customerAddress);
            onAddressDataResult(customerAddress.getAddressData());
        }
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_QUANTITY:
                mView.showYearsCurrentAddress(items);
                mView.showNumPeopleLivingInAddress(items);
                break;
            case Catalog.CAT_HOUSING_TYPE:
                mView.showHousingTypes(items);
                break;
        }
    }

    private boolean validateCustomerAddress(CustomerAddress customerAddress) {
        boolean isValid = true;

        mView.clearErrors();

        if (mAddressData == null) {
            isValid = false;
            mView.showAddressError();
        }

        String telephone = customerAddress.getTelephone();
        if (!ValidationUtils.isValidTelephone(telephone)) {
            isValid = false;
            mView.showTelephoneError();
        }

        String email = customerAddress.getEmail();
        if (!CommonUtils.isValidEmail(email)) {
            isValid = false;
            mView.showEmailError();
        }

        String cellphone = customerAddress.getCellphone();
        if (!ValidationUtils.isValidCellphone(cellphone)) {
            isValid = false;
            mView.showCellphoneError();
        }

        String yearsCurrentAddress = customerAddress.getYearsInCurrentAddress();
        if (yearsCurrentAddress == null || yearsCurrentAddress.isEmpty()) {
            isValid = false;
            mView.showYearsCurrentAddressError();
        }

        String housingType = customerAddress.getHousingType();
        if (housingType == null || housingType.isEmpty()) {
            isValid = false;
            mView.showHousingTypeError();
        }

        String numPeopleLivingInAddress = customerAddress.getNumPeopleLivingInAddress();
        if (numPeopleLivingInAddress == null || numPeopleLivingInAddress.isEmpty()) {
            isValid = false;
            mView.showNumPeopleLivingInAddressError();
        }

        return isValid;
    }
}
