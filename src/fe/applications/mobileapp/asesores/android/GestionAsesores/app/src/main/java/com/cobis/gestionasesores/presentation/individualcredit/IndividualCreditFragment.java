package com.cobis.gestionasesores.presentation.individualcredit;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.SwitchCompat;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Guarantor;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.responses.Message;
import com.cobis.gestionasesores.presentation.customers.CustomersPresenter;
import com.cobis.gestionasesores.presentation.customers.SelectCustomerActivity;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.utils.ResourcesUtil;
import com.cobis.gestionasesores.widgets.GaugeView;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyTextFormatter;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class IndividualCreditFragment extends ErrorBaseFragment implements IndividualCreditContract.View {
    private static final int REQUEST_GUARANTOR = 100;
    @BindView(R.id.text_applicant_name)
    TextView mApplicantNameText;
    @BindView(R.id.input_credit_date)
    TextInputEditText mDateEditText;
    @BindView(R.id.input_adviser)
    TextInputEditText mAdviserEditText;
    @BindView(R.id.input_branch_office)
    TextInputEditText mBranchOfficeEditText;
    @BindView(R.id.text_partner)
    TextView mPartnerText;
    @BindView(R.id.text_old_amount)
    TextView mOldAmountText;
    @BindView(R.id.input_request_amount)
    CurrencyInputEditText mRequestAmountEditText;
    @BindView(R.id.input_auth_amount)
    CurrencyInputEditText mAuthAmountEditText;
    @BindView(R.id.input_rate)
    TextInputEditText mRateEditText;
    @BindView(R.id.spinner_destination_credit)
    Spinner mDestinationSpinner;
    @BindView(R.id.spinner_terms)
    Spinner mTermsSpinner;
    @BindView(R.id.spinner_frequency)
    Spinner mFrequencySpinner;
    @BindView(R.id.switch_renovation)
    SwitchCompat mRenovationSwitch;
    @BindView(R.id.switch_promotion)
    SwitchCompat mPromotionSwitch;
    @BindView(R.id.gauge_risk_level)
    GaugeView mRiskLevelView;
    @BindView(R.id.gauge_guarantor_risk_level)
    GaugeView mGuarantorRiskLevelView;
    @BindView(R.id.guarantor_container)
    View mGuarantorView;
    @BindView(R.id.text_guarantor_name)
    TextView mGuarantorNameText;
    @BindView(R.id.input_guarantor_document)
    TextInputEditText mGuarantorDocumentInput;
    @BindView(R.id.button_add_guarantor)
    Button mAddGuarantorButton;
    @BindView(R.id.label_risk_level)
    TextView mRiskLevelLabel;
    @BindView(R.id.label_gurantor_risk_level)
    TextView mGuarantorRiskLevelLabel;

    @BindView(R.id.input_layout_request_amount)
    TextInputLayout mRequestAmountInputLayout;
    @BindView(R.id.input_layout_credit_date)
    TextInputLayout mDateInputLayout;
    @BindView(R.id.input_layout_adviser)
    TextInputLayout mAdviserInputLayout;
    @BindView(R.id.input_layout_branch_office)
    TextInputLayout mBranchOfficeInputLayout;
    @BindView(R.id.guarantor_error)
    TextView mGuarantorError;

    private CatalogItemAdapter mDestinationAdapter;
    private CatalogItemAdapter mTermsAdapter;
    private CatalogItemAdapter mFrequencyAdapter;
    private boolean mShowDeleteOption = false;
    private IndividualCreditContract.Presenter mPresenter;
    private boolean mShowOptionsMenu = true;
    private ProgressDialog mProgressDialog;

    public static IndividualCreditFragment newInstance() {
        Bundle args = new Bundle();
        IndividualCreditFragment fragment = new IndividualCreditFragment();
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
        return inflater.inflate(R.layout.fragment_individual_credit, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        Locale locale = BankAdvisorApp.getInstance().getConfig().getLocale();
        mRequestAmountEditText.setLocale(locale);
        mAuthAmountEditText.setLocale(locale);

        mDestinationAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.credit_app_individual_hint_destination);
        mDestinationSpinner.setAdapter(mDestinationAdapter);

        mTermsAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.credit_app_individual_hint_terms);
        mTermsSpinner.setAdapter(mTermsAdapter);

        mFrequencyAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.credit_app_individual_hint_frequency);
        mFrequencySpinner.setAdapter(mFrequencyAdapter);

        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.form_actions, menu);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        if (!mShowOptionsMenu) {
            menu.clear();
        } else {
            menu.findItem(R.id.menu_delete).setVisible(mShowDeleteOption);
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish:
                mPresenter.onClickSave(getIndividualCreditApp());
                return true;
            case R.id.menu_delete:
                mPresenter.onClickDelete();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_GUARANTOR && Activity.RESULT_OK == resultCode) {
            mPresenter.onGuarantorSelected((Person) data.getSerializableExtra(SelectCustomerActivity.EXTRA_CUSTOMER));
        } else {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

    @OnClick(R.id.button_add_guarantor)
    public void onClickGuarantor(View view) {
        mPresenter.onClickSelectGuarantor();
    }

    @Override
    public void setPresenter(IndividualCreditContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setIndividualCreditApp(IndividualCreditApp creditApp) {
        mApplicantNameText.setText(creditApp.getApplicantName());
        mDateEditText.setTag(creditApp.getCreationDate());
        mDateEditText.setText(DateUtils.formatDate(creditApp.getCreationDate()));
        mAdviserEditText.setText(creditApp.getAdviser());
        mAdviserEditText.setText(creditApp.getAdviser());
        mBranchOfficeEditText.setText(creditApp.getBranchOffice());
        mPartnerText.setText(getString(R.string.credit_app_individual_partner, creditApp.isPartner() ? getString(R.string.yes) : getString(R.string.not)));
        String previousAmount = CurrencyTextFormatter.formatText(creditApp.getPreviousCreditAmount(), BankAdvisorApp.getInstance().getConfig().getLocale());
        mOldAmountText.setText(getString(R.string.credit_app_individual_old_amount, previousAmount));
        mDestinationSpinner.setSelection(mDestinationAdapter.getItemPositionByCode(creditApp.getDestination()));
        mTermsSpinner.setSelection(mTermsAdapter.getItemPositionByCode(creditApp.getTerm()));
        mFrequencySpinner.setSelection(mFrequencyAdapter.getItemPositionByCode(creditApp.getFrequency()));
        mRateEditText.setText(creditApp.getRate());
        mPromotionSwitch.setChecked(creditApp.isPromotion());
        mRequestAmountEditText.setCurrencyValue(creditApp.getAmount());
        mAuthAmountEditText.setCurrencyValue(creditApp.getAuthorizedAmount());
    }

    @Override
    public void showCreditDestinations(List<CatalogItem> items) {
        mDestinationAdapter.setCatalogItems(items);
    }

    @Override
    public void showCreditTerms(List<CatalogItem> items) {
        mTermsAdapter.setCatalogItems(items);
    }

    @Override
    public void showCreditFrequency(List<CatalogItem> items) {
        mFrequencyAdapter.setCatalogItems(items);
    }

    @Override
    public void setFixedCreditFrequency(String code) {
        mFrequencySpinner.setEnabled(false);
        mFrequencySpinner.setAlpha(0.5f);
        mFrequencySpinner.setSelection(mFrequencyAdapter.getItemPositionByCode(code));
    }

    @Override
    public void toggleApplicationDate(boolean shouldShow) {
        mDateInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleAdviser(boolean shouldShow) {
        mAdviserInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleBranchOffice(boolean shouldShow) {
        mBranchOfficeInputLayout.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleRate(boolean shouldShow) {
        mRateEditText.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void toggleRenew(boolean shouldShow) {
        mRenovationSwitch.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void togglePreviousCredit(boolean shouldShow) {
        mOldAmountText.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void drawRiskLevel(String riskLevel) {
        mRiskLevelLabel.setVisibility(View.VISIBLE);
        mRiskLevelView.setItemTarget(ResourcesUtil.getGaugeItemFromRiskLevel(riskLevel));
        mRiskLevelView.setCaption(getString(ResourcesUtil.getRiskLevelStringResource(riskLevel)));
        mRiskLevelView.postDelayed(new Runnable() {
            @Override
            public void run() {
                mRiskLevelView.play();
            }
        }, Constants.RISK_LEVEL_ANIMATION_DELAY);
    }

    @Override
    public void hideRiskLevel() {
        mRiskLevelLabel.setVisibility(View.GONE);
        mRiskLevelView.setVisibility(View.GONE);
    }

    @Override
    public void hideGuarantorRiskLevel() {
        mGuarantorRiskLevelLabel.setVisibility(View.GONE);
        mGuarantorRiskLevelView.setVisibility(View.GONE);
    }

    @Override
    public void showDeleteOption() {
        mShowDeleteOption = true;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void drawGuarantorRiskLevel(String riskLevel) {
        mGuarantorRiskLevelLabel.setVisibility(View.VISIBLE);
        mGuarantorRiskLevelView.setItemTarget(ResourcesUtil.getGaugeItemFromRiskLevel(riskLevel));
        mGuarantorRiskLevelView.setCaption(getString(ResourcesUtil.getRiskLevelStringResource(riskLevel)));
        mGuarantorRiskLevelView.postDelayed(new Runnable() {
            @Override
            public void run() {
                mGuarantorRiskLevelView.play();
            }
        }, Constants.RISK_LEVEL_ANIMATION_DELAY);
    }

    @Override
    public void showConfirmDeleteDialog() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.credit_app_dialog_delete).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
                mPresenter.onConfirmDelete();
            }
        }).setNegativeButton(R.string.action_cancel, null).show();
    }

    @Override
    public void showUpdateSuccess() {
        Toast.makeText(getContext(), getString(R.string.credit_app_updated_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showSaveSuccess(String message) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.credit_app_created_message), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            exit();
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showSavingProgress() {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(R.string.progress_save_msg));
            mProgressDialog.setCancelable(false);
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.show();
        }
    }

    @Override
    public void hideProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.error_message_network).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showCustomerNotSyncedError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.credit_app_sync_customer_error)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showWarningMessage(String warning) {
        new AlertDialog.Builder(getContext())
                .setTitle(R.string.warning)
                .setMessage(getString(R.string.credit_app_warning_tpl,warning))
                .setCancelable(false)
                .setPositiveButton(R.string.action_next, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        mPresenter.onClickConfirmation();
                    }
                })
                .setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                    }
                })
                .show();
    }

    @Override
    public void showMessageExit() {
        new AlertDialog.Builder(getContext()).setTitle(R.string.credit_app_individual_title).setMessage(R.string.credit_app_exit_message).setCancelable(false).setPositiveButton(R.string.action_save, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                mPresenter.onClickLocalSave();
            }
        }).setNegativeButton(R.string.action_discard, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                exit();
            }
        }).show();
    }

    @Override
    public void showSaveError() {
        Toast.makeText(getContext(), getString(R.string.credit_app_failure_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showSaveError(Message message) {
        String msg;
        if (message != null && StringUtils.isNotEmpty(message.getMessage())) {
            msg = message.getMessage();
        } else {
            msg = getString(R.string.error_save);
        }

        new AlertDialog.Builder(getContext()).setMessage(msg).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showDeleteSuccess() {
        Toast.makeText(getContext(), getString(R.string.credit_app_deleted_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showDeleteError() {
        Toast.makeText(getContext(), getString(R.string.credit_app_failure_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void startSelectGuarantor(int[] customersSelected) {
        startActivityForResult(SelectCustomerActivity.newIntent(getContext(), customersSelected, null, CustomersPresenter.Mode.GUARANTOR), REQUEST_GUARANTOR);
    }

    @Override
    public void setGuarantor(Guarantor guarantor) {
        mGuarantorView.setVisibility(View.VISIBLE);
        mAddGuarantorButton.setText(R.string.action_edit);
        mGuarantorView.setTag(guarantor);
        mGuarantorNameText.setText(guarantor.getName());
        mGuarantorDocumentInput.setText(guarantor.getDocument());
    }

    @Override
    public void showDestinationError() {
        mDestinationAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTermError() {
        mTermsAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showFrequencyError() {
        mFrequencyAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showGuarantorError() {
        mGuarantorError.setText(R.string.credit_app_individual_invalid_guarantor);
        mGuarantorError.setVisibility(View.VISIBLE);
    }

    @Override
    public void showRequestAmountError() {
        mRequestAmountInputLayout.setError(getString(R.string.credit_app_error_amount, BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.AMOUNT_REQUEST_APP)));
    }

    @Override
    public void clearErrors() {
        mGuarantorError.setVisibility(View.GONE);
        mDestinationAdapter.clearError();
        mFrequencyAdapter.clearError();
        mTermsAdapter.clearError();
        mRequestAmountInputLayout.setErrorEnabled(false);
    }

    @Override
    public void setReadOnly(boolean isReadOnly) {
        if (isReadOnly) {
            mShowOptionsMenu = false;
            getActivity().invalidateOptionsMenu();
            mPromotionSwitch.setEnabled(false);
            mRenovationSwitch.setEnabled(false);
            mTermsSpinner.setEnabled(false);
            mDestinationSpinner.setEnabled(false);
            mFrequencySpinner.setEnabled(false);
            mRequestAmountEditText.setEnabled(false);
            mAuthAmountEditText.setEnabled(false);
            mAddGuarantorButton.setVisibility(View.INVISIBLE);
        }
    }

    public IndividualCreditApp getIndividualCreditApp() {
        //Note: Send only data edited!!
        return new IndividualCreditApp.Builder().setRenovation(mRenovationSwitch.isChecked()).setDestination(mDestinationAdapter.getItemCode(mDestinationSpinner.getSelectedItemPosition())).setTerm(mTermsAdapter.getItemCode(mTermsSpinner.getSelectedItemPosition())).setFrequency(mFrequencyAdapter.getItemCode(mFrequencySpinner.getSelectedItemPosition())).setPromotion(mPromotionSwitch.isChecked()).setAmount(mRequestAmountEditText.getCurrencyValue()).setAuthorizedAmount(mAuthAmountEditText.getCurrencyValue()).setGuarantor((Guarantor) mGuarantorView.getTag()).build();
    }
}