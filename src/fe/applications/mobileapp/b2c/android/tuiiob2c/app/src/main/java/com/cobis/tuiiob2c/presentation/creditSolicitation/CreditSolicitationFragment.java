package com.cobis.tuiiob2c.presentation.creditSolicitation;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.models.CommissionCalculateValues;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.presentation.otpCreditVerification.OtpCreditVerificationActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.utils.Constants;

import java.text.DecimalFormat;
import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class CreditSolicitationFragment extends Fragment implements CreditSolicitationMVP.CreditSolicitationView{
    @Inject
    public CreditSolicitationMVP.CreditSolicitationPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.value_edittext)
    EditText mValue;
    @BindView(R.id.exitImageButton)
    ImageButton mExitImageButton;
    @BindView(R.id.comision_textView)
    TextView mComitionTextView;
    @BindView(R.id.iva_textview)
    TextView mIvaTextView;
    @BindView(R.id.valor_result_textview)
    TextView mResultTextView;

    @BindView(R.id.send_button)
    Button mSendButton;

    @BindView(R.id.loan_text)
    TextView mLoanTextView;

    private LoanInfoResponse loanInfo;

    private DecimalFormat decimalFormat;

    private static final String LOAN = "LOAN";

    public static CreditSolicitationFragment newInstance(LoanInfoResponse loanInfo) {
        Bundle args = new Bundle();
        args.putSerializable(LOAN, loanInfo);
        CreditSolicitationFragment fragment = new CreditSolicitationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectCreditSolicitation(this);

        if (getArguments() != null) {
            loanInfo = (LoanInfoResponse) getArguments().getSerializable(LOAN);
        }

        decimalFormat = new DecimalFormat(Constants.DECIMAL_FORMAT);

        return inflater.inflate(R.layout.fragment_credit_solicitation, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mLoanTextView.setText(decimalFormat.format(loanInfo.getData().getLineaCredito()));
    }

    @OnClick({ R.id.exitImageButton, R.id.send_button })
    public void click(View view) {
        switch (view.getId()) {
            case R.id.exitImageButton:
                Objects.requireNonNull(getActivity()).finish();
                break;
            case R.id.send_button:
                mValue.setError(null);
                presenter.saveLoanDispersion(mValue.getText().toString());
                break;
            default:
                break;
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
        presenter.setLoanInfo(loanInfo);

        mValue.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                presenter.calculateCommissionValues(s.toString().trim());
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        presenter.unSuscribe();
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
    public void setCalculateValues(CommissionCalculateValues commissionCalculateValues) {
        mComitionTextView.setText(commissionCalculateValues.getCommission());
        mIvaTextView.setText(commissionCalculateValues.getIva());
        mResultTextView.setText(commissionCalculateValues.getValueToReceive());
    }

    @Override
    public void showCalculateDispersionSuccess() {
        Intent intent = new Intent(getContext(), OtpCreditVerificationActivity.class);
        startActivity(intent);
        Objects.requireNonNull(getActivity()).finish();
    }

    @Override
    public void showCalculateDispersionError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showErrorZeroAmount() {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(getString(R.string.error_dispersion_is_zero))
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showErrorMaxPermittedAmount(double amount) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(getString(R.string.error_permitted_amount, amount))
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showErrorMinPermittedAmount(double amount) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(getString(R.string.error_permitted_amount_2, amount))
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showErrorValidateFields() {
        mValue.setError(getString(R.string.error_blank_field));
    }
}
