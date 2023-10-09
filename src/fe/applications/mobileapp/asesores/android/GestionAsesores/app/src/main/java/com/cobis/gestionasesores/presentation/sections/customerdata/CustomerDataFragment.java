package com.cobis.gestionasesores.presentation.sections.customerdata;

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

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.presentation.address.PostalCodeAdapter;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.BooleanQuestionView;
import com.cobis.gestionasesores.widgets.DatePickerFragment;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;
import com.cobis.gestionasesores.widgets.searchablespinner.SearchableSpinner;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

import static android.view.View.GONE;
import static android.view.View.VISIBLE;

public class CustomerDataFragment extends SectionFragment implements CustomerDataContract.CustomerDataView {
    private static final String DATE_DIALOG = "date_dialog";

    private static final int REQUEST_SELECT_PARTNER = 1;

    @BindView(R.id.spinner_sex)
    Spinner mSexSpinner;
    @BindView(R.id.spinner_federal_entity)
    SearchableSpinner mFederalEntitySpinner;
    @BindView(R.id.spinner_birth_country)
    Spinner mBirthCountrySpinner;
    @BindView(R.id.spinner_civil_status)
    Spinner mCivilStatusSpinner;
    @BindView(R.id.spinner_nationality)
    Spinner mNationalitySpinner;
    @BindView(R.id.spinner_education_level)
    Spinner mEducationLevelSpinner;
    @BindView(R.id.spinner_occupation)
    Spinner mOccupationSpinner;
    @BindView(R.id.spinner_technical_degree)
    Spinner mTechnicalDegreeSpinner;
    @BindView(R.id.spinner_other_incomes)
    Spinner mOtherIncomesSpinner;
    @BindView(R.id.spinner_relationship)
    Spinner mRelationshipSpinner;

    @BindView(R.id.input_layout_first_name)
    TextInputLayout mFirstNameInputLayout;
    @BindView(R.id.input_layout_second_name)
    TextInputLayout mSecondNameInputLayout;
    @BindView(R.id.input_layout_last_name)
    TextInputLayout mLastNameInputLayout;
    @BindView(R.id.input_layout_second_last_name)
    TextInputLayout mSecondLastNameInputLayout;
    @BindView(R.id.input_layout_economic_dependents)
    TextInputLayout mEconomicDependentsInputLayout;
    @BindView(R.id.input_layout_curp)
    TextInputLayout mCurpInputLayout;
    @BindView(R.id.input_layout_rfc)
    TextInputLayout mRfcInputLayout;
    @BindView(R.id.input_layout_other_income_amount)
    TextInputLayout mOtherIncomeAmountInputLayout;
    @BindView(R.id.input_layout_num_cycles_other_institutions)
    TextInputLayout mCyclesOtherInstitutionsInputLayout;
    @BindView(R.id.input_layout_function_performed)
    TextInputLayout mFunctionPerformedInputLayout;
    @BindView(R.id.input_layout_birthdate)
    TextInputLayout mBirthDateInputLayout;

    @BindView(R.id.input_customer_number)
    TextInputEditText mCustomerNumberEditText;
    @BindView(R.id.input_first_name)
    TextInputEditText mFirstNameEditText;
    @BindView(R.id.input_second_name)
    TextInputEditText mSecondNameEditText;
    @BindView(R.id.input_last_name)
    TextInputEditText mLastNameEditText;
    @BindView(R.id.input_second_last_name)
    TextInputEditText mSecondLastNameEditText;
    @BindView(R.id.input_economic_dependents)
    TextInputEditText mEconomicDependentsEditText;
    @BindView(R.id.input_curp)
    TextInputEditText mCurpEditText;
    @BindView(R.id.input_rfc)
    TextInputEditText mRfcEditText;
    @BindView(R.id.input_other_income_amount)
    CurrencyInputEditText mOtherIncomesAmountEditText;
    @BindView(R.id.input_num_cycles_other_institutions)
    TextInputEditText mNumCyclesOtherInstitutionsEditText;
    @BindView(R.id.input_function_performed)
    TextInputEditText mFunctionPerformedEditText;
    @BindView(R.id.input_customer_account_number)
    TextInputEditText mCustomerAccountNumberEditText;
    @BindView(R.id.input_birthdate)
    TextInputEditText mBirthDateText;

    @BindView(R.id.boolean_question_has_other_incomes)
    BooleanQuestionView mHasOtherIncomeQuestion;
    @BindView(R.id.boolean_question_is_politically_exposed)
    BooleanQuestionView mIsPoliticallyExposedQuestion;
    @BindView(R.id.boolean_question_has_relationship_politically_exposed)
    BooleanQuestionView mHasPoliticallyExposedRelationshipQuestion;

