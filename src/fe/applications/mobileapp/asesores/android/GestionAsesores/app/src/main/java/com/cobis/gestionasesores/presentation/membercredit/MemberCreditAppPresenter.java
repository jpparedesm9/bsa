package com.cobis.gestionasesores.presentation.membercredit;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.domain.usecases.GetCompleteMemberCreditUseCase;

import io.reactivex.observers.DisposableObserver;

public class MemberCreditAppPresenter implements MemberCreditAppContract.Presenter {

    private MemberCreditAppContract.View mView;
    private MemberCreditApp mMemberCredit;
    private GetCompleteMemberCreditUseCase mGetCompleteMemberCreditUseCase;

    public MemberCreditAppPresenter(MemberCreditAppContract.View view, MemberCreditApp memberCredit, GetCompleteMemberCreditUseCase getCompleteMemberCreditUseCase) {
        mView = view;
        mMemberCredit = memberCredit;
        mGetCompleteMemberCreditUseCase = getCompleteMemberCreditUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadMemberCredit();
    }

    @Override
    public void onClickSave(boolean isPartOfCycle,double requestAmount, double authAmount) {
        mView.clearErrors();
        if(isPartOfCycle) {
            if (isValidaData(requestAmount)) {
                mMemberCredit.setPartOfCycle(true);
                mMemberCredit.setRequestAmount(requestAmount);
                mMemberCredit.setAuthorizedAmount(authAmount);
                mView.sendResult(mMemberCredit);
            }
        }else{
            mMemberCredit.setPartOfCycle(false);
            mView.sendResult(mMemberCredit);
        }
    }

    @Override
    public void deleteFromAppRequest() {
        mMemberCredit.setPartOfCycle(false);
        mMemberCredit.setRequestAmount(0);
        initMemberCredit(mMemberCredit);
    }

    @Override
    public void onComputeWarranty(double authAmount) {
        float percentage = BankAdvisorApp.getInstance().getConfig().getFloat(Parameters.WARRANTY_LIQUID);
        double warranty = authAmount * (percentage / 100.00);
        mView.showWarrantyAmount(warranty);
    }

    private void loadMemberCredit(){
        mGetCompleteMemberCreditUseCase.execute(mMemberCredit, new DisposableObserver<MemberCreditApp>() {
            @Override
            public void onNext(MemberCreditApp memberCreditApp) {
                mMemberCredit = memberCreditApp;
                initMemberCredit(mMemberCredit);
            }

            @Override
            public void onError(Throwable e) {
                initMemberCredit(mMemberCredit);
            }

            @Override
            public void onComplete() {
            }
        });
    }

    private void initMemberCredit(MemberCreditApp member){
        mView.showMemberData(member);

        if(StringUtils.isNotEmpty(member.getRiskLevel())){
            mView.drawRiskLevel(member.getRiskLevel());
        }else{
            mView.hideRiskLevel();
        }
        mView.toggleRequestView(member.isPartOfCycle());
        mView.toggleProposedAmount(member.getMaxProposedAmount()>0.0);
    }

    private boolean isValidaData(double requestAmount) {
        boolean isValid = true;
        float multipleAmount = BankAdvisorApp.getInstance().getConfig().getFloat(Parameters.AMOUNT_REQUEST_APP);
        if (requestAmount == 0.0 || (requestAmount % multipleAmount) != 0) {
            mView.showRequestAmountError();
            isValid = false;
        }
        return isValid;
    }
}