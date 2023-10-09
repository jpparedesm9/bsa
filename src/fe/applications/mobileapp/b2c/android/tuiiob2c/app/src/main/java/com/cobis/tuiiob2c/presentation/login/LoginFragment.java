package com.cobis.tuiiob2c.presentation.login;


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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.presentation.forgotPassword.ForgotPasswordActivity;
import com.cobis.tuiiob2c.presentation.mainActivity.MainActivity;
import com.cobis.tuiiob2c.presentation.splash.SplashActivity;
import com.cobis.tuiiob2c.presentation.unlock.UnlockActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.widgets.PinView;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class LoginFragment extends Fragment implements PinView.PinListener, LoginMVP.LoginView {

    @Inject
    public LoginMVP.LoginPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.pin_view)
    PinView pinView;
    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;
    @BindView(R.id.forgot_pass)
    Button mForgotPassword;
    @BindView(R.id.spinner_environment)
    Spinner mEnvironmentSpinner;
    @BindView(R.id.text_version_info)
    TextView mVersionInfoText;

    private ArrayAdapter<Environment> mAdapter;

    public static LoginFragment newInstance() {
        Bundle args = new Bundle();
        LoginFragment fragment = new LoginFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectLogin(this);

        return inflater.inflate(R.layout.fragment_login, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);

        mAdapter = new ArrayAdapter<>(Objects.requireNonNull(getContext()), android.R.layout.simple_spinner_item, Environment.values());
        mAdapter.setDropDownViewResource(android.R.layout.simple_dropdown_item_1line);
        mEnvironmentSpinner.setAdapter(mAdapter);
    }

    @OnClick({ R.id.forgot_pass })
    public void click(View view) {
        switch (view.getId()) {
            case R.id.forgot_pass:
                Intent intent = new Intent(getContext(), ForgotPasswordActivity.class);
                startActivity(intent);
                break;
            default:
                break;
        }
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
    public void onComplete(String var1) {
        presenter.onClickValidatePin(var1);
        pinView.clear();
    }

    @Override
    public void showAuthSuccess() {
        Intent intent = new Intent(getContext(), MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
        Objects.requireNonNull(getActivity()).finish();
    }

    @Override
    public void showAuthError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showVersionInfo(String versionName, String versionCode) {
        mVersionInfoText.setText(versionName + " (" + versionCode + ")");
    }

    @Override
    public void setEnvironment(Environment environment) {
        int position = mAdapter.getPosition(environment);
        mEnvironmentSpinner.setSelection(position, false);
        mEnvironmentSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                presenter.onEnvironmentSelected(mAdapter.getItem(position));
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    }

    @Override
    public void showEnvironmentSelector(boolean shouldShow) {
        mEnvironmentSpinner.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void restartAppForEnviroment() {
        startActivity(SplashActivity.newIntent(getContext()));
    }

    @Override
    public void showUserLocked() {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(R.string.error_account_lock)
                .setPositiveButton(R.string.action_accept, (dialog, which) -> new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                        .setTitle(R.string.app_name)
                        .setMessage(R.string.lock_account_questions)
                        .setPositiveButton(R.string.action_accept, (dialog1, which1) -> {
                            Intent intent = new Intent(getContext(), UnlockActivity.class);
                            startActivity(intent);
                        })
                        .setNegativeButton(R.string.action_cancel, (dialog12, which12) -> dialog12.dismiss())
                        .show())
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

    @Override
    public void onNumberPressed(String var1) {

    }

    @Override
    public void onDeleteAll() {

    }

    @Override
    public void onDelete(String var1) {

    }
}
