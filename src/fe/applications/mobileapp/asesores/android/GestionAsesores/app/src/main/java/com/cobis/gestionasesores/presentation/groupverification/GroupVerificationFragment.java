package com.cobis.gestionasesores.presentation.groupverification;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.memberverification.MemberVerificationActivity;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GroupVerificationFragment extends ErrorBaseFragment implements GroupVerificationContract.View, MemberVerificationAdapter.MemberVerificationListener {

    public static final int REQUEST_MEMBER_VERIFICATION = 1;

    @BindView(R.id.list_verification_member)
    RecyclerView mVerificationMemberList;
    @BindView(R.id.text_group_name)
    TextView mGroupNameText;

    private ProgressDialog mProgressDialog;
    private GroupVerificationContract.Presenter mPresenter;
    private MemberVerificationAdapter mAdapter;

    public static GroupVerificationFragment newInstance() {
        Bundle args = new Bundle();
        GroupVerificationFragment fragment = new GroupVerificationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_group_verification, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mAdapter = new MemberVerificationAdapter(this);

        mVerificationMemberList.setLayoutManager(new LinearLayoutManager(getContext()));
        mVerificationMemberList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mVerificationMemberList.setAdapter(mAdapter);

        mPresenter.start();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_MEMBER_VERIFICATION && resultCode == Activity.RESULT_OK) {
            mPresenter.onMemberVerificationResult();
        }
    }

    @Override
    public void setPresenter(GroupVerificationContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showGroupName(String name) {
        mGroupNameText.setVisibility(name == null ? View.GONE : View.VISIBLE);
        mGroupNameText.setText(StringUtils.nullToString(name));
    }

    @Override
    public void showMemberVerifications(List<MemberVerification> memberVerifications) {
        mAdapter.setVerificationMembers(memberVerifications);
    }

    @Override
    public void startMemberVerification(int verificationId, MemberVerification memberVerification) {
        startActivityForResult(MemberVerificationActivity.newIntent(getContext(), verificationId, memberVerification), REQUEST_MEMBER_VERIFICATION);
    }

    @Override
    public void showLoadError() {
        Toast.makeText(getContext(), R.string.operation_fail_message, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showLoadProgress() {
        mProgressDialog = new ProgressDialog(getContext());
        mProgressDialog.setMessage(getString(R.string.progress_load_msg));
        mProgressDialog.setCancelable(false);
        mProgressDialog.setIndeterminate(true);
        mProgressDialog.show();
    }

    @Override
    public void hideProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showMessageValidatedSuccess() {
        Toast.makeText(getContext(), R.string.group_verification_success, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showErrorValidate(String errorMessage) {
        if(StringUtils.isEmpty(errorMessage)){
            errorMessage = getString(R.string.group_verification_complete_error);
        }
        new AlertDialog.Builder(getContext())
                .setMessage(errorMessage)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showTitle(String verificationType) {
        ActionBar actionBar = ((BaseActivity) getActivity()).getSupportActionBar();
        if (verificationType.equals(TaskType.INDIVIDUAL_VERIFICATION)) {
            actionBar.setTitle(R.string.individual_verification_title);
        } else if (verificationType.equals(TaskType.GROUP_VERIFICATION)) {
            actionBar.setTitle(R.string.group_verification_title);
        }
    }

    @Override
    public void onClickMemberVerification(MemberVerification member) {
        mPresenter.onMemberVerificationSelected(member);
    }
}
