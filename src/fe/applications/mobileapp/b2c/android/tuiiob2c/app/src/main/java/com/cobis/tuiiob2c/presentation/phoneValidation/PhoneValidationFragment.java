package com.cobis.tuiiob2c.presentation.phoneValidation;


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
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.otpVerification.OtpVerificationActivity;
import com.cobis.tuiiob2c.root.App;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class PhoneValidationFragment extends Fragment implements PhoneValidationMVP.PhoneValidationView{

    @Inject
    public PhoneValidationMVP.PhoneValidationPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.send_button)
    Button mSendButton;
    @BindView(R.id.welcometext)
    TextView mWelcomeText;
    @BindView(R.id.phone)
    EditText mPhone;

    public static PhoneValidationFragment newInstance() {
        Bundle args = new Bundle();
        PhoneValidationFragment fragment = new PhoneValidationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectPhoneValidation(this);
        return inflater.inflate(R.layout.fragment_phone_validation, container, false);
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

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mWelcomeText.setText("Bienvendio, " + SessionManager.getInstance().getValuesEnrollment().getNombres());
        mPhone.setText(SessionManager.getInstance().getValuesEnrollment().getTelefono());
    }

    @OnClick({ R.id.send_button })
    public void click(View view) {
        switch (view.getId()) {
            case R.id.send_button:
                presenter.onClickPhoneValidation(mPhone.getText().toString());
                break;
            default:
                break;
        }
    }

    @Override
    public void showErrorValidateFields() {
        Toast.makeText(getContext(), R.string.error_blank_field, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showPhoneValidationSuccess() {
        Toast.makeText(getContext(), R.string.success_validate, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showPhoneValidationError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void getEnrollmentData() {

    }

    @Override
    public void showValidationScreen() {
        Intent intent = new Intent (getContext(), OtpVerificationActivity.class);
        startActivity(intent);
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
