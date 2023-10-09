package com.cobis.gestionasesores.presentation.groupcredit;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SwitchCompat;
import android.text.method.KeyListener;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.responses.Message;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.membercredit.MemberCreditActivity;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyTextFormatter;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GroupCreditFragment extends ErrorBaseFragment implements GroupCreditContract.GroupCreditView {
    private static final int REQUEST_MEMBER_CREDIT_APP = 1;

    @BindView(R.id.input_layout_group_name)
    TextInputLayout mGroupNameInputLayout;
    @BindView(R.id.input_layout_cycle_number)
    TextInputLayout mCycleNumberInputLayout;
    @BindView(R.id.input_layout_application_date)
    TextInputLayout mApplicationDateInputLayout;
    @BindView(R.id.input_layout_adviser)
    TextInputLayout mAdviserInputLayout;
    @BindView(R.id.input_layout_branch_office)
    TextInputLayout mBranchOfficeInputLayout;
    @BindView(R.id.input_layout_rate)
    TextInputLayout mRateInputLayout;
    @BindView(R.id.input_layout_term)
    TextInputLayout mTermInputLayout;
    @BindView(R.id.input_layout_reason)
    TextInputLayout mReasonInputLayout;

    @BindView(R.id.input_group_name)
    TextInputEditText mGroupNameEditText;
    @BindView(R.id.input_cycle_number)
    TextInputEditText mCycleNumberEditText;
    @BindView(R.id.input_application_date)
    TextInputEditText mApplicationDateEditText;
    @BindView(R.id.input_adviser)
    TextInputEditText mAdviserEditText;
    @BindView(R.id.input_branch_office)
    TextInputEditText mBranchOfficeEditText;
    @BindView(R.id.input_rate)
    TextInputEditText mRateEditText;
    @BindView(R.id.input_term)
    TextInputEditText mTermEditText;
    @BindView(R.id.input_reason)
    TextInputEditText mReasonEditText;

    @BindView(R.id.text_credit_amount)
    TextView mCreditAmountText;
    @BindView(R.id.text_error)
    TextView mErrorText;
    @BindView(R.id.text_list_label)
    TextView mListLabelText;

    @BindView(R.id.switch_is_promotion)
    SwitchCompat mIsPromotionSwitch;
    @BindView(R.id.switch_renew)
    SwitchCompat mRenewSwitch;

    @BindView(R.id.list_member_credits)
    RecyclerView mMemberCreditsList;

    @BindView(R.id.view_renew)
    View mRenewView;

    private MemberCreditAdapter mAdapter;
    private ProgressDialog mProgressDialog;
    private boolean mShowDeleteOption = false;
    private boolean mShowOptionsMenu = true;

    private KeyListener mKeyListener;

    private GroupCreditContract.GroupCreditPresenter mPresenter;

    public static GroupCreditFragment newInstance() {
        Bundle args = new Bundle();
        GroupCreditFragment fragment = new GroupCreditFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_group_credit, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mAdapter = new MemberCreditAdapter(getContext(), mMemberCreditListener);
        mMemberCreditsList.setLayoutManager(new LinearLayoutManager(getContext()));
        mMemberCreditsList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mMemberCreditsList.setAdapter(mAdapter);

        mRenewSwitch.setOnClickListener(mOnRenewChangeListener);

        mKeyListener = mReasonEditText.getKeyListener();

        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.group_credit_app, menu);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        if (!mShowOptionsMenu) {
            menu.clear();
        } else {
            menu.findItem(R.id.menu_delete).setVisible(mShowDeleteOption);
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_group:
                mPresenter.onClickSave(getGroupCreditApp());
                return true;
            case R.id.menu_delete:
                mPresenter.onClickDelete();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_MEMBER_CREDIT_APP && resultCode == Activity.RESULT_OK) {
            mPresenter.onMemberCreditAppResult((MemberCreditApp) data.getSerializableExtra(MemberCreditActivity.EXTRA_MEMBER_CREDIT));
        }
    }

    @Override
    public void setPresenter(GroupCreditContract.GroupCreditPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setGroupCreditApp(GroupCreditApp groupCreditApp) {
        mGroupNameEditText.setText(groupCreditApp.getApplicantName());
        mCycleNumberEditText.setText(String.valueOf(groupCreditApp.getCycle()));
        mApplicationDateEditText.setTag(groupCreditApp.getCreationDate());
        mApplicationDateEditText.setText(DateUtils.formatDate(groupCreditApp.getCreationDate()));
        mAdviserEditText.setText(String.valueOf(groupCreditApp.getAdviser()));
        mBranchOfficeEditText.setText(String.valueOf(groupCreditApp.getBranchOffice()));
        mCreditAmountText.setText(CurrencyTextFormatter.formatText(groupCreditApp.getAmount(), BankAdvisorApp.getInstance().getConfig().getLocale()));
        mRateEditText.setText(groupCreditApp.getRate());
        mTermEditText.setText(groupCreditApp.getTerm());
        mIsPromotionSwitch.setChecked(groupCreditApp.isPromotion());
        mRenewSwitch.setChecked(groupCreditApp.isRenew());
        mReasonEditText.setText(groupCreditApp.getReason());
        mAdapter.setMemberCredits(groupCreditApp.getMemberCreditApps());
    }

    @Override
    public void toggleCycles(boolean shouldShow) {
        mCycleNumberInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleApplicationDate(boolean shouldShow) {
        mApplicationDateInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleAdviser(boolean shouldShow) {
        mAdviserInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleBranchOffice(boolean shouldShow) {
        mBranchOfficeInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleRate(boolean shouldShow) {
        mRateInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleTerm(boolean shouldShow) {
        mTermInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleRenew(boolean shouldShow) {
        mRenewView.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleReason(boolean shouldShow) {
        if (!shouldShow) {
            mReasonEditText.setKeyListener(null);
            mReasonInputLayout.setVisibility(View.GONE);
        } else {
            mReasonEditText.setKeyListener(mKeyListener);
            mReasonInputLayout.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void startMemberCreditApp(MemberCreditApp memberCreditApp) {
        startActivityForResult(MemberCreditActivity.newIntent(getContext(), memberCreditApp), REQUEST_MEMBER_CREDIT_APP);
    }

    @Override
    public void setReason(String reason) {
        mReasonEditText.setText(reason);
    }

    @Override
    public void updateAmount() {
        mCreditAmountText.setText(CurrencyTextFormatter.formatText(getGroupCreditApp().getAmount(), BankAdvisorApp.getInstance().getConfig().getLocale()));
    }

    @Override
    public void updateMemberCredit(MemberCreditApp memberCreditApp) {
        mAdapter.updateMemberCredit(memberCreditApp);
    }

    @Override
    public void clearErrors() {
        mReasonInputLayout.setErrorEnabled(false);

        mErrorText.setError(null);
        mErrorText.setVisibility(View.GONE);
    }

    @Override
    public void showReasonError() {
        mReasonInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showMinimumMembersError(int min) {
        showMembersError(getString(R.string.credit_app_group_error_min_members));
    }

    @Override
    public void showMaximumMembersError(int max) {
        showMembersError(getString(R.string.credit_app_group_error_max_members, max));
    }

    @Override
    public void showNoAmountRequestedError() {
        showMembersError(getString(R.string.credit_app_group_error_no_amount_requested));
    }

    @Override
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void showCreateSuccess(String message) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.credit_app_save_message), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            exit();
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showSaveError(Message message) {
        String msg;
        if (message != null && StringUtils.isNotEmpty(message.getMessage())) {
            msg = message.getMessage();
        } else {
            msg = getString(R.string.error_save);
        }

        new AlertDialog.Builder(getContext()).setMessage(msg).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showDeleteSuccess() {
        Toast.makeText(getContext(), getString(R.string.credit_app_deleted_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showDeleteError() {
        Toast.makeText(getContext(), getString(R.string.credit_app_failure_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showDeleteOption() {
        mShowDeleteOption = true;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showDeleteConfirmationDialog() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.credit_app_dialog_delete).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
                mPresenter.onConfirmDelete();
            }
        }).setNegativeButton(R.string.action_cancel, null).show();
    }

    @Override
    public void updateListLabel() {
        mListLabelText.setText(getString(R.string.credit_app_group_members_title, mAdapter.getCheckedCount(), mAdapter.getItemCount()));
    }

    @Override
    public void showRemoveMemberCreditDialog(final MemberCreditApp memberCreditApp) {
        new AlertDialog.Builder(getContext()).setMessage(R.string.member_credit_msg_remove).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                mPresenter.onDecideCheckMemberCredit(memberCreditApp, false);
            }
        }).setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                mPresenter.onDecideCheckMemberCredit(memberCreditApp, true);
            }
        }).show();
    }

    @Override
    public void showSavingProgress() {
        showProgress(getString(R.string.progress_save_msg));
    }

    @Override
    public void showLoadProgress() {
        showProgress(getString(R.string.progress_load_msg));
    }

    @Override
    public void hideProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.error_message_network).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showCustomerNotSyncedError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.credit_app_group_sync_customer_error)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showMessageExit() {
        new AlertDialog.Builder(getContext()).setTitle(R.string.credit_app_group_title).setMessage(R.string.credit_app_exit_message).setCancelable(false).setPositiveButton(R.string.action_save, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
//                mPresenter.onClickLocalSave();
                mPresenter.onClickLocalSave(getGroupCreditApp());
            }
        }).setNegativeButton(R.string.action_discard, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                exit();
            }
        }).show();
    }

    private View.OnClickListener mOnRenewChangeListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            mPresenter.onRenewOptionChange(mRenewSwitch.isChecked());
        }
    };

    private MemberCreditAdapter.MemberCreditListener mMemberCreditListener = new MemberCreditAdapter.MemberCreditListener() {
        @Override
        public void onClick(MemberCreditApp memberCreditApp) {
            mPresenter.onMemberCreditClick(memberCreditApp, mRenewSwitch.isChecked());
        }

        @Override
        public void onChangeCheck(MemberCreditApp memberCreditApp) {
            mPresenter.onMemberCreditCheckChange(memberCreditApp);
        }
    };

    private void showMembersError(String error) {
        mErrorText.setVisibility(View.VISIBLE);
        mErrorText.setText(error);
    }

    @Override
    public GroupCreditApp getGroupCreditApp() {
        return new GroupCreditApp.Builder()
                .setPromotion(mIsPromotionSwitch.isChecked())
                .setReason(mReasonEditText.getText().toString())
                .setRenew(mRenewSwitch.isChecked())
                .setMemberCreditApps(mAdapter.getMemberCredits())
                .build();
    }

    @Override
    public void setReadOnly(boolean isReadOnly) {
        if (isReadOnly) {
            mShowOptionsMenu = false;
            getActivity().invalidateOptionsMenu();
            mIsPromotionSwitch.setEnabled(false);
            mReasonEditText.setEnabled(false);
            mRenewSwitch.setEnabled(false);
        }
        mAdapter.setReadOnly(isReadOnly);
    }

    @Override
    public void showWarningMessage(String warning) {
        new AlertDialog.Builder(getContext())
                .setTitle(R.string.warning)
                .setMessage(getString(R.string.credit_app_warning_tpl, warning))
                .setCancelable(false)
                .setPositiveButton(R.string.action_next, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        mPresenter.onClickConfirmation();
                    }
                })
                .setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                    }
                })
                .show();
    }

    private void showProgress(String message){
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(message);
            mProgressDialog.setCancelable(false);
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.show();
        }
    }
}