    private CatalogItemAdapter mSexAdapter;
    private PostalCodeAdapter mFederalEntityAdapter;
    private CatalogItemAdapter mBirthCountryAdapter;
    private CatalogItemAdapter mCivilStatusAdapter;
    private CatalogItemAdapter mNationalityAdapter;
    private CatalogItemAdapter mEducationLevelAdapter;
    private CatalogItemAdapter mOccupationAdapter;
    private CatalogItemAdapter mTechnicalDegreeAdapter;
    private CatalogItemAdapter mOtherIncomesAdapter;
    private CatalogItemAdapter mRelationshipAdapter;
    private CustomerDataContract.CustomerDataPresenter mPresenter;

    public static CustomerDataFragment newInstance() {
        Bundle args = new Bundle();
        CustomerDataFragment fragment = new CustomerDataFragment();
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
        return inflater.inflate(R.layout.fragment_customer_data, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mOtherIncomesAmountEditText.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());
        mSexAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_sex);
        mBirthCountryAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_birth_country);
        mCivilStatusAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_civil_status);
        mNationalityAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_nationality);
        mEducationLevelAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_education_level);
        mOccupationAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.form_hint_occupation);
        mTechnicalDegreeAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_data_hint_technical_degree);
        mOtherIncomesAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_data_hint_other_incomes);
        mRelationshipAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.customer_data_hint_relationship);
        mFederalEntityAdapter = new PostalCodeAdapter(getContext(), new ArrayList<PostalCode>(), R.string.form_hint_birth_entity);

        mSexSpinner.setAdapter(mSexAdapter);
        mFederalEntitySpinner.setAdapter(mFederalEntityAdapter);
        mBirthCountrySpinner.setAdapter(mBirthCountryAdapter);
        mCivilStatusSpinner.setAdapter(mCivilStatusAdapter);
        mNationalitySpinner.setAdapter(mNationalityAdapter);
        mEducationLevelSpinner.setAdapter(mEducationLevelAdapter);
        mOccupationSpinner.setAdapter(mOccupationAdapter);
        mTechnicalDegreeSpinner.setAdapter(mTechnicalDegreeAdapter);
        mTechnicalDegreeSpinner.setEnabled(false);
        mOtherIncomesSpinner.setAdapter(mOtherIncomesAdapter);
        mRelationshipSpinner.setAdapter(mRelationshipAdapter);

        mHasOtherIncomeQuestion.setOptionCheckListener(mOnCheckHasOtherIncome);
        mIsPoliticallyExposedQuestion.setOptionCheckListener(mOnCheckIsPoliticallyExposed);
        mIsPoliticallyExposedQuestion.setEnabled(false);
        mHasPoliticallyExposedRelationshipQuestion.setOptionCheckListener(mOnCheckHasPoliticallyExposedRelationship);

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
                mPresenter.onClickFinish(buildCustomerData());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(CustomerDataContract.CustomerDataPresenter presenter) {
        mPresenter = presenter;
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
    public void showCivilStatus(List<CatalogItem> civilStatus) {
        mCivilStatusAdapter.setCatalogItems(civilStatus);
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
    public void showTechnicalLevels(List<CatalogItem> technicalLevels) {
        mTechnicalDegreeAdapter.setCatalogItems(technicalLevels);
    }

    @Override
    public void showOtherIncomes(List<CatalogItem> otherIncomes) {
        mOtherIncomesAdapter.setCatalogItems(otherIncomes);
    }

    @Override
    public void showRelationships(List<CatalogItem> relationships) {
        mRelationshipAdapter.setCatalogItems(relationships);
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
    public void clearErrors() {
        mFirstNameInputLayout.setErrorEnabled(false);
        mSecondNameInputLayout.setErrorEnabled(false);
        mLastNameInputLayout.setErrorEnabled(false);
        mEconomicDependentsInputLayout.setErrorEnabled(false);
        mOtherIncomeAmountInputLayout.setErrorEnabled(false);
        mCyclesOtherInstitutionsInputLayout.setErrorEnabled(false);
        mFunctionPerformedInputLayout.setErrorEnabled(false);

        mHasOtherIncomeQuestion.clearError();
        mIsPoliticallyExposedQuestion.clearError();
        mHasPoliticallyExposedRelationshipQuestion.clearError();

        mBirthDateInputLayout.setErrorEnabled(false);

        mSexAdapter.clearError();
        mFederalEntityAdapter.clearError();
        mBirthCountryAdapter.clearError();
        mCivilStatusAdapter.clearError();
        mNationalityAdapter.clearError();
        mEducationLevelAdapter.clearError();
        mOccupationAdapter.clearError();
        mOtherIncomesAdapter.clearError();
        mRelationshipAdapter.clearError();
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
    public void showAdultAgeError(int minAge,int maxAge) {
        mBirthDateInputLayout.setError(getString(R.string.val_invalid_adult_age, minAge,maxAge));
    }

    @Override
    public void disableIdentificationFields() {
        mFirstNameInputLayout.setEnabled(false);
        mSecondNameInputLayout.setEnabled(false);
        mLastNameInputLayout.setEnabled(false);
        mSecondLastNameInputLayout.setEnabled(false);
        mBirthDateInputLayout.setEnabled(false);
        mFederalEntitySpinner.setEnabled(false);
        mSexSpinner.setEnabled(false);
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
    public void showCivilStatusError() {
        mCivilStatusAdapter.showError(R.string.val_field_required);
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
    public void showEconomicDependentsError(int min, int max) {
        mEconomicDependentsInputLayout.setError(getString(R.string.val_invalid_range, min, max));
    }

    @Override
    public void showHasOtherIncomeSourcesError() {
        mHasOtherIncomeQuestion.showError(R.string.val_field_required);
    }

    @Override
    public void showOtherIncomeSourcesError() {
        mOtherIncomesAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showOtherIncomeSourcesAmountError() {
        mOtherIncomeAmountInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showNumCyclesOtherInstitutionsError() {
        mCyclesOtherInstitutionsInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showHasRelationshipPoliticallyExposedError() {
        mHasPoliticallyExposedRelationshipQuestion.showError(R.string.val_field_required);
    }

    @Override
    public void showRelationshipError() {
        mRelationshipAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void setBirthDate(Long date) {
        mBirthDateText.setTag(date);
        mBirthDateText.setText(DateUtils.formatDate(date));
    }

    @Override
    public void setCustomerData(CustomerData customerData) {
        //General Data
        GeneralPersonData generalPersonData = customerData.getGeneralPersonData();
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
        String rfc = generalPersonData.getRfc();
        toggleRfc(rfc != null);
        mRfcEditText.setText(rfc);
        //Specific customer data
        mCustomerNumberEditText.setText(customerData.getCustomerNumber());
        mCivilStatusSpinner.setSelection(mCivilStatusAdapter.getItemPositionByCode(customerData.getCivilStatus()));
        mEconomicDependentsEditText.setText(customerData.getEconomicDependents());
        String curp = customerData.getCurp();
        toggleCurp(curp != null);
        mCurpEditText.setText(curp);
        String technicalDegree = customerData.getTechnicalDegree();
        toggleTechnicalDegree(technicalDegree != null);
        mTechnicalDegreeSpinner.setSelection(mTechnicalDegreeAdapter.getItemPositionByCode(technicalDegree));
        mHasOtherIncomeQuestion.checkOption(customerData.hasOtherIncomeSources());
        mOtherIncomesSpinner.setSelection(mOtherIncomesAdapter.getItemPositionByCode(customerData.getOtherIncomeSources()));
        mOtherIncomesAmountEditText.setCurrencyValue(customerData.getOtherIncomeSourcesAmount());
        mNumCyclesOtherInstitutionsEditText.setText(String.valueOf(customerData.getNumCyclesOtherInstitutions()));
        Boolean isPoliticallyExposed = customerData.isPoliticallyExposed();
        togglePoliticallyExposed(isPoliticallyExposed != null);
        mIsPoliticallyExposedQuestion.checkOption(isPoliticallyExposed);
        mFunctionPerformedEditText.setText(customerData.getFunctionPerformed());
        mHasPoliticallyExposedRelationshipQuestion.checkOption(customerData.hasRelationshipPoliticallyExposed());
        mRelationshipSpinner.setSelection(mRelationshipAdapter.getItemPositionByCode(customerData.getRelationship()));
        mCustomerAccountNumberEditText.setText(customerData.getCustomerAccountNumber());
    }

    @Override
    public void toggleOtherIncomeFields(boolean shouldShow) {
        mOtherIncomesSpinner.setVisibility(shouldShow ? VISIBLE : GONE);
        mOtherIncomeAmountInputLayout.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    @Override
    public void clearOtherIncomeFields() {
        mOtherIncomesSpinner.setSelection(0);
        mOtherIncomesAmountEditText.setCurrencyValue(0);
    }

    @Override
    public void togglePoliticallyExposedFields(boolean shouldShow) {
        mFunctionPerformedInputLayout.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    @Override
    public void clearPoliticallyExposedFields() {
        mFunctionPerformedEditText.getText().clear();
    }

    @Override
    public void togglePoliticallyExposedRelationship(boolean shouldShow) {
        mRelationshipSpinner.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    @Override
    public void clearPoliticallyExposedRelationship() {
        mRelationshipSpinner.setSelection(0);
    }

    @Override
    public void toggleRfc(boolean shouldShow) {
        mRfcInputLayout.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    @Override
    public void toggleCurp(boolean shouldShow) {
        mCurpInputLayout.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    @Override
    public void togglePoliticallyExposed(boolean shouldShow) {
        mIsPoliticallyExposedQuestion.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    @Override
    public void toggleTechnicalDegree(boolean shouldShow) {
        mTechnicalDegreeSpinner.setVisibility(shouldShow ? VISIBLE : GONE);
    }

    public CustomerData buildCustomerData() {
        GeneralPersonData generalPersonData = new GeneralPersonData.Builder()
                .setFirstName(mFirstNameEditText.getText().toString().trim())
                .setSecondName(mSecondNameEditText.getText().toString().trim())
                .setLastName(mLastNameEditText.getText().toString().trim())
                .setSecondLastName(mSecondLastNameEditText.getText().toString().trim())
                .setSex(mSexAdapter.getItemCode(mSexSpinner.getSelectedItemPosition()).trim())
                .setBirthEntityCode(mFederalEntityAdapter.getItem(mFederalEntitySpinner.getSelectedItemPosition()).getCode())
                .setBirthEntityAdditionalCode(mFederalEntityAdapter.getItem(mFederalEntitySpinner.getSelectedItemPosition()).getAdditionalCode())
                .setBirthCountry(mBirthCountryAdapter.getItemCode(mBirthCountrySpinner.getSelectedItemPosition()))
                .setBirthDate((Long) mBirthDateText.getTag())
                .setNationality(mNationalityAdapter.getItemCode(mNationalitySpinner.getSelectedItemPosition()))
                .setEducationLevel(mEducationLevelAdapter.getItemCode(mEducationLevelSpinner.getSelectedItemPosition()))
                .setOccupation(mOccupationAdapter.getItemCode(mOccupationSpinner.getSelectedItemPosition()))
                .setRfc(mRfcEditText.getText().toString())
                .build();

        return new CustomerData.Builder()
                .addGeneralPersonData(generalPersonData)
                .addCustomerNumber(mCustomerNumberEditText.getText().toString().trim())
                .addCivilStatus(mCivilStatusAdapter.getItemCode(mCivilStatusSpinner.getSelectedItemPosition()))
                .addEconomicDependents(mEconomicDependentsEditText.getText().toString().trim())
                .addHasOtherIncomeSources(mHasOtherIncomeQuestion.getResponse())
                .addOtherIncomeSources(mOtherIncomesAdapter.getItemCode(mOtherIncomesSpinner.getSelectedItemPosition()))
                .addOtherIncomeSourcesAmount(mOtherIncomesAmountEditText.getCurrencyValue())
                .addNumCyclesOtherInstitutions(ConvertUtils.tryToInt(mNumCyclesOtherInstitutionsEditText.getText().toString().trim(), 0))
                .addHasRelationshipPoliticallyExposed(mHasPoliticallyExposedRelationshipQuestion.getResponse())
                .addRelationship(mRelationshipAdapter.getItemCode(mRelationshipSpinner.getSelectedItemPosition()))
                .addCustomerAccountNumber(mCustomerAccountNumberEditText.getText().toString().trim())
                .addCurp(mCurpEditText.getText().toString().trim())
                .build();
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

    private BooleanQuestionView.OnOptionCheckListener mOnCheckHasOtherIncome = new BooleanQuestionView.OnOptionCheckListener() {
        @Override
        public void onCheck(@BooleanQuestionView.CheckOption int checkedOption) {
            mPresenter.onCheckHasOtherIncome(checkedOption);
        }
    };

    private BooleanQuestionView.OnOptionCheckListener mOnCheckIsPoliticallyExposed = new BooleanQuestionView.OnOptionCheckListener() {
        @Override
        public void onCheck(@BooleanQuestionView.CheckOption int checkedOption) {
            mPresenter.onCheckIsPoliticallyExposed(checkedOption);
        }
    };

    private BooleanQuestionView.OnOptionCheckListener mOnCheckHasPoliticallyExposedRelationship = new BooleanQuestionView.OnOptionCheckListener() {
        @Override
        public void onCheck(@BooleanQuestionView.CheckOption int checkedOption) {
            mPresenter.onCheckHasPoliticallyExposedRelationship(checkedOption);
        }
    };
}