package com.cobis.gestionasesores.presentation.sections.customerbusiness;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.text.InputFilter;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.DatePicker;
import android.widget.Spinner;
import android.widget.TextView;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerBusiness;
import com.cobis.gestionasesores.presentation.address.AddressActivity;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.AddressInputEditText;
import com.cobis.gestionasesores.widgets.DatePickerFragment;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;
import com.cobis.gestionasesores.widgets.phonefield.PhoneInputLayout;
import com.cobis.gestionasesores.widgets.searchablespinner.SearchableSpinner;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class CustomerBusinessFragment extends SectionFragment implements CustomerBusinessContract.View {
    private static final String DATE_DIALOG = "date_dialog";
    private static final int REQUEST_ADDRESS_DATA = 1;

    @BindView(R.id.input_layout_business_name)
    TextInputLayout mBusinessNameInputLayout;
    @BindView(R.id.input_layout_address)
    TextInputLayout mAddressInputLayout;
    @BindView(R.id.input_layout_monthly_income)
    TextInputLayout mMonthlyIncomeInputLayout;

    @BindView(R.id.input_business_name)
    TextInputEditText mBusinessNameEditText;
    @BindView(R.id.input_address)
    AddressInputEditText mAddressEditText;
    @BindView(R.id.input_telephone)
    PhoneInputLayout mTelephoneEditText;
    @BindView(R.id.input_monthly_income)
    CurrencyInputEditText mMonthlyIncomeEditText;

    @BindView(R.id.text_opening_date)
    TextView mOpeningDateText;

    @BindView(R.id.spinner_turnaround)
    Spinner mTurnaroundSpinner;
    @BindView(R.id.spinner_credit_destination)
    Spinner mCreditDestinationSpinner;
    @BindView(R.id.spinner_economic_activity)
    SearchableSpinner mEconomicActivitySpinner;
    @BindView(R.id.spinner_time_activity)
    Spinner mTimeActivitySpinner;
    @BindView(R.id.spinner_time_rooting)
    Spinner mTimeRootingSpinner;
    @BindView(R.id.spinner_credit_pay_resources)
    Spinner mCreditPayResourcesSpinner;
    @BindView(R.id.spinner_business_type)
    Spinner mBusinessTypeSpinner;

    private CatalogItemAdapter mTurnaroundAdapter;
    private CatalogItemAdapter mCreditDestinationAdapter;
    private CatalogItemAdapter mEconomicActivityAdapter;
    private CatalogItemAdapter mTimeActivityAdapter;
    private CatalogItemAdapter mTimeRootingAdapter;
    private CatalogItemAdapter mCreditPayResourcesAdapter;
    private CatalogItemAdapter mBusinessTypeAdapter;
    private CustomerBusinessContract.Presenter mPresenter;

    public static CustomerBusinessFragment newInstance() {
        Bundle args = new Bundle();
        CustomerBusinessFragment fragment = new CustomerBusinessFragment();
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
        return inflater.inflate(R.layout.fragment_customer_business, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mMonthlyIncomeEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mTurnaroundAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_turnaround);
        mCreditDestinationAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_credit_destination);
        mEconomicActivityAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_economic_activity);
        mTimeActivityAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_time_activity);
        mTimeRootingAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_time_rooting);
        mCreditPayResourcesAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_credit_pay_res);
        mBusinessTypeAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_business_hint_business_type);

        mTurnaroundSpinner.setAdapter(mTurnaroundAdapter);
        mCreditDestinationSpinner.setAdapter(mCreditDestinationAdapter);

        mEconomicActivitySpinner.setAdapter(mEconomicActivityAdapter);
        mEconomicActivitySpinner.setTitle(getString(R.string.customer_business_hint_economic_activity));
        mEconomicActivitySpinner.setPositiveButton(getString(R.string.action_cancel));

        mBusinessNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_ONLY_LETTERS), new InputFilter.AllCaps()});

        mTimeActivitySpinner.setAdapter(mTimeActivityAdapter);
        mTimeRootingSpinner.setAdapter(mTimeRootingAdapter);
        mCreditPayResourcesSpinner.setAdapter(mCreditPayResourcesAdapter);
        mBusinessTypeSpinner.setAdapter(mBusinessTypeAdapter);

        mBusinessTypeSpinner.setOnItemSelectedListener(mOnBusinessTypeSelected);

        mPresenter.start();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_ADDRESS_DATA) {
            mPresenter.onAddressDataResult((AddressData) data.getSerializableExtra(AddressActivity.EXTRA_ADDRESS));
        }
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
                mPresenter.onClickFinish(buildCustomerBusiness());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(CustomerBusinessContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setCustomerBusiness(CustomerBusiness customerBusiness) {
        mBusinessNameEditText.setText(customerBusiness.getName());
        mAddressEditText.setText(null);
        mTelephoneEditText.setPhoneNumber(customerBusiness.getPhoneNumber());
        mMonthlyIncomeEditText.setCurrencyValue(customerBusiness.getMonthlyIncome());

        mOpeningDateText.setTag(customerBusiness.getOpeningDate());
        mOpeningDateText.setText(DateUtils.formatDate(customerBusiness.getOpeningDate()));

        mTurnaroundSpinner.setSelection(mTurnaroundAdapter.getItemPositionByCode(customerBusiness.getTurnaround()));
        mCreditDestinationSpinner.setSelection(mCreditDestinationAdapter.getItemPositionByCode(customerBusiness.getCreditDestination()));
        mEconomicActivitySpinner.setSelection(mEconomicActivityAdapter.getItemPositionByCode(customerBusiness.getActivity()));
        mTimeActivitySpinner.setSelection(mTimeActivityAdapter.getItemPositionByCode(customerBusiness.getTimeActivity()));
        mTimeRootingSpinner.setSelection(mTimeRootingAdapter.getItemPositionByCode(customerBusiness.getTimeRooting()));
        mCreditPayResourcesSpinner.setSelection(mCreditPayResourcesAdapter.getItemPositionByCode(customerBusiness.getCreditPay()));
        mBusinessTypeSpinner.setSelection(mBusinessTypeAdapter.getItemPositionByCode(customerBusiness.getLocationType()));
    }

    public CustomerBusiness buildCustomerBusiness() {
        return new CustomerBusiness.Builder()
                .addName(mBusinessNameEditText.getText().toString().trim())
                .addTurnaround(mTurnaroundAdapter.getItemCode(mTurnaroundSpinner.getSelectedItemPosition()))
                .addCreditDestination(mCreditDestinationAdapter.getItemCode(mCreditDestinationSpinner.getSelectedItemPosition()))
                .addPhoneNumber(mTelephoneEditText.getPhoneNumber().trim())
                .addOpeningDate((Long) mOpeningDateText.getTag())
                .addActivity(mEconomicActivityAdapter.getItemCode(mEconomicActivitySpinner.getSelectedItemPosition()))
                .addTimeActivity(mTimeActivityAdapter.getItemCode(mTimeActivitySpinner.getSelectedItemPosition()))
                .addTimeRooting(mTimeRootingAdapter.getItemCode(mTimeRootingSpinner.getSelectedItemPosition()))
                .addCreditPay(mCreditPayResourcesAdapter.getItemCode(mCreditPayResourcesSpinner.getSelectedItemPosition()))
                .addMonthlyIncome(mMonthlyIncomeEditText.getCurrencyValue())
                .addLocationType(mBusinessTypeAdapter.getItemCode(mBusinessTypeSpinner.getSelectedItemPosition()))
                .build();
    }

    @Override
    public void clearErrors() {
        mBusinessNameInputLayout.setErrorEnabled(false);
        mAddressInputLayout.setErrorEnabled(false);
        mTelephoneEditText.setError(null);
        mMonthlyIncomeInputLayout.setErrorEnabled(false);

        mOpeningDateText.setError(null);

        mTurnaroundAdapter.clearError();
        mCreditDestinationAdapter.clearError();
        mEconomicActivityAdapter.clearError();
        mTimeActivityAdapter.clearError();
        mTimeRootingAdapter.clearError();
        mCreditPayResourcesAdapter.clearError();
        mBusinessTypeAdapter.clearError();
    }

    @Override
    public void showAddressError() {
        mAddressInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showNameError() {
        mBusinessNameInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showTurnaroundError() {
        mTurnaroundAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showCreditDestinationError() {
        mCreditDestinationAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showPhoneNumberError() {
        mTelephoneEditText.setError(getString(R.string.val_invalid_telephone));
    }

    @Override
    public void showActivityError() {
        mEconomicActivityAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTimeActivityError() {
        mTimeActivityAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTimeRootingError() {
        mTimeRootingAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showOpeningDateError() {
        mOpeningDateText.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showCreditPayError() {
        mCreditPayResourcesAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showMonthlyIncomeError() {
        mMonthlyIncomeInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showLocationTypeError() {
        mBusinessTypeAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTurnarounds(List<CatalogItem> turnarounds) {
        mTurnaroundAdapter.setCatalogItems(turnarounds);
    }

    @Override
    public void showActivities(List<CatalogItem> activities) {
        mEconomicActivityAdapter.setCatalogItems(activities);
    }

    @Override
    public void showBusinessTypes(List<CatalogItem> businessTypes) {
        mBusinessTypeAdapter.setCatalogItems(businessTypes);
    }

    @Override
    public void showCreditDestinations(List<CatalogItem> creditDestinations) {
        mCreditDestinationAdapter.setCatalogItems(creditDestinations);
    }

    @Override
    public void showCreditPayResources(List<CatalogItem> creditPayResources) {
        mCreditPayResourcesAdapter.setCatalogItems(creditPayResources);
    }

    @Override
    public void showTimeActivity(List<CatalogItem> options) {
        mTimeActivityAdapter.setCatalogItems(options);
    }

    @Override
    public void showTimeRooting(List<CatalogItem> options) {
        mTimeRootingAdapter.setCatalogItems(options);
    }

    @Override
    public void showOpeningDateDialog(Long maxDate) {
        DatePickerFragment fragment = (DatePickerFragment) getActivity().getSupportFragmentManager().findFragmentByTag(DATE_DIALOG);
        if (fragment == null) {
            fragment = DatePickerFragment.newInstance((Long) mOpeningDateText.getTag(), maxDate);
            fragment.setOnDateSetListener(mOnOpeningDateSetListener);
            fragment.show(getActivity().getSupportFragmentManager(), DATE_DIALOG);
        }
    }

    @Override
    public void setOpeningDate(Long date) {
        mOpeningDateText.setTag(date);
        mOpeningDateText.setText(DateUtils.formatDate(date));
    }

    @Override
    public void setAddressData(String addressData) {
        mAddressEditText.setText(addressData);
    }

    @Override
    public void startAddressData(AddressData addressData) {
        startActivityForResult(AddressActivity.newIntent(getContext(), addressData), REQUEST_ADDRESS_DATA);
    }

    @Override
    public void enableAddress(boolean enable) {
        mAddressInputLayout.setEnabled(enable);
    }

    @Override
    public void showAddress(String address) {
        mAddressEditText.setText(address);
    }

    @OnClick(R.id.text_opening_date)
    public void onClickOpeningDate(View view) {
        mPresenter.onClickOpeningDate();
    }

    @OnClick(R.id.input_address)
    public void onClickAddress(View view) {
        mPresenter.onClickAddressData();
    }

    private DatePickerDialog.OnDateSetListener mOnOpeningDateSetListener = new DatePickerDialog.OnDateSetListener() {
        @Override
        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
            mPresenter.onOpeningDateSet(year, month, dayOfMonth);
        }
    };

    private AdapterView.OnItemSelectedListener mOnBusinessTypeSelected = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            mPresenter.onBusinessTypeChange(mBusinessTypeAdapter.getItemCode(position));
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {
        }
    };
}