package com.cobis.gestionasesores.presentation.sections.partnerwork;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.PartnerWork;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.ValidationUtils;

import io.reactivex.observers.DisposableObserver;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class PartnerWorkPresenter extends SectionPresenter implements PartnerWorkContract.PartnerWorkPresenter {

    private PartnerWorkContract.PartnerWorkView mView;

    private int mPersonId;
    private Section mSection;
    private AddressData mAddressData;
    private GetAddressNameUseCase mAddressNameUseCase;

    public PartnerWorkPresenter(PartnerWorkContract.PartnerWorkView view, int personId, Section section,
                                GetSectionDataUseCase getSectionDataUseCase, SaveSectionUseCase saveSectionUseCase, GetAddressNameUseCase getAddressNameUseCase) {
        super(view, saveSectionUseCase, getSectionDataUseCase);
        mView = view;
        mSection = section;
        mPersonId = personId;
        mAddressNameUseCase = getAddressNameUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadSection(mPersonId, mSection);
    }

    @Override
    public void onClickFinish(@NonNull PartnerWork partnerWork) {
        partnerWork = partnerWork.buildUpon().addAddressData(mAddressData).build();
        if (validatePartnerWork(partnerWork)) {
            partnerWork.mergeIdentifierWith((PartnerWork) mSection.getSectionData());
            mSection.setSectionData(partnerWork);
            saveSection(mPersonId, mSection);
        }
    }

    @Override
    public void onClickAddressData() {
        mView.startAddressData(mAddressData);
    }

    @Override
    public void onAddressDataResult(AddressData addressData) {
        mAddressData = addressData;
        if (mAddressData != null) {
            mAddressNameUseCase.execute(mAddressData, new DisposableObserver<String>() {
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

    private void initPartnerWork(PartnerWork partnerWork) {
        if (partnerWork != null) {
            mView.setPartnerWork(partnerWork);
            onAddressDataResult(partnerWork.getAddressData());
        }

    }

    private boolean validatePartnerWork(PartnerWork partnerWork) {
        boolean isValid = true;
        mView.clearErrors();

        String workTelephone = partnerWork.getTelephoneWork();
        String cellphone = partnerWork.getCellphone();

        if (partnerWork.getAddressData() == null) {
            mView.showAddressError();
            isValid = false;
        }

        if (!workTelephone.isEmpty() && !ValidationUtils.isValidTelephone(workTelephone)) {
            isValid = false;
            mView.showWorkTelephoneError();
        }

        if (!cellphone.isEmpty() && !ValidationUtils.isValidCellphone(cellphone)) {
            isValid = false;
            mView.showCellphoneError();
        }

        if(isValid && workTelephone.equals(cellphone)){
            isValid = false;
            mView.showSamePhonesError();
        }

        return isValid;
    }

    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        initPartnerWork((PartnerWork) mSection.getSectionData());
    }
}
