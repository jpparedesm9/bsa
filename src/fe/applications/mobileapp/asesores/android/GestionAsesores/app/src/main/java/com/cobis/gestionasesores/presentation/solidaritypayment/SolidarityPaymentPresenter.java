package com.cobis.gestionasesores.presentation.solidaritypayment;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.domain.usecases.GetSolidarityPaymentUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSolidarityPaymentUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import java.math.BigDecimal;
import java.util.List;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

public class SolidarityPaymentPresenter extends ErrorPresenter implements SolidarityPaymentContract.Presenter {

    private static final int SCALE = 2;

    private SolidarityPaymentContract.View mView;

    private int mSolidarityPaymentId;
    private SolidarityPayment mSolidarityPayment;
    private GetSolidarityPaymentUseCase mGetSolidarityPaymentUseCase;
    private SaveSolidarityPaymentUseCase mSaveSolidarityPaymentUseCase;

    public SolidarityPaymentPresenter(SolidarityPaymentContract.View view, int solidarityPaymentId, GetSolidarityPaymentUseCase getSolidarityPaymentUseCase, SaveSolidarityPaymentUseCase saveSolidarityPaymentUseCase) {
        super(view);
        mView = view;
        mSolidarityPaymentId = solidarityPaymentId;
        mGetSolidarityPaymentUseCase = getSolidarityPaymentUseCase;
        mSaveSolidarityPaymentUseCase = saveSolidarityPaymentUseCase;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadSolidarityPayment(mSolidarityPaymentId);
    }

    private void loadSolidarityPayment(int id) {
        mGetSolidarityPaymentUseCase.execute(id, new DisposableObserver<SolidarityPayment>() {
            @Override
            public void onNext(@NonNull SolidarityPayment solidarityPayment) {
                mSolidarityPayment = solidarityPayment;
                if (mSolidarityPayment.getStatus() == SyncStatus.SYNCED) {
                    mView.readOnly();
                }
                mView.setSolidarityPayment(mSolidarityPayment);
                mView.updateCoveredAmount(getTotalPaymentAmount(mSolidarityPayment.getMembers()).doubleValue());
                checkError(solidarityPayment);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("SolidarityPaymentPresenter: Error load solidarity payment! ", e);
            }

            @Override
            public void onComplete() {
            }
        });
    }

    @Override
    public void onSave(SolidarityPayment solidarityPayment) {
        if (validateSolidarityPayment(mSolidarityPayment)) {
            mSolidarityPayment.setDebitAccount(solidarityPayment.isDebitAccount());
            mSolidarityPayment.setMembers(solidarityPayment.getMembers());
            mView.showSaveProgress();
            mSaveSolidarityPaymentUseCase.execute(mSolidarityPayment, new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData resultData) {
                    if (resultData.getType() == ResultType.SUCCESS) {
                        mView.showSaveSuccess(resultData.getErrorMessage());

                        if (resultData.getErrorMessage() == null) {
                            mView.exit();
                        }
                    } else {
                        mView.showSaveError(resultData.getErrorMessage());
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    Log.e("SolidarityPaymentPresenter: Error saving solidarity payment! ", e);
                    mView.hideSaveProgress();
                    if (Util.isNetworkError(e)) {
                        mView.showNetworkError();
                    } else {
                        mView.showSaveError(null);
                    }
                }

                @Override
                public void onComplete() {
                    mView.hideSaveProgress();
                }
            });
        }
    }

    @Override
    public void onSelectSolidarityMember(SolidarityMember solidarityMember, List<SolidarityMember> currentMembers) {
        mView.showPaymentPrompt(solidarityMember, getSuggestedPayment(currentMembers));
    }

    @Override
    public void onPaymentSet(SolidarityMember member, List<SolidarityMember> currentMembers) {
        mView.updateSolidarityMember(member);
        mView.updateCoveredAmount(getTotalPaymentAmount(currentMembers).doubleValue());
    }

    @Override
    public void onClickMoreInformation() {
        mView.startMoreInformation(mSolidarityPayment);
    }

    public boolean validateSolidarityPayment(SolidarityPayment payment) {
        boolean isValid = true;

        mView.clearErrors();

        BigDecimal paymentDue = new BigDecimal(payment.getPaymentDue()).setScale(SCALE, BigDecimal.ROUND_HALF_UP);

        BigDecimal paymentAccumulated = getTotalPaymentAmount(payment.getMembers());

        if (paymentDue.compareTo(paymentAccumulated) != 0) {
            isValid = false;
            mView.showCoveredAmountError();
        }

        return isValid;
    }

    public double getSuggestedPayment(List<SolidarityMember> currentMembers) {
        int numAvailable = getNumMissingPayment(currentMembers);
        BigDecimal paymentDue = new BigDecimal(mSolidarityPayment.getPaymentDue());
        BigDecimal totalPayment = getTotalPaymentAmount(currentMembers);
        BigDecimal missingPayment = paymentDue.subtract(totalPayment);

        BigDecimal missing = missingPayment.compareTo(BigDecimal.ZERO) <= 0 ? BigDecimal.ZERO : missingPayment;
        BigDecimal available = new BigDecimal(numAvailable == 0 ? 1 : numAvailable);

        return missing.divide(available, SCALE, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public int getNumMissingPayment(List<SolidarityMember> currentMembers) {
        int number = 0;
        for (SolidarityMember member : currentMembers) {
            if (member.getPaymentAmount() == 0) {
                number++;
            }
        }
        return number;
    }

    public BigDecimal getTotalPaymentAmount(List<SolidarityMember> currentMembers) {
        BigDecimal paymentAccumulated = new BigDecimal(0);

        for (SolidarityMember member : currentMembers) {
            paymentAccumulated = paymentAccumulated.add(new BigDecimal(member.getPaymentAmount()));
        }
        return paymentAccumulated.setScale(SCALE, BigDecimal.ROUND_HALF_UP);
    }
}