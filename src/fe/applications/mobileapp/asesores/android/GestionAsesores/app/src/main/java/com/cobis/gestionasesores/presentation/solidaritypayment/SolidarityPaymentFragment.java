package com.cobis.gestionasesores.presentation.solidaritypayment;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SwitchCompat;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.solidaritypayment.paymentinfo.PaymentInfoActivity;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyInputEditText;
import com.cobis.gestionasesores.widgets.currencyfield.CurrencyTextFormatter;

import java.util.Locale;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class SolidarityPaymentFragment extends ErrorBaseFragment implements SolidarityPaymentContract.View, SolidarityMemberAdapter.SolidarityMemberListener, PaymentDialog.PaymentListener {

    public static final String PAYMENT_DIALOG = "PAYMENT_DIALOG";

    private SolidarityPaymentContract.Presenter mPresenter;

    @BindView(R.id.input_group_name)
    TextInputEditText mGroupNameEditText;
    @BindView(R.id.input_application_date)
    TextInputEditText mAppDateEditText;
    @BindView(R.id.input_group_amount)
    CurrencyInputEditText mGroupAmountEditText;
    @BindView(R.id.input_payment_due)
    CurrencyInputEditText mPaymentDueEditText;
    @BindView(R.id.text_covered_amount)
    TextView mCoveredAmountText;
    @BindView(R.id.text_error)
    TextView mErrorText;
    @BindView(R.id.text_list_label)
    TextView mListLabelText;
    @BindView(R.id.switch_debit_account)
    SwitchCompat mDebitAccountSwitch;
    @BindView(R.id.list_solidarity_members)
    RecyclerView mSolidarityMembersList;

    private ProgressDialog mProgressDialog;

    private SolidarityMemberAdapter mAdapter;

    private boolean mShowSave = true;

    public static SolidarityPaymentFragment newInstance() {
        Bundle args = new Bundle();
        SolidarityPaymentFragment fragment = new SolidarityPaymentFragment();
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
        return inflater.inflate(R.layout.fragment_solidarity_payment, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        Locale locale = BankAdvisorApp.getInstance().getConfig().getLocale();
        mGroupAmountEditText.setLocale(locale);
        mPaymentDueEditText.setLocale(locale);

        mGroupNameEditText.setKeyListener(null);
        mAppDateEditText.setKeyListener(null);
        mGroupAmountEditText.setKeyListener(null);
        mPaymentDueEditText.setKeyListener(null);

        mAdapter = new SolidarityMemberAdapter(this);
        mSolidarityMembersList.setLayoutManager(new LinearLayoutManager(getContext()));
        mSolidarityMembersList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mSolidarityMembersList.setAdapter(mAdapter);

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
        menu.findItem(R.id.menu_finish).setVisible(mShowSave);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish:
                mPresenter.onSave(buildSolidarityPayment());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(SolidarityPaymentContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setSolidarityPayment(SolidarityPayment payment) {
        mGroupNameEditText.setText(payment.getName());
        mAppDateEditText.setText(DateUtils.formatDate(payment.getDate()));
        mAppDateEditText.setTag(payment.getDate());
        mGroupAmountEditText.setCurrencyValue(payment.getCreditAmount());
        mPaymentDueEditText.setCurrencyValue(payment.getPaymentDue());
        mDebitAccountSwitch.setChecked(payment.isDebitAccount());
        mAdapter.setSolidarityMembers(payment.getMembers());
        mListLabelText.setText(getString(R.string.solidarity_payment_list_title, payment.getMembers() == null ? 0 : payment.getMembers().size()));
    }

    @Override
    public void showSaveProgress() {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setMessage(getString(R.string.solidarity_payment_saving_msg));
            mProgressDialog.setCancelable(false);
            mProgressDialog.show();
        }
    }

    @Override
    public void hideSaveProgress() {
        if (mProgressDialog != null) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.error_message_network).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showSaveError(String error) {
        new AlertDialog.Builder(getContext()).setMessage(error != null ? error : getString(R.string.error_save)).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showSaveSuccess(String message) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.solidarity_payment_saved_msg), Toast.LENGTH_SHORT).show();
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
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void clearErrors() {
        mErrorText.setText(null);
        mErrorText.setVisibility(View.GONE);
    }

    @Override
    public void showPaymentPrompt(SolidarityMember member, double suggestedPayment) {
        Fragment fragment = getActivity().getSupportFragmentManager().findFragmentByTag(PAYMENT_DIALOG);
        if (fragment != null) {
            getActivity().getSupportFragmentManager().beginTransaction().remove(fragment).commit();
        }

        PaymentDialog dialog = PaymentDialog.newInstance(member, suggestedPayment);
        dialog.setListener(this);
        dialog.show(getActivity().getSupportFragmentManager(), PAYMENT_DIALOG);
    }

    @Override
    public void updateSolidarityMember(SolidarityMember member) {
        mAdapter.updateSolidarityMember(member);
    }

    @Override
    public void startMoreInformation(SolidarityPayment payment) {
        startActivity(PaymentInfoActivity.newIntent(getContext(), payment));
    }

    @Override
    public void updateCoveredAmount(double coveredAmount) {
        mCoveredAmountText.setText(CurrencyTextFormatter.formatText(coveredAmount, BankAdvisorApp.getInstance().getConfig().getLocale()));
    }

    @Override
    public void showCoveredAmountError() {
        mErrorText.setVisibility(View.VISIBLE);
        mErrorText.setText(getString(R.string.solidarity_payment_covered_amount_error));
    }

    @Override
    public void readOnly() {
        mDebitAccountSwitch.setEnabled(false);
        mAdapter.disable();
        mShowSave = false;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void onClickSolidarityMember(SolidarityMember member) {
        mPresenter.onSelectSolidarityMember(member, mAdapter.getSolidarityMembers());
    }

    @Override
    public void onAcceptPayment(SolidarityMember member) {
        mPresenter.onPaymentSet(member, mAdapter.getSolidarityMembers());
    }

    @OnClick(R.id.btn_more_information)
    public void onClickMoreInformation(View view) {
        mPresenter.onClickMoreInformation();
    }

    private SolidarityPayment buildSolidarityPayment() {
        SolidarityPayment solidarityPayment = new SolidarityPayment();
        solidarityPayment.setDebitAccount(mDebitAccountSwitch.isChecked());
        solidarityPayment.setMembers(mAdapter.getSolidarityMembers());
        return solidarityPayment;
    }
}