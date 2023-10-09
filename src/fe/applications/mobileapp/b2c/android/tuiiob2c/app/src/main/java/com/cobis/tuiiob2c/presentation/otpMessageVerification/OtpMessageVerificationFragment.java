package com.cobis.tuiiob2c.presentation.otpMessageVerification;


import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.enums.ResponseMessageType;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.widgets.PinView;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class OtpMessageVerificationFragment extends Fragment implements PinView.PinListener, OtpMessageVerificationMVP.OtpMessageVerificationView {

    @Inject
    public OtpMessageVerificationMVP.OtpMessageVerificationPresenter presenter;


    private String answer;
    private String notificationId;
    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.pin_view)
    PinView pinView;
    @BindView(R.id.layout_digits)
    LinearLayout mDigitsLayout;
//    @BindView(R.id.resend_pass)
//    Button mResendPass;

    public static OtpMessageVerificationFragment newInstance() {
        Bundle args = new Bundle();
        OtpMessageVerificationFragment fragment = new OtpMessageVerificationFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectOtpMessageVerification(this);

        return inflater.inflate(R.layout.fragment_credit_confirmation, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        ButterKnife.bind(this, view);

        pinView.setListener(this);
        pinView.setDigitView(mDigitsLayout);

//        mResendPass.setOnClickListener(view1 -> Objects.requireNonNull(getActivity()).onBackPressed());
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
    }

    @Override
    public void showMessageResponseSuccess() {
        Toast.makeText(getContext(), "Respuesta enviada", Toast.LENGTH_LONG).show();
        getActivity().finish();
    }

    @Override
    public void showMessageResponseError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showLoading() {

    }

    @Override
    public void hideLoading() {

    }

    @Override
    public void onComplete(String var1) {
        presenter.onSendResponseMessage(notificationId, answer, var1);
        pinView.clear();
    }

    @Override
    public void onNumberPressed(String var1) {

    }

    @Override
    public void onDeleteAll() {

    }

    @Override
    public void onDelete(String var1) {

    }

    public void setanswer(String answer) {
        this.answer = answer;
    }

    public void setNotificationId(String notificationId) {
        this.notificationId = notificationId;
    }
}
