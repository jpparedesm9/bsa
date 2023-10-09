package com.cobis.tuiiob2c.presentation.changePassword;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.login.LoginActivity;
import com.cobis.tuiiob2c.root.App;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class ChangePasswordFragment extends Fragment implements ChangePasswordMVP.ChangePasswordView {

    @Inject
    public ChangePasswordMVP.ChangePasswordPresenter presenter;

    @BindView(R.id.old_pass)
    EditText mOldPass;
    @BindView(R.id.new_pass)
    EditText mNewpass;
    @BindView(R.id.repetpass)
    EditText mRepetpass;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.send_button)
    Button mSendButton;

    public static ChangePasswordFragment newInstance() {
        Bundle args = new Bundle();
        ChangePasswordFragment fragment = new ChangePasswordFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectChangePassword(this);

        return inflater.inflate(R.layout.fragment_change_password, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        ButterKnife.bind(this, view);
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        presenter.unSuscribe();
    }

    @OnClick({ R.id.send_button })
    public void click(View view) {
        switch (view.getId()) {
            case R.id.send_button:
                presenter.onClickValidateCreatePassword(mOldPass.getText().toString(), mNewpass.getText().toString(), mRepetpass.getText().toString());
                break;
            default:
                break;
        }
    }

    @Override
    public void showChangePasswordSuccess() {
        Intent intent = new Intent(getContext(), LoginActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
        Objects.requireNonNull(getActivity()).finish();
    }

    @Override
    public void showChangePasswordError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showLoading() {
        mProgressll.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideLoading() {
        mProgressll.setVisibility(View.GONE);
    }
}
