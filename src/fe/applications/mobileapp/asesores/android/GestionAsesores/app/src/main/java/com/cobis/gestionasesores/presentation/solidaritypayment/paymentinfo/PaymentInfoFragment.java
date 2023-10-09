package com.cobis.gestionasesores.presentation.solidaritypayment.paymentinfo;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PaymentInfoFragment extends Fragment implements PaymentInfoContract.View {

    private PaymentInfoContract.Presenter mPresenter;

    @BindView(R.id.input_cycle_number)
    TextInputEditText mCycleEditText;
    @BindView(R.id.input_rate)
    TextInputEditText mRateEditText;
    @BindView(R.id.input_term)
    TextInputEditText mTermEditText;
    @BindView(R.id.input_guarantee_balance)
    CurrencyInputEditText mGuaranteeBalanceEditText;
    @BindView(R.id.input_overdue_payments)
    TextInputEditText mOverduePaymentsEditText;
    @BindView(R.id.input_next_due_date)
    TextInputEditText mNextDueDateEditText;

    public static PaymentInfoFragment newInstance() {
        Bundle args = new Bundle();
        PaymentInfoFragment fragment = new PaymentInfoFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_payment_info, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mGuaranteeBalanceEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mPresenter.start();
    }

    @Override
    public void setPresenter(PaymentInfoContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setSolidarityPayment(SolidarityPayment payment) {
        mCycleEditText.setText(String.valueOf(payment.getCycle()));
        mRateEditText.setText(payment.getRate());
        mTermEditText.setText(payment.getTerm());
        mGuaranteeBalanceEditText.setCurrencyValue(payment.getGuaranteeBalance());
        mOverduePaymentsEditText.setText(String.valueOf(payment.getOverduePayments()));
        mNextDueDateEditText.setText(DateUtils.formatDate(payment.getNextDueDate()));
        mNextDueDateEditText.setTag(payment.getNextDueDate());
    }
}