package com.cobis.gestionasesores.presentation.changepin;


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
import com.cobis.gestionasesores.widgets.PinView;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ChangePinFragment extends Fragment implements ChangePinContract.View, PinView.PinListener {

    @BindView(R.id.text_change_pin_message)
    TextView mTextMessage;
    @BindView(R.id.pin_view)
    PinView mPinView;
    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;

    private ProgressDialog mProgressDialog;
    private ChangePinContract.Presenter mPresenter;

    public static ChangePinFragment newInstance() {
        return new ChangePinFragment();
    }
    @Override
    public void setPresenter(ChangePinContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_change_pin,container,false);
        ButterKnife.bind(this,view);
        mPinView.setListener(this);
        mPinView.setDigitView(mDigitsLayout);
        return view;
    }

    @Override
    public void onComplete(String pin) {
        mPresenter.handlePin(pin);
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

    @Override
    public void showRegisterPin() {
        mTextMessage.setText(R.string.change_pin_message_register_pin);
        mPinView.onClearButtonPressed();
    }
    @Override
    public void showLoading() {
        hideLoading();
        mProgressDialog = new ProgressDialog(getContext());
        mProgressDialog.setMessage(getString(R.string.progress_load_msg));
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
        mPinView.onClearButtonPressed();

        if(errorMessage == null){
            errorMessage = getText(R.string.register_pin_error).toString();
        }
        new AlertDialog.Builder(getContext())
                .setMessage(errorMessage)
                .setPositiveButton(R.string.action_accept, null)
                .setCancelable(false)
                .show();
    }

    @Override
    public void showRegisterSuccess() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.change_pin_success)
                .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        getActivity().finish();
                    }
                })
                .setCancelable(false)
                .show();
    }

    @Override
    public void requestPinConfirm() {
        mPinView.onClearButtonPressed();
        mTextMessage.setText(R.string.change_pin_message_register_pin_again);
    }
}
