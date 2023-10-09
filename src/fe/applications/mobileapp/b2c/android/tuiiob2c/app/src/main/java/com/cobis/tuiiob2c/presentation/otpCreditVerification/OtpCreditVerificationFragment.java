package com.cobis.tuiiob2c.presentation.otpCreditVerification;


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
import com.cobis.tuiiob2c.presentation.solicitationAproved.AprovedActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.widgets.PinView;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class OtpCreditVerificationFragment extends Fragment implements PinView.PinListener, OtpCreditVerificationMVP.OtpCreditVerificationView {

    @Inject
    public OtpCreditVerificationMVP.OtpCreditVerificationPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.pin_view)
    PinView pinView;
    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;
//    @BindView(R.id.resend_pass)
//    Button mResendPass;

    public static OtpCreditVerificationFragment newInstance() {
        Bundle args = new Bundle();
        OtpCreditVerificationFragment fragment = new OtpCreditVerificationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectOtpCreditVerification(this);

        return inflater.inflate(R.layout.fragment_credit_confirmation, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        ButterKnife.bind(this, view);

        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);

//        mResendPass.setOnClickListener(view1 -> Objects.requireNonNull(getActivity()).onBackPressed());
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
    public void showOtpVerificationSuccess() {
        Intent intent = new Intent(getContext(), AprovedActivity.class);
        startActivity(intent);
        Objects.requireNonNull(getActivity()).finish();
    }

    @Override
    public void showOtpVerificationError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void onComplete(String var1) {
        presenter.otpTokenVerification(var1);
        pinView.clear();
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
