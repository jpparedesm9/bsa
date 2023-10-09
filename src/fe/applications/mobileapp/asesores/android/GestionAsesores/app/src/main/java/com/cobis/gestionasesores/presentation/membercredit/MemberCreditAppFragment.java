package com.cobis.gestionasesores.presentation.membercredit;

import android.app.Activity;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.SwitchCompat;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.utils.ResourcesUtil;
import com.cobis.gestionasesores.widgets.GaugeView;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MemberCreditAppFragment extends Fragment implements MemberCreditAppContract.View {
    @BindView(R.id.input_name)
    TextInputEditText mCustomerNameText;
    @BindView(R.id.input_cycle_in_group)
    TextInputEditText mCycleInGroupText;
    @BindView(R.id.input_client_number)
    TextInputEditText mCustomerNumberText;
    @BindView(R.id.input_request_amount)
    CurrencyInputEditText mRequestAmountEditText;
    @BindView(R.id.input_auth_amount)
    CurrencyInputEditText mAuthAmountEditText;
    @BindView(R.id.input_warranty)
    CurrencyInputEditText mWarrantyEditText;
    @BindView(R.id.input_proposed_amount)
    CurrencyInputEditText mProposedEditText;
    @BindView(R.id.gauge_risk_level)
    GaugeView mRiskLevelGaugeView;
    @BindView(R.id.switch_is_part_cycle)
    SwitchCompat mPartOfCycleSwitchView;
    @BindView(R.id.container_request)
    View mRequestAppView;
    @BindView(R.id.container_risk_level)
    View mRiskLevelView;
    @BindView(R.id.input_layout_request_amount)
    TextInputLayout mRequestAmountInputLayout;
    @BindView(R.id.input_layout_proposed_amount)
    TextInputLayout mProposedInputLayout;

    private MemberCreditAppContract.Presenter mPresenter;

    public static MemberCreditAppFragment newInstance() {
        Bundle args = new Bundle();
        MemberCreditAppFragment fragment = new MemberCreditAppFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_member_credit, container, false);
        ButterKnife.bind(this, view);
        return view;
    }


    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mRequestAmountEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mAuthAmountEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mWarrantyEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mProposedEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mAuthAmountEditText.addTextChangedListener(mAuthAmountTextWatcher);
        mPartOfCycleSwitchView.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    toggleRequestView(true);
                }else{
                    new AlertDialog.Builder(getContext())
                            .setMessage(R.string.member_credit_msg_remove)
                            .setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    mPresenter.deleteFromAppRequest();
                                }
                            })
                            .setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    mPartOfCycleSwitchView.setChecked(true);
                                }
                            }).show();
                }
            }
        });

        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.form_actions, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish:
                mPresenter.onClickSave(mPartOfCycleSwitchView.isChecked(), mRequestAmountEditText.getCurrencyValue(), mAuthAmountEditText.getCurrencyValue());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(MemberCreditAppContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showRequestAmountError() {
        mRequestAmountInputLayout.setError(getString(R.string.credit_app_error_amount, BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.AMOUNT_REQUEST_APP)));
    }

    @Override
    public void showMemberData(MemberCreditApp memberCredit) {
        mCustomerNameText.setText(memberCredit.getCustomerName());
        mCustomerNumberText.setText(memberCredit.getCustomerNumber());
        mCycleInGroupText.setText(String.valueOf(memberCredit.getCycleInGroup()));
        mAuthAmountEditText.setCurrencyValue(memberCredit.getAuthorizedAmount());
        mProposedEditText.setCurrencyValue(memberCredit.getMaxProposedAmount());
        if(memberCredit.getRequestAmount() > 0.0){
            mRequestAmountEditText.setCurrencyValue(memberCredit.getRequestAmount());
        }else{
            mRequestAmountEditText.setText(null);
        }
        mPartOfCycleSwitchView.setChecked(memberCredit.isPartOfCycle());
    }

    @Override
    public void clearErrors() {
        mRequestAmountInputLayout.setErrorEnabled(false);
    }

    @Override
    public void sendResult(MemberCreditApp memberCredit) {
        getActivity().setResult(Activity.RESULT_OK, MemberCreditActivity.newIntentResult(memberCredit));
        getActivity().finish();
    }

    @Override
    public void drawRiskLevel(String riskLevel) {
        mRiskLevelGaugeView.setItemTarget(ResourcesUtil.getGaugeItemFromRiskLevel(riskLevel));
        mRiskLevelGaugeView.setCaption(getString(ResourcesUtil.getRiskLevelStringResource(riskLevel)));
        mRiskLevelGaugeView.postDelayed(new Runnable() {
            @Override
            public void run() {
                mRiskLevelGaugeView.play();
            }
        }, Constants.RISK_LEVEL_ANIMATION_DELAY);
    }

    @Override
    public void hideRiskLevel() {
        mRiskLevelView.setVisibility(View.GONE);
    }

    @Override
    public void toggleProposedAmount(boolean show) {
        mProposedInputLayout.setVisibility(show ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleRenovation(boolean isRenovation) {
        if (isRenovation) {
            mRequestAmountEditText.setEnabled(false);
            mRequestAmountEditText.setKeyListener(null);
        } else {
            mRequestAmountEditText.setEnabled(true);
            mRequestAmountEditText.requestFocus();
            mRequestAmountEditText.addTextChangedListener(mRequestAmountTextWatcher);
        }
    }

    @Override
    public void toggleRequestView(boolean isPartOfCycle) {
        mRequestAppView.setVisibility(isPartOfCycle ? View.VISIBLE : View.GONE);
    }

    @Override
    public void showWarrantyAmount(double warranty) {
        mWarrantyEditText.setCurrencyValue(warranty);
    }

    private TextWatcher mRequestAmountTextWatcher = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {

        }

        @Override
        public void afterTextChanged(Editable s) {
            mAuthAmountEditText.setCurrencyValue(mRequestAmountEditText.getCurrencyValue());
        }
    };

    private TextWatcher mAuthAmountTextWatcher = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {

        }

        @Override
        public void afterTextChanged(Editable s) {
            mPresenter.onComputeWarranty(mAuthAmountEditText.getCurrencyValue());
        }
    };
}