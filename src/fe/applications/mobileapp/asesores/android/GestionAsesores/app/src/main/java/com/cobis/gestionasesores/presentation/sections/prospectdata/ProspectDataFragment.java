package com.cobis.gestionasesores.presentation.sections.prospectdata;

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
import android.widget.DatePicker;
import android.widget.Spinner;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.presentation.address.AddressActivity;
import com.cobis.gestionasesores.presentation.address.PostalCodeAdapter;
import com.cobis.gestionasesores.presentation.person.PersonActivity;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.AddressInputEditText;
import com.cobis.gestionasesores.widgets.DatePickerFragment;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.searchablespinner.SearchableSpinner;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ProspectDataFragment extends SectionFragment implements ProspectDataContract.View {
    private static final String DATE_DIALOG = "date_dialog";

    private static final int REQUEST_ADDRESS_DATA = 1;
    private static final int REQUEST_SELECT_PARTNER = 2;

    @BindView(R.id.input_layout_first_name)
    TextInputLayout mFirstNameInputLayout;
    @BindView(R.id.input_layout_second_name)
    TextInputLayout mSecondNameInputLayout;
    @BindView(R.id.input_layout_last_name)
    TextInputLayout mLastNameInputLayout;
    @BindView(R.id.input_layout_second_last_name)
    TextInputLayout mSecondLastNameInputLayout;
    @BindView(R.id.input_layout_email)
    TextInputLayout mEmailInputLayout;
    @BindView(R.id.input_layout_curp)
    TextInputLayout mCurpInputLayout;
    @BindView(R.id.input_layout_rfc)
    TextInputLayout mRfcInputLayout;
    @BindView(R.id.input_layout_address)
    TextInputLayout mAddressInputLayout;
    @BindView(R.id.input_layout_birthdate)
    TextInputLayout mBirthDateInputLayout;

    @BindView(R.id.input_first_name)
    TextInputEditText mFirstNameEditText;
    @BindView(R.id.input_second_name)
    TextInputEditText mSecondNameEditText;
    @BindView(R.id.input_last_name)
    TextInputEditText mLastNameEditText;
    @BindView(R.id.input_second_last_name)
    TextInputEditText mSecondLastNameEditText;
    @BindView(R.id.input_email)
    TextInputEditText mEmailEditText;
    @BindView(R.id.input_curp)
    TextInputEditText mCurpEditText;
    @BindView(R.id.input_rfc)
    TextInputEditText mRfcEditText;
    @BindView(R.id.input_address)
    AddressInputEditText mAddressEditText;

    @BindView(R.id.input_birthdate)
    TextInputEditText mBirthDateText;

    @BindView(R.id.spinner_birth_entity)
    SearchableSpinner mBirthEntitySpinner;
    @BindView(R.id.spinner_civil_status)
    Spinner mCivilStatusSpinner;
    @BindView(R.id.spinner_sex)
    Spinner mSexSpinner;

    private CatalogItemAdapter mCivilStatusAdapter;
    private CatalogItemAdapter mSexAdapter;
    private PostalCodeAdapter mBirthEntityAdapter;
    private ProspectDataContract.Presenter mPresenter;
    private DatePickerDialog.OnDateSetListener mOnBirthDateSetListener = new DatePickerDialog.OnDateSetListener() {
        @Override
        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
            mPresenter.onBirthDateSet(year, month, dayOfMonth);
        }
    };

    public static ProspectDataFragment newInstance() {
        Bundle args = new Bundle();
        ProspectDataFragment fragment = new ProspectDataFragment();
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
        return inflater.inflate(R.layout.fragment_prospect_data, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mBirthEntityAdapter = new PostalCodeAdapter(getContext(), new ArrayList<PostalCode>(), R.string.form_hint_birth_entity);
        mCivilStatusAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_civil_status);
        mSexAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_sex);

        mBirthEntitySpinner.setTitle(getString(R.string.form_hint_birth_entity));
        mBirthEntitySpinner.setPositiveButton(getString(R.string.action_cancel));

        mSexSpinner.setAdapter(mSexAdapter);
        mCivilStatusSpinner.setAdapter(mCivilStatusAdapter);

        mBirthDateText.setFocusable(false);
        mBirthDateText.setClickable(true);
        mBirthDateText.setKeyListener(null);

        mFirstNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_FIRST_NAME), new InputFilter.AllCaps()});
        mSecondNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_NAMES), new InputFilter.AllCaps()});
        mLastNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_NAMES), new InputFilter.AllCaps()});
        mSecondLastNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_NAMES), new InputFilter.AllCaps()});

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
                mPresenter.onClickFinish(getProspectData());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ADDRESS_DATA && resultCode == Activity.RESULT_OK) {
            mPresenter.onAddressDataResult((AddressData) data.getSerializableExtra(AddressActivity.EXTRA_ADDRESS));
        }
    }

    @Override
    public void setPresenter(ProspectDataContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void sendResult(boolean isSuccess, int prospectId) {
        getActivity().setResult(isSuccess ? Activity.RESULT_OK : Activity.RESULT_CANCELED, PersonActivity.newIntent(prospectId));
        getActivity().finish();
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
    public void showSex(List<CatalogItem> sex) {
        mSexAdapter.setCatalogItems(sex);
    }

    @Override
    public void showCivilStatus(List<CatalogItem> civilStatus) {
        mCivilStatusAdapter.setCatalogItems(civilStatus);
    }

    @Override
    public void showBirthEntities(List<PostalCode> birthEntities, String selectCode) {
        mBirthEntityAdapter = new PostalCodeAdapter(getContext(), birthEntities, R.string.form_hint_birth_entity);
        mBirthEntitySpinner.setAdapter(mBirthEntityAdapter);
        mBirthEntitySpinner.setSelection(mBirthEntityAdapter.getPositionByCode(selectCode));
    }

    @Override
    public void setBirthDate(Long date) {
        mBirthDateText.setTag(date);
        mBirthDateText.setText(DateUtils.formatDate(date));
    }

    @Override
    public void showBirthDatePicker(Long maxDate) {
        DatePickerFragment fragment = (DatePickerFragment) getActivity().getSupportFragmentManager().findFragmentByTag(DATE_DIALOG);
        if (fragment == null) {
            fragment = DatePickerFragment.newInstance((Long) mBirthDateText.getTag(), maxDate);
            fragment.setOnDateSetListener(mOnBirthDateSetListener);
            fragment.show(getActivity().getSupportFragmentManager(), DATE_DIALOG);
        }
    }

    @Override
    public void toggleRfc(boolean shouldShow) {
        mRfcInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleCurp(boolean shouldShow) {
        mCurpInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void clearErrors() {
        mFirstNameInputLayout.setErrorEnabled(false);
        mLastNameInputLayout.setErrorEnabled(false);
        mSecondLastNameInputLayout.setErrorEnabled(false);
        mEmailInputLayout.setErrorEnabled(false);
        mCurpInputLayout.setErrorEnabled(false);
        mRfcInputLayout.setErrorEnabled(false);
        mAddressInputLayout.setErrorEnabled(false);

        mBirthDateInputLayout.setErrorEnabled(false);

        mSexAdapter.clearError();
        mCivilStatusAdapter.clearError();
        mBirthEntityAdapter.clearError();
    }

    @Override
    public void showFirstNameError() {
        mFirstNameInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showLastNameError() {
        mLastNameInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showEmailError() {
        mEmailInputLayout.setError(getString(R.string.val_invalid_email));
    }

    @Override
    public void showAddressError() {
        mAddressInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showSexError() {
        mSexAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showCivilStatusError() {
        mCivilStatusAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showBirthDateError() {
        mBirthDateInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showAdultAgeError(int minAge, int maxAge) {
        mBirthDateInputLayout.setError(getString(R.string.val_invalid_adult_age, minAge, maxAge));
    }

    @Override
    public void showBirthEntityError() {
        mBirthEntityAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void disableIdentificationFields() {
        disableFirstName();
        disableSecondName();
        disableLastName();
        disableSecondLastName();
        disableBirthDate();
        disableBirthEntity();
        disableSex();
    }

    @Override
    public void disableFirstName() {
        mFirstNameInputLayout.setEnabled(false);
        mFirstNameEditText.setKeyListener(null);
    }

    @Override
    public void disableSecondName() {
        mSecondNameInputLayout.setEnabled(false);
    }

    @Override
    public void disableLastName() {
        mLastNameInputLayout.setEnabled(false);
    }

    @Override
    public void disableSecondLastName() {
        mSecondLastNameInputLayout.setEnabled(false);
    }

    @Override
    public void disableBirthDate() {
        mBirthDateInputLayout.setEnabled(false);
    }

    @Override
    public void disableBirthEntity() {
        mBirthEntitySpinner.setEnabled(false);
    }

    @Override
    public void disableSex() {
        mSexSpinner.setEnabled(false);
    }

    @Override
    public ProspectData getProspectData() {
        return new ProspectData.Builder()
                .setFirstName(mFirstNameEditText.getText().toString().trim())
                .setSecondName(mSecondNameEditText.getText().toString().trim())
                .setLastName(mLastNameEditText.getText().toString().trim())
                .setSecondLastName(mSecondLastNameEditText.getText().toString().trim())
                .setEmail(mEmailEditText.getText().toString().trim())
                .setSex(mSexAdapter.getItemCode(mSexSpinner.getSelectedItemPosition()))
                .setCivilStatus(mCivilStatusAdapter.getItemCode(mCivilStatusSpinner.getSelectedItemPosition()))
                .setBirthEntityCode(mBirthEntityAdapter.getItem(mBirthEntitySpinner.getSelectedItemPosition()).getCode())
                .setBirthEntityAdditionalCode(mBirthEntityAdapter.getItem(mBirthEntitySpinner.getSelectedItemPosition()).getAdditionalCode())
                .setBirthDate((Long) mBirthDateText.getTag())
                .setCurp(mCurpEditText.getText().toString())
                .setRfc(mRfcEditText.getText().toString())
                .build();
    }

    @Override
    public void setProspectData(ProspectData prospectData) {
        mFirstNameEditText.setText(prospectData.getFirstName());
        mSecondNameEditText.setText(prospectData.getSecondName());
        mLastNameEditText.setText(prospectData.getLastName());
        mSecondLastNameEditText.setText(prospectData.getSecondLastName());
        mEmailEditText.setText(prospectData.getEmail());
        mRfcEditText.setText(prospectData.getRfc());
        mCurpEditText.setText(prospectData.getCurp());

        mBirthDateText.setText(DateUtils.formatDate(prospectData.getBirthDate()));
        mBirthDateText.setTag(prospectData.getBirthDate());

        mSexSpinner.setSelection(mSexAdapter.getItemPositionByCode(prospectData.getSex()));
        mCivilStatusSpinner.setSelection(mCivilStatusAdapter.getItemPositionByCode(prospectData.getCivilStatus()));
    }

    @OnClick(R.id.input_birthdate)
    public void onClickBirthDate(View view) {
        mPresenter.onClickBirthDate();
    }

    @OnClick(R.id.input_address)
    public void onClickAddressData(View view) {
        mPresenter.onClickAddressData();
    }
}