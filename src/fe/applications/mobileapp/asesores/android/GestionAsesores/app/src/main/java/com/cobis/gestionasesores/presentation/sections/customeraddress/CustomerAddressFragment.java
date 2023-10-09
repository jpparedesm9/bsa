package com.cobis.gestionasesores.presentation.sections.customeraddress;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Spinner;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.presentation.address.AddressActivity;
import com.cobis.gestionasesores.presentation.person.PersonActivity;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.widgets.AddressInputEditText;
import com.cobis.gestionasesores.widgets.phonefield.PhoneInputLayout;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class CustomerAddressFragment extends SectionFragment implements CustomerAddressContract.CustomerAddressView {
    private static final int REQUEST_ADDRESS_DATA = 1;
    @BindView(R.id.input_layout_email)
    TextInputLayout mEmailInputLayout;
    @BindView(R.id.input_layout_address)
    TextInputLayout mAddressInputLayout;

    @BindView(R.id.input_telephone)
    PhoneInputLayout mTelephoneEditText;
    @BindView(R.id.input_email)
    TextInputEditText mEmailEditText;
    @BindView(R.id.input_cellphone)
    PhoneInputLayout mCellphoneEditText;

    @BindView(R.id.input_address)
    AddressInputEditText mAddressEditText;

    @BindView(R.id.spinner_years_current_address)
    Spinner mYearsCurrentAddressSpinner;
    @BindView(R.id.spinner_housing_type)
    Spinner mHousingTypeSpinner;
    @BindView(R.id.spinner_num_people_living_in_address)
    Spinner mNumPeopleLivingInAddressSpinner;

    private CatalogItemAdapter mYearsCurrentAddressAdapter;
    private CatalogItemAdapter mHousingTypeAdapter;
    private CatalogItemAdapter mNumPeopleLivingInAddressAdapter;
    private CustomerAddressContract.CustomerAddressPresenter mPresenter;

    public static CustomerAddressFragment newInstance() {
        Bundle args = new Bundle();
        CustomerAddressFragment fragment = new CustomerAddressFragment();
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
        return inflater.inflate(R.layout.fragment_customer_address, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mYearsCurrentAddressAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_address_hint_years_current_address);
        mHousingTypeAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_address_hint_housing_type);
        mNumPeopleLivingInAddressAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_address_hint_num_people_living_in_address);

        mYearsCurrentAddressSpinner.setAdapter(mYearsCurrentAddressAdapter);
        mHousingTypeSpinner.setAdapter(mHousingTypeAdapter);
        mNumPeopleLivingInAddressSpinner.setAdapter(mNumPeopleLivingInAddressAdapter);

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
                mPresenter.onClickFinish(buildCustomerAddress());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void clearErrors() {
        mTelephoneEditText.setError(null);
        mEmailInputLayout.setErrorEnabled(false);
        mCellphoneEditText.setError(null);
        mAddressInputLayout.setErrorEnabled(false);

        mYearsCurrentAddressAdapter.clearError();
        mHousingTypeAdapter.clearError();
        mNumPeopleLivingInAddressAdapter.clearError();
    }

    @Override
    public void sendResult(boolean isSuccess, int personId) {
        getActivity().setResult(isSuccess ? Activity.RESULT_OK : Activity.RESULT_CANCELED, PersonActivity.newIntent(personId));
        getActivity().finish();
    }

    public CustomerAddress buildCustomerAddress() {
        return new CustomerAddress.Builder().addTelephone(mTelephoneEditText.getPhoneNumber().trim()).addEmail(mEmailEditText.getText().toString().trim()).addCellphone(mCellphoneEditText.getPhoneNumber().trim()).addYearsInCurrentAddress(mYearsCurrentAddressAdapter.getItemCode(mYearsCurrentAddressSpinner.getSelectedItemPosition())).addHousingType(mHousingTypeAdapter.getItemCode(mHousingTypeSpinner.getSelectedItemPosition())).addNumPeopleLivingInAddress(mNumPeopleLivingInAddressAdapter.getItemCode(mNumPeopleLivingInAddressSpinner.getSelectedItemPosition())).build();
    }

    @Override
    public void setCustomerAddress(@NonNull CustomerAddress customerAddress) {
        mTelephoneEditText.setPhoneNumber(customerAddress.getTelephone());
        mEmailEditText.setText(customerAddress.getEmail());
        mCellphoneEditText.setPhoneNumber(customerAddress.getCellphone());
        mYearsCurrentAddressSpinner.setSelection(mYearsCurrentAddressAdapter.getItemPositionByCode(customerAddress.getYearsInCurrentAddress()));
        mHousingTypeSpinner.setSelection(mHousingTypeAdapter.getItemPositionByCode(customerAddress.getHousingType()));
        mNumPeopleLivingInAddressSpinner.setSelection(mNumPeopleLivingInAddressAdapter.getItemPositionByCode(customerAddress.getNumPeopleLivingInAddress()));
    }

    @Override
    public void showTelephoneError() {
        mTelephoneEditText.setError(getString(R.string.val_invalid_telephone));
    }

    @Override
    public void showEmailError() {
        mEmailInputLayout.setError(getString(R.string.val_invalid_email));
    }

    @Override
    public void showCellphoneError() {
        mCellphoneEditText.setError(getString(R.string.val_invalid_telephone));
    }

    @Override
    public void showYearsCurrentAddressError() {
        mYearsCurrentAddressAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showHousingTypeError() {
        mHousingTypeAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showNumPeopleLivingInAddressError() {
        mNumPeopleLivingInAddressAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showAddressError() {
        mAddressInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showYearsCurrentAddress(List<CatalogItem> options) {
        mYearsCurrentAddressAdapter.setCatalogItems(options);
    }

    @Override
    public void showHousingTypes(List<CatalogItem> housingTypes) {
        mHousingTypeAdapter.setCatalogItems(housingTypes);
    }

    @Override
    public void showNumPeopleLivingInAddress(List<CatalogItem> options) {
        mNumPeopleLivingInAddressAdapter.setCatalogItems(options);
    }

    @Override
    public void startAddressData(AddressData addressData) {
        startActivityForResult(AddressActivity.newIntent(getContext(), addressData), REQUEST_ADDRESS_DATA);
    }

    @Override
    public void setAddressData(String addressData) {
        mAddressEditText.setText(addressData);
    }

    @OnClick(R.id.input_address)
    public void onClickAddressData(View view) {
        mPresenter.onClickAddress();
    }

    @Override
    public void setPresenter(CustomerAddressContract.CustomerAddressPresenter presenter) {
        mPresenter = presenter;
    }
}