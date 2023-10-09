package com.cobis.gestionasesores.presentation.registerdevice;

import android.Manifest;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AlertDialog;
import android.text.InputFilter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.presentation.registerpin.RegisterPinActivity;
import com.cobis.gestionasesores.widgets.RegexInputFilter;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;


public class RegisterDeviceFragment extends Fragment implements RegisterDeviceContract.RegisterDeviceView {
    private static final int REQUEST_PERMISSION_PHONE = 100;

    @BindView(R.id.input_alias)
    TextInputEditText mInputAlias;
    @BindView(R.id.input_layout_alias)
    TextInputLayout mAliasInputLayout;

    private ProgressDialog mProgressDialog;
    private RegisterDeviceContract.RegisterDevicePresenter mPresenter;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_register_device, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    private void requestPermissions() {
        if (ContextCompat.checkSelfPermission(getContext(), Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
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
                requestPermissions( new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_PERMISSION_PHONE);
            }
        }else{
            mPresenter.registerDevice(mInputAlias.getText().toString());
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String permissions[],@NonNull int[] grantResults) {
        if (requestCode == REQUEST_PERMISSION_PHONE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Log.i("Permission es granted!!");
            } else {
                Toast.makeText(getContext(), R.string.permission_phone_denied, Toast.LENGTH_LONG).show();
            }
        }
    }

    @Override
    public void setPresenter(RegisterDeviceContract.RegisterDevicePresenter presenter) {
        mPresenter = presenter;
    }

    public static RegisterDeviceFragment newInstance() {
        Bundle args = new Bundle();
        RegisterDeviceFragment fragment = new RegisterDeviceFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mInputAlias.setFilters(new InputFilter[]{
                new RegexInputFilter(RegexInputFilter.REGEX_LETTERS_AND_NUMBERS),
                new InputFilter.AllCaps(),
                new InputFilter.LengthFilter(BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_LENGTH_ALIAS))
        });
        mPresenter.start();
    }

    @OnClick(R.id.button_alias)
    public void registerDevice(View view) {
        requestPermissions();
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
    public void hideLoading() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void navigateToRegisterPin(String message) {
        if (message == null) {
            startActivity(RegisterPinActivity.NewIntent(getContext()));
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            startActivity(RegisterPinActivity.NewIntent(getContext()));
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.error_message_network)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showError(String errorMessage) {
        if (errorMessage == null) {
            errorMessage = getText(R.string.register_device_error).toString();
        }
        new AlertDialog.Builder(getContext())
                .setMessage(errorMessage)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showErrorLength(int min,int max) {
        mAliasInputLayout.setError(getString(R.string.register_device_length_error, min,max));
    }

    @Override
    public void clearError() {
        mAliasInputLayout.setErrorEnabled(false);
    }
}
