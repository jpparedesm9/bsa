package com.cobis.gestionasesores.presentation.simulation;

import android.app.DatePickerDialog;
import android.app.ProgressDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.DatePicker;
import android.widget.RelativeLayout;
import android.widget.Spinner;
import android.widget.TextView;

import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.SimulationResult;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.simulation.simulationtable.SimulationTableActivity;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.DatePickerFragment;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

import static android.net.ConnectivityManager.EXTRA_NO_CONNECTIVITY;

/**
 * Created by Josue Ortiz on 01/08/2017.
 * Gets the data needed to make an amortization table
 */

public class SimulationFragment extends Fragment implements SimulationContract.SimulationView {
    private static final String DATE_DIALOG = "date_dialog";

    @BindView(R.id.layout_start_date)
    TextView mStartDateLayout;
    @BindView(R.id.input_layout_principal_amount)
    TextInputLayout mAmountLayout;
    @BindView(R.id.input_layout_interest_rate)
    TextInputLayout mInterestLayout;
    @BindView(R.id.input_interest_rate_percent)
    TextView mInterestRatePercent;

    @BindView(R.id.input_start_date)
    TextView mStartDateTextView;
    @BindView(R.id.input_principal_amount)
    CurrencyInputEditText mAmountCurrency;
    @BindView(R.id.input_interest_rate)
    TextInputEditText mInterestEditText;

    @BindView(R.id.layout_interest_rate)
    View mInterestRateLayout;

    //Spinners
    @BindView(R.id.spinner_credit_type)
    Spinner mSpinnerCreditType;
    @BindView(R.id.spinner_frequency)
    Spinner mSpinnerFrequency;
    @BindView(R.id.spinner_term_months)
    Spinner mTermMonthsSpinner;

    //Loading Circle
    private ProgressDialog mProgressDialog;

    private SimulationContract.SimulationPresenter mPresenter;
    private CatalogItemAdapter mCreditTypeAdapter;
    private CatalogItemAdapter mFrequencyAdapter;
    private CatalogItemAdapter mTermMonthsAdapter;

