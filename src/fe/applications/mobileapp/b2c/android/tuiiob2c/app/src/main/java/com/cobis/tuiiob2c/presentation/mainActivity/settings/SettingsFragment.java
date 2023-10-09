package com.cobis.tuiiob2c.presentation.mainActivity.settings;


import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.BaseActivity;
import com.cobis.tuiiob2c.presentation.changePassword.ChangePasswordActivity;
import com.cobis.tuiiob2c.presentation.login.LoginActivity;
import com.cobis.tuiiob2c.presentation.splash.SplashActivity;
import com.cobis.tuiiob2c.root.App;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class SettingsFragment extends Fragment implements SettingsMVP.SettingsView {

    @Inject
    public SettingsMVP.SettingsPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.changepassword)
    LinearLayout mChangePasswordLL;
    @BindView(R.id.blockaccount)
    LinearLayout mBlockAccountLL;
    @BindView(R.id.logout)
    LinearLayout mLogOutLL;

    public static SettingsFragment newInstance() {
        Bundle args = new Bundle();
        SettingsFragment fragment = new SettingsFragment();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectSettings(this);

        return inflater.inflate(R.layout.fragment_settings, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mChangePasswordLL.setOnClickListener(view1 -> {
            Intent intent = new Intent(getContext(), ChangePasswordActivity.class);
            startActivity(intent);
        });
        mBlockAccountLL.setOnClickListener(view12 -> {
            new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                    .setTitle(R.string.app_name)
                    .setMessage(R.string.question_account_lock)
                    .setPositiveButton(R.string.action_accept, (dialog, which) -> {
                        presenter.onLock();
                    })
                    .setNegativeButton(R.string.action_cancel, (dialog, which) -> {
                        dialog.dismiss();
                    })
                    .show();
        });
        mLogOutLL.setOnClickListener(view13 -> {
            Intent intent = new Intent(getContext(), LoginActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent);
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
        presenter.start();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        presenter.unSuscribe();
    }

    @Override
    public void showLockSuccess() {
        new AlertDialog.Builder(getContext())
                .setTitle(R.string.app_name)
                .setMessage(R.string.lock_account_success)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, (dialog, which) -> {
                    Intent intent = new Intent(getContext(), LoginActivity.class);
                    startActivity(intent);
                    Objects.requireNonNull(getActivity()).finish();
                })
                .show();
    }

    @Override
    public void showLockResponseError(String message) {
        Toast.makeText(getContext(), message, Toast.LENGTH_LONG).show();
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
