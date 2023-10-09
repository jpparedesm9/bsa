package com.cobis.gestionasesores.presentation.login;

import android.Manifest;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.CommonUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.presentation.menu.MenuActivity;
import com.cobis.gestionasesores.presentation.registerdevice.RegisterDeviceActivity;
import com.cobis.gestionasesores.presentation.registerpin.RegisterPinActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Login fragment View
 * Created by Miguel on 04/06/2017.
 */
public class LoginFragment extends Fragment implements LoginContract.View {
    private static final int REQUEST_PERMISSION_PHONE = 100;

    @BindView(R.id.input_username)
    TextInputEditText mInputUserName;
    @BindView(R.id.input_password)
    TextInputEditText mInputPassword;
    @BindView(R.id.input_layout_username)
    TextInputLayout mUsernameInputLayout;
    @BindView(R.id.input_layout_password)
    TextInputLayout mPasswordInputLayout;
    @BindView(R.id.spinner_environment)
    Spinner mEnvironmentSpinner;
    @BindView(R.id.text_version_info)
    TextView mVersionInfoText;

    private LoginContract.Presenter mPresenter;
    private ProgressDialog mProgressDialog;

    private ArrayAdapter<Environment> mAdapter;

    public static LoginFragment newInstance() {
        Bundle args = new Bundle();
        LoginFragment fragment = new LoginFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_login, container, false);
        ButterKnife.bind(this, view);

        mAdapter = new ArrayAdapter<>(getContext(), android.R.layout.simple_spinner_item, Environment.values());
        mAdapter.setDropDownViewResource(android.R.layout.simple_dropdown_item_1line);
        mEnvironmentSpinner.setAdapter(mAdapter);

        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mPresenter.start();
    }

    @OnClick(R.id.button_login)
    public void onLogin(View view) {
        CommonUtils.hideSoftKeyboard(view);
        requestPermissions();
    }

    private void requestPermissions() {
        if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            if (shouldShowRequestPermissionRationale(Manifest.permission.READ_PHONE_STATE)) {
                new AlertDialog.Builder(getContext())
                        .setTitle(R.string.login_title)
                        .setMessage(R.string.permission_phone_denied)
                        .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                requestPermissions(new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_PERMISSION_PHONE);
                            }
                        }).create().show();
            } else {
                requestPermissions(new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_PERMISSION_PHONE);
            }
        } else {
            mPresenter.validateCredentials(mInputUserName.getText().toString(), mInputPassword.getText().toString());
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        if (requestCode == REQUEST_PERMISSION_PHONE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Log.i("Phone Permission granted!!");
            } else {
                Toast.makeText(getContext(), R.string.permission_phone_denied, Toast.LENGTH_LONG).show();
            }
        }
    }

    @Override
    public void setPresenter(LoginContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void navigateMenu() {
        startActivity(MenuActivity.newIntent(getContext()));
        getActivity().finish();
    }

    @Override
    public void clearErrors() {
        mUsernameInputLayout.setErrorEnabled(false);
        mPasswordInputLayout.setErrorEnabled(false);
    }


    @Override
    public void showUserNameError() {
        mUsernameInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showPasswordError() {
        mPasswordInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showLoading() {
        hideLoading();
        mProgressDialog = new ProgressDialog(getContext());
        mProgressDialog.setMessage(getString(R.string.login_loading));
        mProgressDialog.setCancelable(false);
        mProgressDialog.setCanceledOnTouchOutside(false);
        mProgressDialog.show();
    }

    @Override
    public void showError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.login_error)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showMessageError(String message, final boolean isRegistered) {
        new AlertDialog.Builder(getContext())
                .setMessage(message)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        mPresenter.navigateView(isRegistered);
                    }
                })
                .show();
    }

    @Override
    public void hideLoading() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void setEnvironment(Environment environment) {
        int position = mAdapter.getPosition(environment);
        mEnvironmentSpinner.setSelection(position);
        mEnvironmentSpinner.setOnItemSelectedListener(mOnEnvironmentSelectedListener);
    }

    @Override
    public void showEnvironmentSelector(boolean shouldShow) {
        mEnvironmentSpinner.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void showVersionInfo(String versionName, String versionCode) {
        mVersionInfoText.setText(versionName + " (" + versionCode + ")");
    }

    @Override
    public void setUserName(String userName) {
        mInputUserName.setText(userName);
    }

    @Override
    public void setPassword(String password) {
        mInputPassword.setText(password);
    }

    @Override
    public void navigateToRegister() {
        Intent intent = new Intent(getContext(), RegisterDeviceActivity.class);
        startActivity(intent);
        getActivity().finish();
    }

    @Override
    public void navigateToRegisterPin() {
        Intent intent = new Intent(getContext(), RegisterPinActivity.class);
        startActivity(intent);
        getActivity().finish();
    }

    @Override
    public void showError(String message) {
        if (message == null) {
            message = getString(R.string.login_error);
        }
        new AlertDialog.Builder(getContext())
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.error_message_network)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    private AdapterView.OnItemSelectedListener mOnEnvironmentSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            mPresenter.onEnvironmentSelected(mAdapter.getItem(position));
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {
        }
    };
}