package com.cobis.gestionasesores.presentation.sections.complementarydata;

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

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.ComplementaryData;
import com.cobis.gestionasesores.presentation.sections.SectionFragment;
import com.cobis.gestionasesores.widgets.BooleanQuestionView;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.phonefield.PhoneInputLayout;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ComplementaryDataFragment extends SectionFragment implements ComplementaryDataContract.ComplementaryDataView {
    @BindView(R.id.input_layout_ife_number)
    TextInputLayout mIfeNumberInputLayout;
    @BindView(R.id.input_layout_passport_number)
    TextInputLayout mPassportNumberInputLayout;
    @BindView(R.id.input_layout_esign_sn)
    TextInputLayout mESignSNInputLayout;
    @BindView(R.id.input_layout_msg_delegate_name)
    TextInputLayout mMsgDelegateNameInputLayout;

    @BindView(R.id.input_ife_number)
    TextInputEditText mIfeNumberEditText;
    @BindView(R.id.input_passport_number)
    TextInputEditText mPassportNumberEditText;
    @BindView(R.id.input_esign_sn)
    TextInputEditText mESignSNEditText;
    @BindView(R.id.input_msg_phone_number)
    PhoneInputLayout mMsgPhoneNumberEditText;
    @BindView(R.id.input_msg_delegate_name)
    TextInputEditText mMsgDelegateNameEditText;
    @BindView(R.id.input_landline)
    TextInputEditText mLandlineEditText;

    @BindView(R.id.boolean_question_has_bureau_antecedents)
    BooleanQuestionView mHasBureauAntecedentsQuestion;

    private ComplementaryDataContract.ComplementaryDataPresenter mPresenter;

    public static ComplementaryDataFragment newInstance() {
        Bundle args = new Bundle();
        ComplementaryDataFragment fragment = new ComplementaryDataFragment();
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
                mPresenter.onClickFinish(buildComplementaryData());
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_complementary_data, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mPresenter.start();
        mIfeNumberEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_ALPHANUMERIC), new InputFilter.AllCaps(), new InputFilter.LengthFilter(13)});
        mPassportNumberEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_ALPHANUMERIC), new InputFilter.AllCaps(), new InputFilter.LengthFilter(8)});
        mESignSNEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_ALPHANUMERIC), new InputFilter.AllCaps(), new InputFilter.LengthFilter(20)});
        mMsgDelegateNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_NAMES), new InputFilter.AllCaps(), new InputFilter.LengthFilter(60)});
    }

    @Override
    public void setPresenter(ComplementaryDataContract.ComplementaryDataPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setComplementaryData(ComplementaryData complementaryData) {
        mIfeNumberEditText.setText(complementaryData.getIfeNumber());
        mPassportNumberEditText.setText(complementaryData.getPassportNumber());
        mESignSNEditText.setText(complementaryData.geteSignSN());
        mMsgPhoneNumberEditText.setPhoneNumber(complementaryData.getMsgPhoneNumber());
        mMsgDelegateNameEditText.setText(complementaryData.getMsgDelegateName());
        mHasBureauAntecedentsQuestion.checkOption(complementaryData.hasAntecedentsBureau());
        mLandlineEditText.setText(complementaryData.getConventionalPhoneNumber());
    }

    @Override
    public void clearErrors() {
        mHasBureauAntecedentsQuestion.clearError();
        mMsgPhoneNumberEditText.setError(null);
    }

    @Override
    public void showHasBureauAntecedentsError() {
        mHasBureauAntecedentsQuestion.showError(R.string.val_field_required);
    }

    @Override
    public void showTelephoneError() {
        mMsgPhoneNumberEditText.setError(getString(R.string.val_invalid_telephone));
    }

    public ComplementaryData buildComplementaryData() {
        String phone = StringUtils.nullToString(mMsgPhoneNumberEditText.getPhoneNumber().trim());
        return new ComplementaryData.Builder().addIfeNumber(mIfeNumberEditText.getText().toString()).addPassportNumber(mPassportNumberEditText.getText().toString().trim()).addeSignSN(mESignSNEditText.getText().toString().trim()).addMsgPhoneNumber(phone).addMsgDelegateName(mMsgDelegateNameEditText.getText().toString().trim()).addHasAntecedentsBureau(mHasBureauAntecedentsQuestion.getResponse()).build();
    }
}
