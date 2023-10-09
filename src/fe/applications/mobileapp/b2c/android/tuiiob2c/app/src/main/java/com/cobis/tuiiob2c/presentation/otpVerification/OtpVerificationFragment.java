package com.cobis.tuiiob2c.presentation.otpVerification;


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
import android.widget.LinearLayout;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.createPassword.CreatePasswordActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.widgets.PinView;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class OtpVerificationFragment extends Fragment implements PinView.PinListener, OtpVerificationMVP.OtpVerificationView {

    @Inject
    public OtpVerificationMVP.OtpVerificationPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.pin_view)
    PinView pinView;
    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;
    @BindView(R.id.resend_pass)
    Button mResendPass;

    public static OtpVerificationFragment newInstance() {
        Bundle args = new Bundle();
        OtpVerificationFragment fragment = new OtpVerificationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectOtpVerification(this);

        return inflater.inflate(R.layout.fragment_otp_verification, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        ButterKnife.bind(this, view);

        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);

        mResendPass.setOnClickListener(view1 -> Objects.requireNonNull(getActivity()).onBackPressed());
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
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
    public void showErrorValidateFields() {
        Toast.makeText(getContext(), R.string.error_blank_field, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showValidateOtpSuccess() {
        Intent intent = new Intent(getContext(), CreatePasswordActivity.class);
        startActivity(intent);
    }

    @Override
    public void showValidateOtpError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void onComplete(String var1) {
        presenter.onClickValidateOtp(var1);
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
