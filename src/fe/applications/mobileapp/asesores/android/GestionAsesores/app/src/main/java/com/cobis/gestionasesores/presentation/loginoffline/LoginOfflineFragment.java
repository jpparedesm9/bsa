package com.cobis.gestionasesores.presentation.loginoffline;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.presentation.login.LoginActivity;
import com.cobis.gestionasesores.presentation.menu.MenuActivity;
import com.cobis.gestionasesores.widgets.PinView;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class LoginOfflineFragment extends Fragment implements LoginOfflineContract.LoginOfflineView, PinView.PinListener {

    @BindView(R.id.text_login_current_user_prefix)
    TextView mTextCurrentUser;

    @BindView(R.id.pin_view)
    PinView pinView;

    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;

    private ProgressDialog mProgressDialog;
    private LoginOfflineContract.LoginOfflinePresenter mPresenter;

    public LoginOfflineFragment() {}

    @Override
    public void setPresenter(LoginOfflineContract.LoginOfflinePresenter presenter) {
        mPresenter = presenter;
    }

    public static LoginOfflineFragment newInstance() {
        return new LoginOfflineFragment();
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_login_offline, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mPresenter.start();
        mTextCurrentUser.setText(getString(R.string.login_offline_current_user, SessionManager.getInstance().getLastUserLogin()));
        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);

    }

    @Override
    public void navigateToMenu() {
        startActivity(MenuActivity.newIntent(getContext()));
        getActivity().finish();
    }

    @Override
    public void navigateToLogin() {
        startActivity(LoginActivity.newIntent(getContext()));
        getActivity().finish();
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
    public void showError(String errorMessage) {
        if(errorMessage == null){
            errorMessage = getText(R.string.login_offline_error).toString();
        }
        new AlertDialog.Builder(getContext())
                .setMessage(errorMessage)
                .setPositiveButton(R.string.action_accept, null)
                .setCancelable(false)
                .show();
        pinView.onClearButtonPressed();
    }

    @Override
    public void showChangeUserError() {
        showError(getText(R.string.login_offline_change_user_message).toString());
    }

    @Override
    public void startLoginOnline() {
        startActivity(LoginActivity.newIntent(getContext()));
    }

    //When PinView INPUT is filled
    @Override
    public void onComplete(String pin) {
        mPresenter.validatePIN(pin);
    }

    @Override
    public void onNumberPressed(String key) {
    }

    @Override
    public void onDeleteAll() {
    }

    @Override
    public void onDelete(String actualPin) {
    }

    @OnClick(R.id.button_login_offline_change_user)
    public void showChangeUser(){
        mPresenter.onChangeUser();
    }

    @OnClick(R.id.button_login_offline_forgot_pin)
    public void forgotPin() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.login_offline_forgot_pin_message)
                .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        mPresenter.forgotPin();

                    }
                })
                .setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                    }
                })
                .setCancelable(false)
                .show();
    }
}
