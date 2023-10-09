package com.cobis.gestionasesores.presentation.person;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.customers.CustomersPresenter;
import com.cobis.gestionasesores.presentation.customers.SelectCustomerActivity;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.sections.complementarydata.ComplementaryDataActivity;
import com.cobis.gestionasesores.presentation.sections.customeraddress.CustomerAddressActivity;
import com.cobis.gestionasesores.presentation.sections.customerbusiness.CustomerBusinessActivity;
import com.cobis.gestionasesores.presentation.sections.customerdata.CustomerDataActivity;
import com.cobis.gestionasesores.presentation.sections.customerpayment.CustomerPaymentActivity;
import com.cobis.gestionasesores.presentation.sections.documents.DocumentListActivity;
import com.cobis.gestionasesores.presentation.sections.partnerdata.PartnerDataActivity;
import com.cobis.gestionasesores.presentation.sections.partnerwork.PartnerWorkActivity;
import com.cobis.gestionasesores.presentation.sections.prospectdata.ProspectDataActivity;
import com.cobis.gestionasesores.presentation.sections.references.ReferenceListActivity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Admin person´s form
 * Created by mnaunay on 05/06/2017.
 */
public class PersonFragment extends ErrorBaseFragment implements PersonSectionAdapter.OnItemClickListener, PersonContract.View {

    private static final int REQUEST_CUSTOMER_DATA = 1;
    private static final int REQUEST_PARTNER_DATA = 2;
    private static final int REQUEST_CUSTOMER_PAYMENT = 3;
    private static final int REQUEST_CUSTOMER_ADDRESS = 4;
    private static final int REQUEST_PARTNER_WORK = 5;
    private static final int REQUEST_CUSTOMER_BUSINESS = 6;
    private static final int REQUEST_PROSPECT_DATA = 7;
    private static final int REQUEST_REFERENCES_DATA = 20;
    private static final int REQUEST_DOCUMENTS = 30;

    private static final int REQUEST_PARTNER = 99;

    @BindView(R.id.text_person_name)
    TextView mPersonNameTextView;
    @BindView(R.id.text_validation_status)
    TextView mValidationTextView;

    private PersonContract.Presenter mPresenter;
    private PersonSectionAdapter mSectionAdapter;

    private boolean mShowDeleteOption = false;
    private boolean mShowConvertOption = false;
    private boolean mShowValidateOption = false;

    private ProgressDialog mProgressDialog;

