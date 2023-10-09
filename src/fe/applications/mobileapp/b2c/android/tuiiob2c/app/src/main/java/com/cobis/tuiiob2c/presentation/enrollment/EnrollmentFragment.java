package com.cobis.tuiiob2c.presentation.enrollment;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.text.method.LinkMovementMethod;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.presentation.phoneValidation.PhoneValidationActivity;
import com.cobis.tuiiob2c.presentation.splash.SplashActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.widgets.PinView;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class EnrollmentFragment extends Fragment implements PinView.PinListener, EnrollmentMVP.EnrollmentView {

    @Inject
    public EnrollmentMVP.EnrollmentPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.pin_view)
    PinView pinView;
    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;
    @BindView(R.id.checkbox)
    CheckBox mCheckbox;
    @BindView(R.id.terms_conditions)
    TextView mTextView;
    @BindView(R.id.spinner_environment)
    Spinner mEnvironmentSpinner;
    @BindView(R.id.text_version_info)
    TextView mVersionInfoText;

    private ArrayAdapter<Environment> mAdapter;

    public static EnrollmentFragment newInstance() {
        Bundle args = new Bundle();
        EnrollmentFragment fragment = new EnrollmentFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectEnrollment(this);

        return inflater.inflate(R.layout.fragment_enrollment, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);

        AlertDialog.Builder builder = new AlertDialog.Builder(Objects.requireNonNull(getContext()));
        builder.setMessage(R.string.enrolment_terms_conditions_content)
                .setPositiveButton("Cerrar", (dialog, id) -> dialog.cancel());
        final AlertDialog alert = builder.create();
        mTextView.setOnClickListener(v -> {
            alert.show();
            ((TextView) alert.findViewById(android.R.id.message)).setMovementMethod(LinkMovementMethod.getInstance());
        });
        //mTextView.setOnClickListener(v -> alert.show());
        pinView.setActive(false);
        mCheckbox.setOnCheckedChangeListener((compoundButton, b) -> pinView.setActive(b));

        mAdapter = new ArrayAdapter<>(Objects.requireNonNull(getContext()), android.R.layout.simple_spinner_item, Environment.values());
        mAdapter.setDropDownViewResource(android.R.layout.simple_dropdown_item_1line);
        mEnvironmentSpinner.setAdapter(mAdapter);
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
        presenter.start();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        presenter.unSuscribe();
    }


    @OnClick({R.id.terms_conditions})
    public void click(View view) {
        switch (view.getId()) {
            case R.id.terms_conditions:
                presenter.onClickTermsAndConditions();
                break;
            default:
                break;
        }
    }

    @Override
    public void showErrorValidateFields() {
        Toast.makeText(getContext(), "PIN incorrecto", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showEnrollmentSuccess() {
        Intent intent = new Intent(getContext(), PhoneValidationActivity.class);
        startActivity(intent);
    }

    @Override
    public void showEnrollmentError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
        pinView.clear();
    }

    @Override
    public void showTermsAndConditions() {
        Toast.makeText(getContext(), "Mostrar Términos y Condiciones", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showVersionInfo(String versionName, String versionCode) {
        mVersionInfoText.setText(versionName + " (" + versionCode + ")");
    }

    @Override
    public void setEnvironment(Environment environment) {
        int position = mAdapter.getPosition(environment);
        mEnvironmentSpinner.setSelection(position, false);
        mEnvironmentSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                presenter.onEnvironmentSelected(mAdapter.getItem(position));
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    }

    @Override
    public void showEnvironmentSelector(boolean shouldShow) {
        mEnvironmentSpinner.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void restartAppForEnviroment() {
        startActivity(SplashActivity.newIntent(getContext()));
    }

    @Override
    public void onComplete(String var1) {
        if (mCheckbox.isChecked()) {
            presenter.onClickValidatePinEnrollment(var1);
            pinView.clear();
        }
    }

    @Override
    public void onNumberPressed(String var1) {
        if (!mCheckbox.isChecked()) {
            Toast.makeText(getContext(), "Debe aceptar los Términos y Condiciones", Toast.LENGTH_SHORT).show();
            pinView.clear();
        }


    }

    @Override
    public void onDeleteAll() {

    }

    @Override
    public void onDelete(String var1) {

    }

    @Override
    public void showLoading() {
        mProgressll.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideLoading() {
        mProgressll.setVisibility(View.GONE);
    }
}
