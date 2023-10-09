package com.cobis.gestionasesores.presentation.sections.partnerdata;

import android.app.DatePickerDialog;
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
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.presentation.address.PostalCodeAdapter;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.DatePickerFragment;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.searchablespinner.SearchableSpinner;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PartnerDataFragment extends SectionFragment implements PartnerDataContract.PartnerDataView {
    private static final String DATE_DIALOG = "date_dialog";

    @BindView(R.id.spinner_sex)
    Spinner mSexSpinner;
    @BindView(R.id.spinner_federal_entity)
    SearchableSpinner mFederalEntitySpinner;
    @BindView(R.id.spinner_birth_country)
    Spinner mBirthCountrySpinner;
    @BindView(R.id.spinner_nationality)
    Spinner mNationalitySpinner;
    @BindView(R.id.spinner_education_level)
    Spinner mEducationLevelSpinner;
    @BindView(R.id.spinner_occupation)
    Spinner mOccupationSpinner;
    @BindView(R.id.spinner_activity)
    SearchableSpinner mActivitySpinner;

    @BindView(R.id.input_layout_first_name)
    TextInputLayout mFirstNameInputLayout;
    @BindView(R.id.input_layout_second_name)
    TextInputLayout mSecondNameInputLayout;
    @BindView(R.id.input_layout_last_name)
    TextInputLayout mLastNameInputLayout;
    @BindView(R.id.input_layout_second_last_name)
    TextInputLayout mSecondLastNameInputLayout;
    @BindView(R.id.input_layout_rfc)
    TextInputLayout mRfcInputLayout;
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
    @BindView(R.id.input_rfc)
    TextInputEditText mRfcEditText;
    @BindView(R.id.input_birthdate)
    TextInputEditText mBirthDateText;

    private PartnerDataContract.PartnerDataPresenter mPresenter;
    private CatalogItemAdapter mSexAdapter;
    private PostalCodeAdapter mFederalEntityAdapter;
    private CatalogItemAdapter mBirthCountryAdapter;
    private CatalogItemAdapter mNationalityAdapter;
    private CatalogItemAdapter mEducationLevelAdapter;
    private CatalogItemAdapter mOccupationAdapter;
    private CatalogItemAdapter mActivityAdapter;

    public static PartnerDataFragment newInstance() {
        Bundle args = new Bundle();
        PartnerDataFragment fragment = new PartnerDataFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
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
                mPresenter.onClickFinish(buildPartnerData());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_partner_data, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mSexAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_sex);
        mBirthCountryAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_birth_country);
        mNationalityAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_nationality);
        mEducationLevelAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_education_level);
        mOccupationAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_occupation);
        mFederalEntityAdapter = new PostalCodeAdapter(getContext(), new ArrayList<PostalCode>(), R.string.form_hint_birth_entity);
        mActivityAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.partner_data_hint_activity);

        mSexSpinner.setAdapter(mSexAdapter);
        mFederalEntitySpinner.setAdapter(mFederalEntityAdapter);
        mBirthCountrySpinner.setAdapter(mBirthCountryAdapter);
        mNationalitySpinner.setAdapter(mNationalityAdapter);
        mEducationLevelSpinner.setAdapter(mEducationLevelAdapter);
        mOccupationSpinner.setAdapter(mOccupationAdapter);

        mActivitySpinner.setAdapter(mActivityAdapter);
        mActivitySpinner.setTitle(getString(R.string.partner_data_hint_activity));
        mActivitySpinner.setPositiveButton(getString(R.string.action_cancel));

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
    public void setPresenter(PartnerDataContract.PartnerDataPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setPartnerData(PartnerData partnerData) {
        GeneralPersonData generalPersonData = partnerData.getGeneralPersonData();
        mFirstNameEditText.setText(generalPersonData.getFirstName());
        mSecondNameEditText.setText(generalPersonData.getSecondName());
        mLastNameEditText.setText(generalPersonData.getLastName());
        mSecondLastNameEditText.setText(generalPersonData.getSecondLastName());
        mSexSpinner.setSelection(mSexAdapter.getItemPositionByCode(generalPersonData.getSex()));
        mBirthDateText.setTag(generalPersonData.getBirthDate());
        mBirthDateText.setText(DateUtils.formatDate(generalPersonData.getBirthDate()));
        mBirthCountrySpinner.setSelection(mBirthCountryAdapter.getItemPositionByCode(generalPersonData.getBirthCountry()));
        mNationalitySpinner.setSelection(mNationalityAdapter.getItemPositionByCode(generalPersonData.getNationality()));
        mEducationLevelSpinner.setSelection(mEducationLevelAdapter.getItemPositionByCode(generalPersonData.getEducationLevel()));
        mOccupationSpinner.setSelection(mOccupationAdapter.getItemPositionByCode(generalPersonData.getOccupation()));
        mRfcEditText.setText(generalPersonData.getRfc());
        mActivitySpinner.setSelection(mActivityAdapter.getItemPositionByCode(partnerData.getActivity()));
    }

    @Override
    public void clearErrors() {
        mFirstNameInputLayout.setErrorEnabled(false);
        mLastNameInputLayout.setErrorEnabled(false);
        mSecondLastNameInputLayout.setErrorEnabled(false);
        mRfcInputLayout.setErrorEnabled(false);

        mBirthDateInputLayout.setErrorEnabled(false);

        mSexAdapter.clearError();
        mFederalEntityAdapter.clearError();
        mBirthCountryAdapter.clearError();
        mNationalityAdapter.clearError();
        mEducationLevelAdapter.clearError();
        mOccupationAdapter.clearError();
    }

    @Override
    public void showSex(List<CatalogItem> sex) {
        mSexAdapter.setCatalogItems(sex);
    }

    @Override
    public void showFederalEntities(List<PostalCode> federalEntities, String selectCode) {
        mFederalEntityAdapter = new PostalCodeAdapter(getContext(), federalEntities, R.string.form_hint_birth_entity);
        mFederalEntitySpinner.setAdapter(mFederalEntityAdapter);
        mFederalEntitySpinner.setSelection(mFederalEntityAdapter.getPositionByCode(selectCode));
    }

    @Override
    public void showBirthCountries(List<CatalogItem> countries, String selectCode) {
        mBirthCountryAdapter.setCatalogItems(countries);
        mBirthCountrySpinner.setSelection(mBirthCountryAdapter.getItemPositionByCode(selectCode));
    }

    @Override
    public void showNationalities(List<CatalogItem> nationalities) {
        mNationalityAdapter.setCatalogItems(nationalities);
    }

    @Override
    public void showEducationLevels(List<CatalogItem> educationLevels) {
        mEducationLevelAdapter.setCatalogItems(educationLevels);
    }

    @Override
    public void showOccupations(List<CatalogItem> occupations) {
        mOccupationAdapter.setCatalogItems(occupations);
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
    public void showSexError() {
        mSexAdapter.showError(R.string.val_field_required);
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
    public void disableIdentificationFields() {
        mFirstNameInputLayout.setEnabled(false);
        mSecondNameInputLayout.setEnabled(false);
        mLastNameInputLayout.setEnabled(false);
        mSecondLastNameInputLayout.setEnabled(false);
        mBirthDateInputLayout.setEnabled(false);
    }

    @Override
    public void showBirthEntityError() {
        mFederalEntityAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showBirthCountryError() {
        mBirthCountryAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showNationalityError() {
        mNationalityAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showEducationLevelError() {
        mEducationLevelAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showOccupationError() {
        mOccupationAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showDateDialog(Long maxDate) {
        DatePickerFragment fragment = (DatePickerFragment) getActivity().getSupportFragmentManager().findFragmentByTag(DATE_DIALOG);
        if (fragment == null) {
            fragment = DatePickerFragment.newInstance((Long) mBirthDateText.getTag(), maxDate);
            fragment.setOnDateSetListener(mOnBirthDateSetListener);
            fragment.show(getActivity().getSupportFragmentManager(), DATE_DIALOG);
        }
    }

    @Override
    public void setBirthDate(Long date) {
        mBirthDateText.setTag(date);
        mBirthDateText.setText(DateUtils.formatDate(date));
    }

    @Override
    public void showActivities(List<CatalogItem> activities) {
        mActivityAdapter.setCatalogItems(activities);
    }

    @Override
    public void showActivityError() {
        mActivityAdapter.showError(R.string.val_field_required);
    }

    public PartnerData buildPartnerData() {
        GeneralPersonData generalPersonData = new GeneralPersonData.Builder()
                .setFirstName(mFirstNameEditText.getText().toString().trim())
                .setSecondName(mSecondNameEditText.getText().toString().trim())
                .setLastName(mLastNameEditText.getText().toString().trim())
                .setSecondLastName(mSecondLastNameEditText.getText().toString().trim())
                .setSex(mSexAdapter.getItemCode(mSexSpinner.getSelectedItemPosition()).trim())
                .setBirthDate((Long) mBirthDateText.getTag())
                .setBirthCountry(mBirthCountryAdapter.getItemCode(mBirthCountrySpinner.getSelectedItemPosition()).trim())
                .setBirthEntityCode(mFederalEntityAdapter.getItem(mFederalEntitySpinner.getSelectedItemPosition()).getCode())
                .setNationality(mNationalityAdapter.getItemCode(mNationalitySpinner.getSelectedItemPosition()).trim())
                .setEducationLevel(mEducationLevelAdapter.getItemCode(mEducationLevelSpinner.getSelectedItemPosition()).trim())
                .setOccupation(mOccupationAdapter.getItemCode(mOccupationSpinner.getSelectedItemPosition()).trim())
                .setRfc(mRfcEditText.getText().toString())
                .build();
        return new PartnerData.Builder().addGeneralPersonData(generalPersonData).addActivity(mActivityAdapter.getItemCode(mActivitySpinner.getSelectedItemPosition())).build();
    }

    @OnClick(R.id.input_birthdate)
    public void onClickBirthDate(View view) {
        mPresenter.onClickBirthDate();
    }

    private DatePickerDialog.OnDateSetListener mOnBirthDateSetListener = new DatePickerDialog.OnDateSetListener() {
        @Override
        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
            mPresenter.onBirthDateSet(year, month, dayOfMonth);
        }
    };
}