    public static PersonFragment newInstance() {
        Bundle args = new Bundle();
        PersonFragment fragment = new PersonFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mSectionAdapter = new PersonSectionAdapter(new ArrayList<Section>(0), this);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_person, container, false);
        RecyclerView sectionList = view.findViewById(R.id.recycler_sections);
        sectionList.setLayoutManager(new LinearLayoutManager(getContext()));
        sectionList.setAdapter(mSectionAdapter);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mValidationTextView.setVisibility(View.GONE);
        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_person, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_delete:
                mPresenter.onClickDelete();
                return true;
            case R.id.menu_validate_prospect:
                mPresenter.onClickValidateProspect();
                return true;
            case R.id.menu_convert_to_customer:
                onClickConvertToCustomer();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    private void onClickConvertToCustomer() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.person_dialog_convert_warning_msg).setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                mPresenter.convertToCustomer();
            }
        }).setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
            }
        }).show();
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        menu.findItem(R.id.menu_delete).setVisible(mShowDeleteOption);
        menu.findItem(R.id.menu_convert_to_customer).setVisible(mShowConvertOption);
        menu.findItem(R.id.menu_validate_prospect).setVisible(mShowValidateOption);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && REQUEST_PARTNER == requestCode) {
            mPresenter.onSelectPartner((Person) data.getSerializableExtra(SelectCustomerActivity.EXTRA_CUSTOMER));
        } else if (resultCode == Activity.RESULT_OK && data != null) {
            mPresenter.onSectionChangedResult(data.getIntExtra(PersonActivity.EXTRA_PERSON_ID, -1));
        } else {
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

    @Override
    public void setPresenter(PersonContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showSections(List<Section> sections) {
        mSectionAdapter.replaceAll(sections);
    }

    @Override
    public void startCustomerBusinessSection(int personId, Section section, AddressData optionalAddress) {
        startActivityForResult(CustomerBusinessActivity.newIntent(getContext(), personId, section, optionalAddress), REQUEST_CUSTOMER_BUSINESS);
    }

    @Override
    public void startDocumentsSection(int personId, Section section) {
        startActivityForResult(DocumentListActivity.newIntent(getContext(), section, personId), REQUEST_DOCUMENTS);
    }

    @Override
    public void startComplementaryDataSection(int personId, Section section) {
        startActivityForResult(ComplementaryDataActivity.newIntent(getContext(), personId, section), REQUEST_DOCUMENTS);
    }

    @Override
    public void showMessageFail() {
        Toast.makeText(getContext(), getString(R.string.operation_fail_message), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showSaveError(String message) {
        new AlertDialog.Builder(getContext()).setMessage(message).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showMessageDeleteSuccess(@PersonType int type) {
        Toast.makeText(getContext(), getString(R.string.person_delete_success_message, getString(getPersonTypeResource(type))), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void toggleDeleteOption(boolean isVisible) {
        mShowDeleteOption = isVisible;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showConvertOption(boolean showConvertOption) {
        mShowConvertOption = showConvertOption;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showValidateOption(boolean shouldShow) {
        mShowValidateOption = shouldShow;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void closeAndExit() {
        getActivity().finish();
    }

    @Override
    public AddressData getCustomerAddressData() {
        return mSectionAdapter.getCustomerAddressData();
    }

    @Override
    public void showTitle(@PersonType int type) {
        ActionBar actionBar = ((BaseActivity) getActivity()).getSupportActionBar();
        actionBar.setTitle(getPersonTypeResource(type));
    }

    @Override
    public void showAlertDelete(@PersonType int type) {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.person_dialog_delete, getString(getPersonTypeResource(type)).toLowerCase())).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
                mPresenter.doDelete();
            }
        }).setNegativeButton(R.string.action_cancel, null).show();
    }

    @Override
    public void startProspectData(Person prospect) {
        startActivityForResult(ProspectDataActivity.newIntent(getContext(), prospect), REQUEST_PROSPECT_DATA);
    }

    @Override
    public void showLoadingProgress() {
        showProgressDialog(R.string.progress_load_msg);
    }

    @Override
    public void showSaveProgress() {
        showProgressDialog(R.string.progress_save_msg);
    }

    @Override
    public void dismissProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showValidateProgress() {
        showProgressDialog(R.string.person_progress_validating);
    }

    @Override
    public void showConvertProgress() {
        showProgressDialog(R.string.person_progress_converting);
    }

    @Override
    public void showNotNetworkConnection() {
        new AlertDialog.Builder(getContext()).setTitle(R.string.message_network_title).setMessage(R.string.message_network_content).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.error_message_network).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showValidateError(String error) {
        if (StringUtils.isEmpty(error)) {
            error = getString(R.string.person_error_validate);
        }
        new AlertDialog.Builder(getContext()).setMessage(error).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showNoValidateError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.person_no_validate).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showValidationLabel(boolean isValidated) {
        mValidationTextView.setVisibility(View.VISIBLE);
        if (isValidated) {
            mValidationTextView.setText(R.string.prospect_validated);
            mValidationTextView.setTextColor(getResources().getColor(R.color.colorGreen));
        } else {
            mValidationTextView.setText(R.string.prospect_no_validated);
            mValidationTextView.setTextColor(getResources().getColor(R.color.colorAccent));
        }
    }

    @Override
    public void hideValidationLabel() {
        mValidationTextView.setVisibility(View.GONE);
    }

    @Override
    public void showPartnerDialog() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.person_new_partner_data_message)
                .setPositiveButton(R.string.person_select_partner, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        mPresenter.onClickSelectPartner();
                    }
                })
                .setNegativeButton(R.string.person_create_partner, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        mPresenter.onClickCreateNewPartner();
                    }
                })
                .show();
    }

    @Override
    public void goToSelectPartner(int localId) {
        startActivityForResult(SelectCustomerActivity.newIntent(getContext(), new int[]{}, new int[]{localId}, CustomersPresenter.Mode.PARTNER), REQUEST_PARTNER);
    }

    @Override
    public void showErrorConvertToCustomer() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.person_error_convert_message).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showPersonName(String name) {
        if (StringUtils.isNotEmpty(name)) {
            mPersonNameTextView.setVisibility(View.VISIBLE);
            mPersonNameTextView.setText(name);
        } else {
            mPersonNameTextView.setVisibility(View.GONE);
        }
    }

    @Override
    public void showValidateSuccess(String message) {
        if (message == null) {
            new AlertDialog.Builder(getContext())
                    .setMessage(R.string.person_dialog_validate_warning_msg)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                            dialog.dismiss();
                        }
                    })
                    .show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, null)
                    .show();
        }
    }

    @Override
    public void startCustomerDataSection(Person customer) {
        startActivityForResult(CustomerDataActivity.newIntent(getContext(), customer), REQUEST_CUSTOMER_DATA);
    }

    @Override
    public void startPartnerDataSection(int personId, Section section) {
        startActivityForResult(PartnerDataActivity.newIntent(getContext(), personId, section), REQUEST_PARTNER_DATA);
    }

    @Override
    public void startReferencesDataActivity(int personId, Section section) {
        startActivityForResult(ReferenceListActivity.newIntent(getContext(), personId, section), REQUEST_REFERENCES_DATA);
    }

    @Override
    public void startCustomerPaymentSection(int personId, Section section, double otherIncome) {
        startActivityForResult(CustomerPaymentActivity.newIntent(getContext(), personId, section, otherIncome), REQUEST_CUSTOMER_PAYMENT);
    }

    @Override
    public void startCustomerAddressSection(int personId, Section section) {
        startActivityForResult(CustomerAddressActivity.newIntent(getContext(), personId, section), REQUEST_CUSTOMER_ADDRESS);
    }

    @Override
    public void startPartnerWorkSection(int personId, Section section) {
        startActivityForResult(PartnerWorkActivity.newIntent(getContext(), personId, section), REQUEST_PARTNER_WORK);
    }

    @Override
    public void onItemClick(Section item) {
        mPresenter.onSectionSelected(item);
    }

    private int getPersonTypeResource(@PersonType int type) {
        switch (type) {
            case PersonType.CUSTOMER:
                return R.string.customer_title;
            case PersonType.PROSPECT:
                return R.string.prospect_title;
            default:
                throw new RuntimeException("Person type is not supported!!!");
        }
    }

    private void showProgressDialog(int message) {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(message));
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setCancelable(false);
            mProgressDialog.show();
        }
    }
}
