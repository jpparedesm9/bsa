package com.cobis.tuiiob2c.presentation.resetPassword;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.mainActivity.MainActivity;
import com.cobis.tuiiob2c.root.App;

import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class ResetPasswordFragment extends Fragment implements ResetPasswordMVP.ResetPasswordView{


    @Inject
    public ResetPasswordMVP.ResetPasswordPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.send_button)
    Button mSendButton;
    @BindView(R.id.password_edt)
    EditText mPasswordEditText;
    @BindView(R.id.repet_password_edt)
    EditText mRepetPasswordEditText;

    public static ResetPasswordFragment newInstance() {
        Bundle args = new Bundle();
        ResetPasswordFragment fragment = new ResetPasswordFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectResetPassword(this);

        return inflater.inflate(R.layout.fragment_create_password, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        ButterKnife.bind(this, view);
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        presenter.unSuscribe();
    }

    @OnClick({ R.id.send_button })
    public void click(View view) {
        switch (view.getId()) {
            case R.id.send_button:
                mPasswordEditText.setError(null);
                mRepetPasswordEditText.setError(null);
                presenter.onClickValidateResetPassword(mPasswordEditText.getText().toString().trim(), mRepetPasswordEditText.getText().toString().trim());
                break;
            default:
                break;
        }
    }

    @Override
    public void showResetPasswordSuccess() {
        Intent intent = new Intent(getContext(), MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
    }

    @Override
    public void showResetPasswordError(String message) {
        Toast.makeText(getActivity(), message, Toast.LENGTH_SHORT).show();
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
