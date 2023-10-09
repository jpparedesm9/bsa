package com.cobis.gestionasesores.presentation.sections.customerpayment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputLayout;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.CustomerPayment;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;

import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;

public class CustomerPaymentFragment extends SectionFragment implements CustomerPaymentContract.CustomerPaymentView {
    @BindView(R.id.input_layout_monthly_income)
    TextInputLayout mMonthlyIncomeInputLayout;
    @BindView(R.id.input_layout_monthly_business_expenses)
    TextInputLayout mMonthlyBusinessExpensesInputLayout;
    @BindView(R.id.input_layout_monthly_family_expenses)
    TextInputLayout mMonthlyFamilyExpensesInputLayout;
    @BindView(R.id.input_layout_payment_capacity)
    TextInputLayout mPaymentCapacityInputLayout;

    @BindView(R.id.input_monthly_income)
    CurrencyInputEditText mMonthlyIncomeEditText;
    @BindView(R.id.input_monthly_business_expenses)
    CurrencyInputEditText mMonthlyBusinessExpensesEditText;
    @BindView(R.id.input_monthly_family_expenses)
    CurrencyInputEditText mMonthlyFamilyExpensesEditText;
    @BindView(R.id.input_payment_capacity)
    CurrencyInputEditText mPaymentCapacityEditText;
    @BindView(R.id.input_other_income)
    CurrencyInputEditText mOtherIncomeEditText;

    private CustomerPaymentContract.CustomerPaymentPresenter mPresenter;

    public static CustomerPaymentFragment newInstance() {
        Bundle args = new Bundle();
        CustomerPaymentFragment fragment = new CustomerPaymentFragment();
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
        return inflater.inflate(R.layout.fragment_customer_payment, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        Locale locale = BankAdvisorApp.getInstance().getConfig().getLocale();
        mMonthlyIncomeEditText.setLocale(locale);
        mMonthlyBusinessExpensesEditText.setLocale(locale);
        mMonthlyFamilyExpensesEditText.setLocale(locale);
        mPaymentCapacityEditText.setLocale(locale);
        mOtherIncomeEditText.setLocale(locale);
        mPaymentCapacityEditText.setAllowNegativeValues(true);

        mMonthlyIncomeEditText.addTextChangedListener(mIncomeTextWatcher);
        mMonthlyBusinessExpensesEditText.addTextChangedListener(mBusinessExpensesTextWatcher);
        mMonthlyFamilyExpensesEditText.addTextChangedListener(mFamilyExpensesTextWatcher);

        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_section, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_section:
                mPresenter.onClickFinish(buildCustomerPayment());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(CustomerPaymentContract.CustomerPaymentPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setCustomerPayment(CustomerPayment customerPayment) {
        mMonthlyIncomeEditText.setCurrencyValue(customerPayment.getMonthlyIncome());
        mMonthlyBusinessExpensesEditText.setCurrencyValue(customerPayment.getMonthlyBusinessExpenses());
        mMonthlyFamilyExpensesEditText.setCurrencyValue(customerPayment.getMonthlyFamilyExpenses());
    }

    @Override
    public void setOtherIncome(double otherIncome) {
        mOtherIncomeEditText.setCurrencyValue(otherIncome);
    }

    @Override
    public void clearErrors() {
        mMonthlyIncomeInputLayout.setErrorEnabled(false);
        mMonthlyBusinessExpensesInputLayout.setErrorEnabled(false);
        mMonthlyFamilyExpensesInputLayout.setErrorEnabled(false);
    }

    @Override
    public void showMonthlyIncomeError() {
        mMonthlyIncomeInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showMonthlyBusinessExpensesError() {
        mMonthlyBusinessExpensesInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showMonthlyFamilyExpensesError() {
        mMonthlyFamilyExpensesInputLayout.setError(getString(R.string.val_field_required));
    }

    public CustomerPayment buildCustomerPayment() {
        return new CustomerPayment.Builder()
                .addMonthlyIncome(mMonthlyIncomeEditText.getCurrencyValue())
                .addMonthlyBusinessExpenses(mMonthlyBusinessExpensesEditText.getCurrencyValue())
                .addMonthlyFamilyExpenses(mMonthlyFamilyExpensesEditText.getCurrencyValue())
                .addPaymentCapacity(mPaymentCapacityEditText.getCurrencyValue())
                .build();
    }

    @Override
    public void setPaymentCapacity(double paymentCapacity) {
        mPaymentCapacityEditText.setCurrencyValue(paymentCapacity);
    }

    private TextWatcher mIncomeTextWatcher = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
        }

        @Override
        public void afterTextChanged(Editable s) {
            mPresenter.onMonthlyIncomeChange(mMonthlyIncomeEditText.getCurrencyValue());
        }
    };

    private TextWatcher mBusinessExpensesTextWatcher = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
        }

        @Override
        public void afterTextChanged(Editable s) {
            mPresenter.onMonthlyBusinessExpensesChange(mMonthlyBusinessExpensesEditText.getCurrencyValue());
        }
    };

    private TextWatcher mFamilyExpensesTextWatcher = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
        }

        @Override
        public void afterTextChanged(Editable s) {
            mPresenter.onMonthlyFamilyExpensesChange(mMonthlyFamilyExpensesEditText.getCurrencyValue());
        }
    };
}
