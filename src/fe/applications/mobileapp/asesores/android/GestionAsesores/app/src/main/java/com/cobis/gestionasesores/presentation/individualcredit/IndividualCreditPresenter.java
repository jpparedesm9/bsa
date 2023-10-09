package com.cobis.gestionasesores.presentation.individualcredit;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.mappers.IndividualCreditMapper;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Guarantor;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;
import com.cobis.gestionasesores.domain.usecases.SaveIndividualUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class IndividualCreditPresenter extends ErrorPresenter implements IndividualCreditContract.Presenter {
    private IndividualCreditContract.View mView;
    private IndividualCreditApp mCreditApp;
    private SaveIndividualUseCase mSaveUseCase;

    public IndividualCreditPresenter(IndividualCreditContract.View view, IndividualCreditApp creditApp, SaveIndividualUseCase useCase) {
        super(view);
        mView = view;
        mCreditApp = creditApp;
        mView.setPresenter(this);
        mSaveUseCase = useCase;
    }

    @Override
    public void start() {
        if (mCreditApp.getId() != -1 && mCreditApp.getServerId() <= 0) {
            mView.showDeleteOption();
        }
        loadCatalogs();
    }

    @Override
    public void onClickSave(IndividualCreditApp creditApp) {
        double authorizedAmount = creditApp.getAuthorizedAmount();
        if (authorizedAmount == 0 && mCreditApp.getCycle() < 1) {
            authorizedAmount = creditApp.getAmount();
        }

        mCreditApp = mCreditApp.buildUpon()
                .setRenovation(creditApp.isRenovation())
                .setDestination(creditApp.getDestination())
                .setTerm(creditApp.getTerm())
                .setFrequency(creditApp.getFrequency())
                .setPromotion(creditApp.isPromotion())
                .setAmount(creditApp.getAmount())
                .setAuthorizedAmount(authorizedAmount)
                .setGuarantor(creditApp.getGuarantor())
                .build();
        if (validateIndividualCredit(mCreditApp)) {
            saveIndividualCreditApp(mCreditApp, false, true);
        }
    }

    @Override
    public void onClickDelete() {
        mView.showConfirmDeleteDialog();
    }

    @Override
    public void onConfirmDelete() {
        deleteIndividualCreditApp(mCreditApp);
    }

    @Override
    public void onClickSelectGuarantor() {
        mView.startSelectGuarantor(new int[]{mCreditApp.getCustomerServerId()});
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_CR_DESTINATION, Catalog.CAT_CREDIT_TERM_MONTHS, Catalog.CAT_CREDIT_FREQUENCY};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
            @Override
            public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                    handleCatalogItems(entry.getKey(), entry.getValue());
                }
                initializeIndividualCredit(mCreditApp);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("IndividualCreditPresenter: Error getCatalogItemsByCodes! ", e);
            }

            @Override
            public void onComplete() {
            }
        });
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_CR_DESTINATION:
                mView.showCreditDestinations(items);
                break;
            case Catalog.CAT_CREDIT_TERM_MONTHS:
                mView.showCreditTerms(items);
                break;
            case Catalog.CAT_CREDIT_FREQUENCY:
                mView.showCreditFrequency(items);
                break;
            default:
                throw new RuntimeException("Item catalog is not handler: " + code);
        }
    }

    private void initializeIndividualCredit(IndividualCreditApp creditApp) {
        mView.setIndividualCreditApp(creditApp);

        initializeGuarantor(creditApp.getGuarantor());

        //TODO: Luis Castellanos: 06/09/2017 disabled
        //mView.setFixedCreditFrequency(FrequencyType.MONTHLY);

        int cycle = creditApp.getCycle();
        String adviser = creditApp.getAdviser();
        String office = creditApp.getBranchOffice();
        String rate = creditApp.getRate();
        String riskLevel = creditApp.getRiskLevel();

        mView.toggleApplicationDate(creditApp.getCreationDate() != null);
        // FIXME: 7/6/2017 get this from session if adviser is different than current user
        mView.toggleAdviser(adviser != null);
        mView.toggleBranchOffice(office != null);
        mView.toggleRenew(cycle > 0);
        mView.toggleRate(rate != null);
        mView.togglePreviousCredit(cycle > 1);
        if (StringUtils.isEmpty(riskLevel)) {
            mView.hideRiskLevel();
        } else {
            mView.drawRiskLevel(riskLevel);
        }
        mView.setReadOnly(mCreditApp.getStatus() == SyncStatus.SYNCED);
        checkError(creditApp);
    }

    private void initializeGuarantor(Guarantor guarantor) {
        if (guarantor != null) {
            mView.setGuarantor(guarantor);
            if (StringUtils.isNotEmpty(guarantor.getRiskLevel())) {
                mView.drawGuarantorRiskLevel(guarantor.getRiskLevel());
            } else {
                mView.hideGuarantorRiskLevel();
            }
        } else {
            Log.i("Guarantor is empty!");
        }
    }

    private boolean validateIndividualCredit(IndividualCreditApp creditApp) {
        boolean isValid = true;
        mView.clearErrors();
        String creditDestination = creditApp.getDestination();
        if (StringUtils.isEmpty(creditDestination)) {
            isValid = false;
            mView.showDestinationError();
        }

        String term = creditApp.getTerm();
        if (StringUtils.isEmpty(term)) {
            isValid = false;
            mView.showTermError();
        }

        String frequency = creditApp.getFrequency();
        if (StringUtils.isEmpty(frequency)) {
            isValid = false;
            mView.showFrequencyError();
        }

        Guarantor guarantor = creditApp.getGuarantor();
        if (guarantor == null || StringUtils.isEmpty(guarantor.getDocument())) {
            isValid = false;
            mView.showGuarantorError();
        }

        float multipleAmount = BankAdvisorApp.getInstance().getConfig().getFloat(Parameters.AMOUNT_REQUEST_APP);
        double requestAmount = creditApp.getAmount();
        if (requestAmount == 0.0 || (requestAmount % multipleAmount) != 0) {
            mView.showRequestAmountError();
            isValid = false;
        }
        return isValid;
    }

    private void saveIndividualCreditApp(final IndividualCreditApp creditApp, boolean isConfirmation, boolean tryRemote) {
        mView.showSavingProgress();
        mSaveUseCase.execute(new SaveIndividualUseCase.Params(creditApp, isConfirmation, tryRemote), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@NonNull ResultData resultData) {
                if (resultData.getData() != null) {
                    mCreditApp = (IndividualCreditApp) resultData.getData();
                }
                if (resultData.getType() == ResultType.SUCCESS) {
                    mView.showSaveSuccess(resultData.getErrorMessage());

                    if (resultData.getErrorMessage() == null) {
                        mView.exit();
                    }
                } else if (resultData.getType() == ResultType.FAILURE_LOCAL) {
                    mView.showCustomerNotSyncedError();
                } else if (StringUtils.isNotEmpty(mCreditApp.getWarningMessage())) {
                    mView.showWarningMessage(mCreditApp.getWarningMessage());
                } else {
                    mView.showSaveError(resultData.getError());
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.hideProgress();
                if (Util.isNetworkError(e)) {
                    mView.showNetworkError();
                } else {
                    mView.showSaveError(null);
                }
            }

            @Override
            public void onComplete() {
                mView.hideProgress();
            }
        });
    }

    private void deleteIndividualCreditApp(IndividualCreditApp creditApp) {
        CreditAppRepository.getInstance().delete(creditApp).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribeWith(new DisposableObserver<Boolean>() {
            @Override
            public void onNext(@NonNull Boolean aBoolean) {
                mView.showDeleteSuccess();
                mView.exit();
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.showDeleteError();
            }

            @Override
            public void onComplete() {
            }
        });
    }

    @Override
    public void onGuarantorSelected(Person person) {
        Guarantor guarantor = IndividualCreditMapper.createGuarantor(person);
        initializeGuarantor(guarantor);
    }

    @Override
    public void onClickConfirmation() {
        saveIndividualCreditApp(mCreditApp, true, true);
    }

    @Override
    public void onClickLocalSave() {
        saveIndividualCreditApp(mCreditApp, false, false);
    }

    @Override
    public void onTryToExit() {
        if (mCreditApp.getServerId() > 0 && mCreditApp.getStatus() != SyncStatus.SYNCED && !mCreditApp.isInProcess()) {
            mView.showMessageExit();
        } else {
            mView.exit();
        }
    }
}