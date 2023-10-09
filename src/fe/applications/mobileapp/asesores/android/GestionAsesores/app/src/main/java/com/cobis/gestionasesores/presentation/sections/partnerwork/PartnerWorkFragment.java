package com.cobis.gestionasesores.presentation.sections.partnerwork;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputLayout;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.PartnerWork;
import com.cobis.gestionasesores.presentation.address.AddressActivity;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.widgets.AddressInputEditText;
import com.cobis.gestionasesores.widgets.phonefield.PhoneInputLayout;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PartnerWorkFragment extends SectionFragment implements PartnerWorkContract.PartnerWorkView {
    private static final int REQUEST_ADDRESS_DATA = 1;

    @BindView(R.id.input_layout_address)
    TextInputLayout mAddressInputLayout;
    @BindView(R.id.input_work_telephone)
    PhoneInputLayout mWorkTelephoneEditText;
    @BindView(R.id.input_cellphone)
    PhoneInputLayout mCellphoneEditText;
    @BindView(R.id.input_address)
    AddressInputEditText mAddressEditText;
    private PartnerWorkContract.PartnerWorkPresenter mPresenter;

    public static PartnerWorkFragment newInstance() {
        Bundle args = new Bundle();
        PartnerWorkFragment fragment = new PartnerWorkFragment();
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
        return inflater.inflate(R.layout.fragment_partner_work, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

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
                mPresenter.onClickFinish(getPartnerWork());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_ADDRESS_DATA) {
            mPresenter.onAddressDataResult((AddressData) data.getSerializableExtra(AddressActivity.EXTRA_ADDRESS));
        }
    }

    @Override
    public void setPresenter(PartnerWorkContract.PartnerWorkPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setPartnerWork(@NonNull PartnerWork partnerWork) {
        mWorkTelephoneEditText.setPhoneNumber(partnerWork.getTelephoneWork());
        mCellphoneEditText.setPhoneNumber(partnerWork.getCellphone());
    }

    @Override
    public void showWorkTelephoneError() {
        mWorkTelephoneEditText.setError(getString(R.string.val_invalid_telephone));
    }

    @Override
    public void showCellphoneError() {
        mCellphoneEditText.setError(getString(R.string.val_invalid_telephone));
    }

    @Override
    public void clearErrors() {
        mWorkTelephoneEditText.setError(null);
        mCellphoneEditText.setError(null);
        mAddressInputLayout.setErrorEnabled(false);
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
    public void showAddressError() {
        mAddressInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showSamePhonesError() {
        mWorkTelephoneEditText.setError(getString(R.string.val_same_phones));
        mCellphoneEditText.setError(getString(R.string.val_same_phones));
    }

    @OnClick(R.id.input_address)
    public void onClickAddressData(View view) {
        mPresenter.onClickAddressData();
    }

    public PartnerWork getPartnerWork() {
        return new PartnerWork.Builder().addTelephoneWork(mWorkTelephoneEditText.getPhoneNumber().trim()).addCellphone(mCellphoneEditText.getPhoneNumber().trim()).build();
    }
}
