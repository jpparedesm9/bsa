package com.cobis.gestionasesores.presentation.groupcredit;

import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.responses.Message;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

public interface GroupCreditContract {

    interface GroupCreditView extends BaseView<GroupCreditPresenter>, ErrorBaseContract.ErrorBaseView {
        void setGroupCreditApp(GroupCreditApp groupCreditApp);

        void toggleCycles(boolean shouldShow);

        void toggleApplicationDate(boolean shouldShow);

        void toggleAdviser(boolean shouldShow);

        void toggleBranchOffice(boolean shouldShow);

        void toggleRate(boolean shouldShow);

        void toggleTerm(boolean shouldShow);

        void toggleRenew(boolean shouldShow);

        void toggleReason(boolean shouldShow);

        void startMemberCreditApp(MemberCreditApp memberCreditApp);

        void setReason(String reason);

        void updateAmount();

        void updateMemberCredit(MemberCreditApp memberCreditApp);

        void clearErrors();

        void showReasonError();

        void showMinimumMembersError(int min);

        void showMaximumMembersError(int max);

        void showNoAmountRequestedError();

        void exit();

        void showCreateSuccess(String message);

        void showSaveError(Message message);

        void showDeleteSuccess();

        void showDeleteError();

        void showDeleteOption();

        void showDeleteConfirmationDialog();

        void updateListLabel();

        void showRemoveMemberCreditDialog(MemberCreditApp memberCreditApp);

        void showSavingProgress();

        void showLoadProgress();

        void hideProgress();

        void showNetworkError();

        void showCustomerNotSyncedError();

        void showMessageExit();

        GroupCreditApp getGroupCreditApp();

        void setReadOnly(boolean isReadOnly);

        void showWarningMessage(String warning);
    }

    interface GroupCreditPresenter extends BasePresenter {
        void onClickSave(GroupCreditApp groupCreditApp);

        void onClickDelete();

        void onConfirmDelete();

        void onRenewOptionChange(boolean checkedOption);

        void onMemberCreditClick(MemberCreditApp memberCreditApp, boolean isRenew);

        void onMemberCreditAppResult(MemberCreditApp memberCreditApp);

        void onMemberCreditCheckChange(MemberCreditApp memberCreditApp);

        void onDecideCheckMemberCredit(MemberCreditApp memberCreditApp, boolean setChecked);

        void onTryToExit();

        void onClickLocalSave(GroupCreditApp groupCreditApp);

        void onClickConfirmation();

    }
}