    public static SimulationFragment newInstance() {
        return new SimulationFragment();
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_simulator, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        mAmountCurrency.setLocale(BankAdvisorApp.getInstance().getConfig().getLocale());

        //setup spinner
        mFrequencyAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.simulation_input_data_hint_frequency);
        mCreditTypeAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.simulation_input_data_hint_credit_type);
        mTermMonthsAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.simulation_input_data_hint_term_months);

        mSpinnerFrequency.setAdapter(mFrequencyAdapter);
        mSpinnerCreditType.setAdapter(mCreditTypeAdapter);
        mTermMonthsSpinner.setAdapter(mTermMonthsAdapter);
        mSpinnerCreditType.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                mPresenter.onCreditTypeChange(mCreditTypeAdapter.getItemCode(position));
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
        mPresenter.start();
    }

    public void setPresenter(SimulationContract.SimulationPresenter presenter) {
        mPresenter = presenter;
    }

    @OnClick({R.id.button_calculate})
    public void onClickCalculate(View view) {
        SimulationData data = new SimulationData();
        data.setAmount(mAmountCurrency.getCurrencyValue());
        data.setTerm(mTermMonthsAdapter.getItemCode(mTermMonthsSpinner.getSelectedItemPosition()));
        data.setInterest(ConvertUtils.tryToFloat(mInterestEditText.getText().toString(), -1));
        data.setCreditType(mCreditTypeAdapter.getItemCode(mSpinnerCreditType.getSelectedItemPosition()));
        data.setFrequency(mFrequencyAdapter.getItemCode(mSpinnerFrequency.getSelectedItemPosition()));
        data.setDate((Long) mStartDateTextView.getTag());
        mPresenter.simulate(data);
    }

    @OnClick({R.id.button_clean})
    public void onClickCleanFields(View view) {
        mPresenter.resetSimulation();
    }

    @Override
    public void cleanAllErrors() {
        mAmountLayout.setErrorEnabled(false);
        mInterestLayout.setErrorEnabled(false);
        mTermMonthsAdapter.clearError();
        mFrequencyAdapter.clearError();
        mCreditTypeAdapter.clearError();

        RelativeLayout.LayoutParams lp = (RelativeLayout.LayoutParams) mInterestRatePercent.getLayoutParams();
        lp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM,1);
        lp.addRule(RelativeLayout.CENTER_VERTICAL,0);
        mInterestRatePercent.setLayoutParams(lp);
    }

    @Override
    public void setDate(Long date) {
        mStartDateTextView.setTag(date);
        mStartDateTextView.setText(DateUtils.formatDate(date));
    }

    @Override
    public void showDateFormatError() {
        mStartDateLayout.setError(getString(R.string.simulation_input_data_date_format_error));
    }

    @Override
    public void showAmountError() {
        mAmountLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showInterestError() {
        mInterestLayout.setError(getString(R.string.val_field_required));
        RelativeLayout.LayoutParams lp = (RelativeLayout.LayoutParams) mInterestRatePercent.getLayoutParams();
        lp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM,0);
        lp.addRule(RelativeLayout.CENTER_VERTICAL,1);
        mInterestRatePercent.setLayoutParams(lp);
    }

    @Override
    public void showInterestOutOfBoundsError() {
        mInterestLayout.setError(getString(R.string.simulation_input_data_interest_rate_out_of_bounds_error));
    }

    @Override
    public void showTimeLimitError() {
        mTermMonthsAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showCreditFrequencyCatalog(List<CatalogItem> frequencyType) {
        mFrequencyAdapter.setCatalogItems(frequencyType);
    }

    @Override
    public void showCreditTypeCatalog(List<CatalogItem> creditType) {
        mCreditTypeAdapter.setCatalogItems(creditType);
    }

    @Override
    public void showTermMonthsCatalog(List<CatalogItem> termMonths) {
        mTermMonthsAdapter.setCatalogItems(termMonths);
    }

    @Override
    public void setOpeningDate(Long date) {
        mStartDateTextView.setTag(date);
        mStartDateTextView.setText(DateUtils.formatDate(date));
    }

    @OnClick(R.id.input_start_date)
    public void onClickOpeningDate(View view) {
        mPresenter.onClickOpeningDate();
    }

    @Override
    public void showLoading() {
        mProgressDialog = new ProgressDialog(getContext());
        mProgressDialog.setMessage(getString(R.string.simulation_input_loading));
        mProgressDialog.setCancelable(false);
        mProgressDialog.setCanceledOnTouchOutside(false);
        mProgressDialog.show();
    }

    @Override
    public void hideLoading() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void resetFields() {
        mAmountCurrency.setCurrencyValue(0.0);
        mInterestEditText.setText("");
        mTermMonthsSpinner.setSelection(0);
        mSpinnerFrequency.setSelection(0);
        mSpinnerCreditType.setSelection(0);
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.error_message_network)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showCreditTypeError() {
        mCreditTypeAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showFrequencyError() {
        mFrequencyAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showResult(final SimulationResult simulationResult) {
        if (simulationResult.getErrorMessage() == null) {
            startActivity(SimulationTableActivity.newIntent(getContext(), simulationResult));
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(simulationResult.getErrorMessage())
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            startActivity(SimulationTableActivity.newIntent(getContext(), simulationResult));
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showComputeError(String message) {
        new AlertDialog.Builder(getContext())
                .setMessage(StringUtils.isNotEmpty(message) ? message : getString(R.string.simulation_error_compute))
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void setCreditType(String type) {
        mSpinnerCreditType.setSelection(mCreditTypeAdapter.getItemPositionByCode(type));
    }

    @Override
    public void enableCreditType(boolean enable) {
        mSpinnerCreditType.setEnabled(enable);
    }

    @Override
    public void setFrequency(String frequency) {
        mSpinnerFrequency.setSelection(mFrequencyAdapter.getItemPositionByCode(frequency));
    }

    @Override
    public void enableFrequency(boolean enable) {
        mSpinnerFrequency.setEnabled(enable);
    }

    @Override
    public void showInterest(boolean show) {
        mInterestRateLayout.setVisibility(show ? View.VISIBLE : View.GONE);
    }

    @Override
    public void showOpeningDateDialog(Long maxDate) {
        DatePickerFragment fragment = (DatePickerFragment) getActivity().getSupportFragmentManager()
                .findFragmentByTag(DATE_DIALOG);
        if (fragment == null) {
            fragment = DatePickerFragment.newInstance((Long) mStartDateTextView.getTag(), null);
            fragment.setOnDateSetListener(mOnOpeningDateSetListener);
            fragment.show(getActivity().getSupportFragmentManager(), DATE_DIALOG);
        }
    }

    private DatePickerDialog.OnDateSetListener mOnOpeningDateSetListener = new DatePickerDialog.OnDateSetListener() {
        @Override
        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
            mPresenter.onOpeningDateSet(year, month, dayOfMonth);
        }
    };

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        context.registerReceiver(mInternetReceiver, new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));
    }

    @Override
    public void onDetach() {
        super.onDetach();
        getContext().unregisterReceiver(mInternetReceiver);
    }

    private BroadcastReceiver mInternetReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            mPresenter.onInternetChangeState(!intent.getBooleanExtra(EXTRA_NO_CONNECTIVITY, false));
        }
    };

}