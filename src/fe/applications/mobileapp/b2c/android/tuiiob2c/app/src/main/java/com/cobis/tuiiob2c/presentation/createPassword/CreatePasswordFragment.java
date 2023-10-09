package com.cobis.tuiiob2c.presentation.createPassword;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

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
public class CreatePasswordFragment extends Fragment implements CreatePasswordMVP.CreatePasswordView {

    @Inject
    public CreatePasswordMVP.CreatePasswordPresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.send_button)
    Button mSendButton;
    @BindView(R.id.password_edt)
    EditText mPasswordEditText;
    @BindView(R.id.repet_password_edt)
    EditText mRepetPasswordEditText;

    public static CreatePasswordFragment newInstance() {
        Bundle args = new Bundle();
        CreatePasswordFragment fragment = new CreatePasswordFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectCreatePassword(this);

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
                presenter.onClickValidateCreatePassword(mPasswordEditText.getText().toString().trim(), mRepetPasswordEditText.getText().toString().trim());
                break;
            default:
                break;
        }
    }

   @Override
    public void showCreatePasswordSuccess() {
        Intent intent = new Intent(getContext(), MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
    }

    @Override
    public void showCreatePasswordError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
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
