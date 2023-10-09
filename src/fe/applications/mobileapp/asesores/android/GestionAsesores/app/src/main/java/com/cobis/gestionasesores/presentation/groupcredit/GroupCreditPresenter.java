package com.cobis.gestionasesores.presentation.groupcredit;

import android.annotation.SuppressLint;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;
import com.cobis.gestionasesores.domain.usecases.GetGroupCreditApp;
import com.cobis.gestionasesores.domain.usecases.SaveGroupCreditApp;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import java.util.List;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class GroupCreditPresenter extends ErrorPresenter implements GroupCreditContract.GroupCreditPresenter {
    private GroupCreditContract.GroupCreditView mView;
    private GroupCreditApp mGroupCreditApp;
    private int mMaxGroupCreditMembers;
    private int mMinGroupCreditMembers;
    private GetGroupCreditApp mGetGroupCreditApp;
    private SaveGroupCreditApp mSaveUseCase;

    public GroupCreditPresenter(GroupCreditContract.GroupCreditView view, GroupCreditApp groupCreditApp,
                                GetGroupCreditApp getGroupCreditApp, SaveGroupCreditApp saveGroupCreditApp) {
        super(view);
        mView = view;
        mGroupCreditApp = groupCreditApp;
        mGetGroupCreditApp = getGroupCreditApp;
        mSaveUseCase = saveGroupCreditApp;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        if(mGetGroupCreditApp != null && mGroupCreditApp.getServerId() > 0) {
            loadGroupCreditApp(mGroupCreditApp.getServerId());
        }else{
            initGroupCreditApp(mGroupCreditApp);
            checkError(mGroupCreditApp);
        }
        mMaxGroupCreditMembers = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_MEMBERS_GROUP_CREDIT);
        mMinGroupCreditMembers = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_MEMBERS_GROUP_CREDIT);
    }

    @Override
    public void onClickSave(GroupCreditApp groupCreditApp) {
        mGroupCreditApp = mGroupCreditApp.buildUpon()
                .setPromotion(groupCreditApp.isPromotion())
                .setReason(groupCreditApp.getReason())
                .setRenew(groupCreditApp.isRenew())
                .setMemberCreditApps(groupCreditApp.getMemberCreditApps())
                .build();
        if (validateGroupCreditApp(mGroupCreditApp)) {
            saveGroupCreditApp(mGroupCreditApp,false, true);
        }
    }

    private void loadGroupCreditApp(int appId){
        mView.showLoadProgress();
        mGetGroupCreditApp.execute(appId, new DisposableObserver<CreditApp>() {
            @Override
            public void onNext(CreditApp creditApp) {
                mGroupCreditApp = (GroupCreditApp) creditApp;
                initGroupCreditApp(mGroupCreditApp);
                checkError(mGroupCreditApp);
            }

            @Override
            public void onError(Throwable e) {
                mView.hideProgress();
                Log.e("GroupCreditPresenter: Error loadGroupCreditApp!", e);
            }

            @Override
            public void onComplete() {
                mView.hideProgress();
            }
        });
    }

    private void saveGroupCreditApp(GroupCreditApp groupCreditApp,boolean isConfirmation, boolean tryRemote) {
        mView.showSavingProgress();
        mSaveUseCase.execute(new SaveGroupCreditApp.Params(groupCreditApp,isConfirmation,tryRemote), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@NonNull ResultData resultData) {
                if(resultData.getData() != null) {
                    mGroupCreditApp = (GroupCreditApp) resultData.getData();
                }
                if (resultData.getType() == ResultType.SUCCESS) {
                    mView.showCreateSuccess(resultData.getErrorMessage());

                    if (resultData.getErrorMessage() == null) {
                        mView.exit();
                    }
                } else if (resultData.getType() == ResultType.FAILURE_LOCAL) {
                    mView.showCustomerNotSyncedError();
                }else if(StringUtils.isNotEmpty(mGroupCreditApp.getWarningMessage())){
                    mView.showWarningMessage(mGroupCreditApp.getWarningMessage());
                }else {
                    mView.showSaveError(resultData.getError());
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("Error save group app: ", e);
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

    @Override
    public void onClickDelete() {
        mView.showDeleteConfirmationDialog();
    }

    @Override
    public void onConfirmDelete() {
        deleteGroupCreditApp(mGroupCreditApp);
    }

    @Override
    public void onRenewOptionChange(boolean checkedOption) {
        if (!checkedOption) {
            mView.toggleReason(true);
        } else {
            mView.toggleReason(false);
            mView.setReason(null);
        }
    }

    @Override
    public void onMemberCreditClick(MemberCreditApp memberCreditApp, boolean isRenew) {
        mView.startMemberCreditApp(memberCreditApp);
    }

    @Override
    public void onMemberCreditAppResult(MemberCreditApp memberCreditApp) {
        mView.updateMemberCredit(memberCreditApp);
        mView.updateAmount();
        mView.updateListLabel();
    }

    @Override
    public void onMemberCreditCheckChange(MemberCreditApp memberCreditApp) {
        if (!memberCreditApp.isPartOfCycle()) {
            mView.showRemoveMemberCreditDialog(memberCreditApp);
        } else {
            mView.updateListLabel();
        }
    }

    @Override
    public void onDecideCheckMemberCredit(MemberCreditApp memberCreditApp, boolean setChecked) {
        if (setChecked) {
            memberCreditApp.setPartOfCycle(true);
        } else {
            memberCreditApp.setPartOfCycle(false);
            memberCreditApp.setRequestAmount(0);
            memberCreditApp.setAuthorizedAmount(0);
        }
        mView.updateMemberCredit(memberCreditApp);
        mView.updateAmount();
        mView.updateListLabel();
    }

    @Override
    public void onTryToExit() {
        if (mGroupCreditApp.getServerId() > 0 && mGroupCreditApp.getStatus() != SyncStatus.SYNCED/* && !mGroupCreditApp.isInProcess()*/) {
            mView.showMessageExit();
        } else {
            mView.exit();
        }
    }

    @Override
    public void onClickLocalSave(GroupCreditApp groupCreditApp) {
        mGroupCreditApp = mGroupCreditApp.buildUpon()
                .setPromotion(groupCreditApp.isPromotion())
                .setReason(groupCreditApp.getReason())
                .setRenew(groupCreditApp.isRenew())
                .setMemberCreditApps(groupCreditApp.getMemberCreditApps())
                .build();
        saveGroupCreditApp(mGroupCreditApp,false, false);
    }

    @Override
    public void onClickConfirmation() {
        saveGroupCreditApp(mGroupCreditApp,true, true);
    }

    private void initGroupCreditApp(GroupCreditApp groupCreditApp) {
        if (groupCreditApp.getServerId() <= 0) {
            mView.showDeleteOption();
        }
        int cycle = groupCreditApp.getCycle();
        String adviser = groupCreditApp.getAdviser();
        String branchOffice = groupCreditApp.getBranchOffice();
        String rate = groupCreditApp.getRate();
        String term = groupCreditApp.getTerm();
        boolean isRenew = groupCreditApp.isRenew();

        mView.toggleCycles(cycle > 0);
        mView.toggleApplicationDate(groupCreditApp.getCreationDate() != null);
        mView.toggleAdviser(StringUtils.isNotEmpty(adviser));
        mView.toggleBranchOffice(StringUtils.isNotEmpty(branchOffice));
        mView.toggleRate(StringUtils.isNotEmpty(rate));
        mView.toggleTerm(StringUtils.isNotEmpty(term));
        mView.toggleRenew(cycle > 1);
        mView.toggleReason(!isRenew && cycle > 1);

        mView.setGroupCreditApp(groupCreditApp);
        mView.updateListLabel();
        mView.setReadOnly(!groupCreditApp.canEdit());
    }

    private boolean validateGroupCreditApp(GroupCreditApp groupCreditApp) {
        boolean isValid = true;

        mView.clearErrors();

        boolean renew = groupCreditApp.isRenew();
        if (!renew && groupCreditApp.getCycle() > 1) {
            String reason = groupCreditApp.getReason();
            if (StringUtils.isEmpty(reason)) {
                isValid = false;
                mView.showReasonError();
            }
        }

        List<MemberCreditApp> memberCreditApps = groupCreditApp.getMemberCreditApps();

        for (MemberCreditApp memberCreditApp : memberCreditApps) {
            if (memberCreditApp.isPartOfCycle() && memberCreditApp.getRequestAmount() <= 0) {
                isValid = false;
                mView.showNoAmountRequestedError();
                break;
            }
        }

        int numMembers = getNumPartOfCycle(memberCreditApps);
        if (numMembers < mMinGroupCreditMembers) {
            isValid = false;
            mView.showMinimumMembersError(mMinGroupCreditMembers);
        } else if (numMembers > mMaxGroupCreditMembers) {
            isValid = false;
            mView.showMaximumMembersError(mMaxGroupCreditMembers);
        }

        return isValid;
    }

    @SuppressLint("CheckResult")
    private void deleteGroupCreditApp(GroupCreditApp groupCreditApp) {
        CreditAppRepository.getInstance().delete(groupCreditApp).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribeWith(new DisposableObserver<Boolean>() {
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

    private int getNumPartOfCycle(List<MemberCreditApp> memberCreditApps) {
        int count = 0;
        for (MemberCreditApp memberCreditApp : memberCreditApps) {
            if (memberCreditApp.isPartOfCycle()) {
                count++;
            }
        }
        return count;
    }
}
