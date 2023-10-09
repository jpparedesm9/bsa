package com.cobis.gestionasesores.presentation.sections.references.items;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.CommonUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.domain.usecases.SaveReferenceUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;
import com.cobis.gestionasesores.utils.ValidationUtils;

import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class ReferencePresenter extends ErrorPresenter implements ReferenceContract.Presenter {
    private List<Reference> mReferenceList;
    private Reference mReference;
    private int mPersonId;
    private SaveReferenceUseCase mSaveReferenceUseCase;
    private ReferenceContract.View mReferenceView;

    public ReferencePresenter(ReferenceContract.View referenceView, int personId, Reference reference, List<Reference> references, SaveReferenceUseCase useCase) {
        super(referenceView);
        mReferenceView = referenceView;
        mReferenceList = references;
        mPersonId = personId;
        mReference = reference;
        mSaveReferenceUseCase = useCase;
        this.mReferenceView.setPresenter(this);
    }

    @Override
    public void start() {
        loadCatalogs();
    }

    @Override
    public void saveReference(Reference newReference) {
        boolean isNewReference = isNewReference();
        if (isReferenceValid(newReference, isNewReference)) {
            newReference.mergeIdentifiers(mReference);
            save(mPersonId, newReference);
        }
    }

    private void save(int personId, Reference reference) {
        mReferenceView.showSaveProgress();
        mSaveReferenceUseCase.execute(new SaveReferenceUseCase.Params(personId, reference), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@io.reactivex.annotations.NonNull ResultData resultData) {
                if (resultData.getType() == ResultType.SUCCESS) {
                    if(resultData.getErrorMessage() == null) {
                        mReferenceView.showReferenceSave(null);
                        acceptWarning();
                    }else{
                        mReferenceView.showReferenceSave(resultData.getErrorMessage());
                    }
                } else {
                    mReferenceView.showSaveError(resultData.getErrorMessage());
                }
            }

            @Override
            public void onError(@io.reactivex.annotations.NonNull Throwable e) {
                mReferenceView.hideProgress();
                if (Util.isNetworkError(e)) {
                    mReferenceView.showNetworkError();
                } else {
                    mReferenceView.showSaveError(null);
                }
            }

            @Override
            public void onComplete() {
                mReferenceView.hideProgress();
            }
        });
    }

    @Override
    public boolean isDeleteEnabled() {
        //MNA: references sync with server can´t be deleted
        return (mReference != null && mReference.getServerId() <= 0);
    }

    @Override
    public void deleteReference() {
        int index = mReferenceList.indexOf(mReference);
        if (index >= 0) {
            mReferenceList.remove(index);
            mReferenceView.showReferenceDeleted();
            mReferenceView.returnToList(true);
        } else {
            Log.e("Never print this message for index: "+index);
        }
    }

    @Override
    public void acceptWarning() {
        mReferenceView.returnToList(true);
    }

    private boolean isNewReference() {
        return (mReference == null);
    }

    private boolean isReferenceValid(Reference reference, boolean isNewReference) {
        boolean isValid = true;
        mReferenceView.clearErrors();
        if (StringUtils.isEmpty(reference.getName())) {
            mReferenceView.showNameError();
            isValid = false;
        }

        if (StringUtils.isEmpty(reference.getLastName())) {
            mReferenceView.showLastNameError();
            isValid = false;
        }

        if (existReference(mReferenceList, reference, mReference != null ? mReference.getId() : "")) {
            mReferenceView.showReferenceExistError();
            isValid = false;
        }

        if (!ValidationUtils.isValidCellphone(reference.getPhone())) {
            mReferenceView.showPhoneError();
            isValid = false;
        }

        String email = StringUtils.nullToString(reference.getEmail()).trim();
        if (StringUtils.isNotEmpty(email) && !CommonUtils.isValidEmail(email)) {
            mReferenceView.showEmailError();
            isValid = false;
        }

        if (StringUtils.isEmpty(reference.getTimeToMeet())) {
            mReferenceView.showTimeToMeetError();
            isValid = false;
        }
        return isValid;
    }

    private boolean existReference(List<Reference> references, Reference refValidate, String validateId) {
        String name1, name2;
        for (Reference reference : references) {
            if (validateId != null && !validateId.equals(StringUtils.nullToString(reference.getId()))) {
                name1 = reference.getName().trim().toUpperCase() + " " + reference.getLastName().trim().toUpperCase();
                name2 = refValidate.getName().trim().toUpperCase() + " " + refValidate.getLastName().trim().toUpperCase();
                if (name1.equals(name2)) {
                    return true;
                }
            }
        }
        return false;
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_QUANTITY};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
            @Override
            public void onNext(@io.reactivex.annotations.NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                    handleCatalogItems(entry.getKey(), entry.getValue());
                }
                initReference();
            }

            @Override
            public void onError(@io.reactivex.annotations.NonNull Throwable e) {
                Log.e("CustomerAddressPresenter: Error getCatalogItemsByCodes! ", e);
            }

            @Override
            public void onComplete() {
            }
        });
    }

    private void initReference() {
        if (mReference != null) {
            mReferenceView.setReference(mReference);
            checkError(mReference);
        }
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_QUANTITY:
                mReferenceView.showTimeToMeeting(items);
                break;
        }
    }

    private boolean existReferenceName(final List<Reference> references, final String referenceName) {
        for (Reference reference : references) {
            if (reference.getName().equalsIgnoreCase(referenceName)) {
                return true;
            }
        }
        return false;
    }
}
