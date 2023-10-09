package com.cobis.gestionasesores.presentation.registerpin;


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
import com.cobis.gestionasesores.presentation.menu.MenuActivity;
import com.cobis.gestionasesores.widgets.PinView;

import butterknife.BindView;
import butterknife.ButterKnife;

public class RegisterPinFragment extends Fragment implements RegisterPinContract.RegisterPinView, PinView.PinListener {

    @BindView(R.id.pin_view)
    PinView pinView;

    @BindView(R.id.text_register_message)
    TextView textRegisterMessage;

    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;

    RegisterPinContract.RegisterPinPresenter mPresenter;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_register_pin, container, false);
    }

    @Override
    public void setPresenter(RegisterPinContract.RegisterPinPresenter presenter) {
        mPresenter= presenter;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mPresenter.start();
        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);
    }

    public static RegisterPinFragment newInstance() {
        RegisterPinFragment fragment = new RegisterPinFragment();
        return fragment;
    }

    //When pinView is fulfilled
    @Override
    public void onComplete(String pin) {
        mPresenter.registerPin(pin);
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
    public void promptPinConfirm() {
        pinView.onClearButtonPressed();
        textRegisterMessage.setText(getText(R.string.register_pin_message_confirm).toString());
    }

    @Override
    public void showError(String errorMessage) {
        if(errorMessage == null){
            errorMessage = getText(R.string.register_pin_error).toString();
        }
        new AlertDialog.Builder(getContext())
                .setMessage(errorMessage)
                .setPositiveButton(R.string.action_accept, null)
                .setCancelable(false)
                .show();
        pinView.onClearButtonPressed();
    }

    @Override
    public void navigateToMenu(String message) {
        if (message == null) {
            openMenuActivity();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            openMenuActivity();
                        }
                    })
                    .show();
        }
    }

    private void openMenuActivity() {
        startActivity(MenuActivity.newIntent(getContext()));
        getActivity().finish();
    }
}
