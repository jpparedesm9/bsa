package com.cobis.gestionasesores.presentation.solidaritypayment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.bayteq.libcore.util.CommonUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.utils.Util;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;

import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by Jose on 8/21/2017.
 */

public class PaymentDialog extends DialogFragment {

    private static final String ARG_SUGGESTED_AMOUNT = "arg_suggested_amount";
    private static final String ARG_SOLIDARITY_MEMBER = "arg_solidarity_member";

    @BindView(R.id.btn_accept)
    Button mAcceptBtn;
    @BindView(R.id.btn_cancel)
    Button mCancelBtn;
    @BindView(R.id.input_payment)
    CurrencyInputEditText mPaymentEditText;

    private PaymentListener mListener;

    private SolidarityMember mSolidarityMember;
    private double mSuggestedAmount;

    public static PaymentDialog newInstance(SolidarityMember solidarityMember, double suggestedAmount) {
        Bundle args = new Bundle();
        args.putDouble(ARG_SUGGESTED_AMOUNT, suggestedAmount);
        args.putSerializable(ARG_SOLIDARITY_MEMBER, solidarityMember);
        PaymentDialog fragment = new PaymentDialog();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mSuggestedAmount = getArguments().getDouble(ARG_SUGGESTED_AMOUNT);
        mSolidarityMember = (SolidarityMember) getArguments().getSerializable(ARG_SOLIDARITY_MEMBER);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.dialog_payment, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        Locale locale = BankAdvisorApp.getInstance().getConfig().getLocale();
        mPaymentEditText.setLocale(locale);

        mPaymentEditText.setCurrencyValue(mSolidarityMember.getPaymentAmount() == 0 ? mSuggestedAmount : mSolidarityMember.getPaymentAmount());

        mPaymentEditText.requestFocus();
        Util.toggleSoftKeyboard(mPaymentEditText);
    }

    @Override
    public void onStart() {
        super.onStart();
        getDialog().getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mListener = null;
    }

    @OnClick(R.id.btn_accept)
    public void onClickAccept(View view) {
        if (mListener != null) {
            mSolidarityMember.setPaymentAmount(mPaymentEditText.getCurrencyValue());
            mListener.onAcceptPayment(mSolidarityMember);
        }
        CommonUtils.hideSoftKeyboard(mPaymentEditText);
        dismiss();
    }

    @OnClick(R.id.btn_cancel)
    public void onClickCancel(View view) {
        CommonUtils.hideSoftKeyboard(mPaymentEditText);
        dismiss();
    }

    public void setListener(PaymentListener listener) {
        mListener = listener;
    }

    public interface PaymentListener {
        void onAcceptPayment(SolidarityMember member);
    }
}
