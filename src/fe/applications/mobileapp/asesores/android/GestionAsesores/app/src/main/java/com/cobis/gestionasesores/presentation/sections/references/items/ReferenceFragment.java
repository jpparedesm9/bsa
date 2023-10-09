package com.cobis.gestionasesores.presentation.sections.references.items;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AlertDialog;
import android.text.InputFilter;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Spinner;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.phonefield.Countries;
import com.cobis.gestionasesores.widgets.phonefield.PhoneInputLayout;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ReferenceFragment extends SectionFragment implements ReferenceContract.View {
    @BindView(R.id.input_layout_name)
    TextInputLayout mNameInputLayout;
    @BindView(R.id.input_layout_last_name)
    TextInputLayout mLastNameInputLayout;
    @BindView(R.id.input_layout_email)
    TextInputLayout mEmailInputLayout;

    @BindView(R.id.input_name)
    TextInputEditText mNameEditText;
    @BindView(R.id.input_last_name)
    TextInputEditText mLastNameEditText;
    @BindView(R.id.input_phone)
    PhoneInputLayout mPhoneEditText;
    @BindView(R.id.input_email)
    TextInputEditText mEmailEditText;
    @BindView(R.id.spinner_time_to_meet)
    Spinner mTimeToMeetSpinner;

    private CatalogItemAdapter mTimeToMeetAdapter;
    private ReferenceContract.Presenter mPresenter;

    public static ReferenceFragment newInstance() {
        Bundle args = new Bundle();
        ReferenceFragment fragment = new ReferenceFragment();
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
        View view = inflater.inflate(R.layout.fragment_reference, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mTimeToMeetAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.reference_time_meet);
        mTimeToMeetSpinner.setAdapter(mTimeToMeetAdapter);

        mNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_NAMES), new InputFilter.AllCaps()});
        mLastNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_NAMES), new InputFilter.AllCaps()});
        mPhoneEditText.setDefaultCountry(Countries.COUNTRIES.get(0).getCode());
    }

    @Override
    public void onResume() {
        super.onResume();
        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        if (mPresenter.isDeleteEnabled()) {
            inflater.inflate(R.menu.form_edit_mode, menu);
        }
        inflater.inflate(R.menu.menu_section, menu);
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_section:
                mPresenter.saveReference(buildReference());
                return true;
            case R.id.menu_delete:
                new AlertDialog.Builder(getContext()).setMessage(R.string.reference_dialog_delete).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                        mPresenter.deleteReference();
                    }
                }).setNegativeButton(R.string.action_cancel, null).show();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(ReferenceContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setReference(Reference reference) {
        mNameEditText.setText(reference.getName());
        mLastNameEditText.setText(reference.getLastName());
        mNameEditText.setSelection(mNameEditText.getText().length());

        mPhoneEditText.setPhoneNumber(reference.getPhone());
        mEmailEditText.setText(StringUtils.nullToString(reference.getEmail()));
        mTimeToMeetSpinner.setSelection(mTimeToMeetAdapter.getItemPositionByCode(reference.getTimeToMeet()));
    }

    @Override
    public void returnToList(boolean isSuccess) {
        Intent intent = new Intent();
        getActivity().setResult(isSuccess ? Activity.RESULT_OK : Activity.RESULT_CANCELED, intent);
        getActivity().finish();
    }

    @Override
    public void showReferenceSave(String message) {
        if(StringUtils.isEmpty(message)) {
            Toast.makeText(getContext(), R.string.reference_msg_saved, Toast.LENGTH_LONG).show();
        }else{
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            mPresenter.acceptWarning();
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showReferenceDeleted() {
        Toast.makeText(getContext(), R.string.reference_msg_deleted, Toast.LENGTH_LONG).show();
    }

    @Override
    public void clearErrors() {
        mNameInputLayout.setErrorEnabled(false);
        mLastNameInputLayout.setErrorEnabled(false);
        mPhoneEditText.setError(null);
        mEmailInputLayout.setErrorEnabled(false);
        mTimeToMeetAdapter.clearError();
    }

    @Override
    public void showNameError() {
        mNameInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showPhoneError() {
        mPhoneEditText.setError(getString(R.string.val_invalid_telephone));
    }

    @Override
    public void showEmailError() {
        mEmailInputLayout.setError(getString(R.string.val_invalid_email));
    }

    @Override
    public void showTimeToMeetError() {
        mTimeToMeetAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTimeToMeeting(List<CatalogItem> items) {
        mTimeToMeetAdapter.setCatalogItems(items);
    }

    @Override
    public void showReferenceExistError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.reference_error_duplicate).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showLastNameError() {
        mLastNameInputLayout.setError(getString(R.string.val_field_required));
    }

    private Reference buildReference() {
        Reference reference = new Reference();
        reference.setName(mNameEditText.getText().toString().trim());
        reference.setLastName(mLastNameEditText.getText().toString().trim());
        reference.setPhone(mPhoneEditText.getPhoneNumber());
        reference.setEmail(mEmailEditText.getText().toString());
        reference.setTimeToMeet(mTimeToMeetAdapter.getItemCode(mTimeToMeetSpinner.getSelectedItemPosition()));
        return reference;
    }
}