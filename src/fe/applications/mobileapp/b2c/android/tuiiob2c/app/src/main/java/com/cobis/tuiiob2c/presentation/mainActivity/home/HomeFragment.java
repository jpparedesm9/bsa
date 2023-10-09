package com.cobis.tuiiob2c.presentation.mainActivity.home;


import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.models.LoanDetail;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.presentation.creditSolicitation.CreditSolicitationActivity;
import com.cobis.tuiiob2c.root.App;
import com.cobis.tuiiob2c.utils.Constants;

import java.text.DecimalFormat;
import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 */
public class HomeFragment extends Fragment implements HomeMVP.HomeView {

    @Inject
    public HomeMVP.HomePresenter presenter;

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.tv_line_credit)
    TextView mLineCredit;
    @BindView(R.id.customer_name_textview)
    TextView mCustomerName;
    @BindView(R.id.line_credit_textview)
    TextView mCreditLine;
    @BindView(R.id.used_textview)
    TextView mUsed;
    @BindView(R.id.deb_without_interest)
    TextView mDebWOInteres;
    @BindView(R.id.minimun_pay_textview)
    TextView mMinimunPay;
    @BindView(R.id.pay_date_textview)
    TextView mPayDate;
    @BindView(R.id.pay_reference_textview)
    TextView mPayReference;
    @BindView(R.id.last_access)
    TextView mLastAccess;
    @BindView(R.id.linear_layout_content)
    LinearLayout mLinearLayoutContent;
    @BindView(R.id.fab)
    FloatingActionButton mFab;

    private DecimalFormat decimalFormat;

    public static final String LOAN_INFO = "LOAN_INFO";

    public static HomeFragment newInstance() {
        Bundle args = new Bundle();
        HomeFragment fragment = new HomeFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectHome(this);

        decimalFormat = new DecimalFormat(Constants.DECIMAL_FORMAT);

        return inflater.inflate(R.layout.fragment_home, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mCustomerName.setText(SessionManager.getInstance().getValuesEnrollment().getNombres());
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

    @OnClick({ R.id.fab })
    public void click(View view) {
        switch (view.getId()) {
            case R.id.fab:
                presenter.setClickCreateCreditSolicitation();
                break;
            default:
                break;
        }
    }

    @Override
    public void showGetLoanInfoSuccess(LoanInfoResponse loanInfoResponse) {
        mLineCredit.setText("$ " + decimalFormat.format(loanInfoResponse.getData().getLineaCredito()) + " " + Constants.MEXICAN_PESOS);
        mCreditLine.setText("$ " + decimalFormat.format(loanInfoResponse.getData().getLineaCredito()) + " " + Constants.MEXICAN_PESOS);
        mUsed.setText("$ " + decimalFormat.format(loanInfoResponse.getData().getUtilizado()) + " " + Constants.MEXICAN_PESOS);
        mDebWOInteres.setText("$ " + decimalFormat.format(loanInfoResponse.getData().getPagoSinIntereses()) + " " + Constants.MEXICAN_PESOS);
        mMinimunPay.setText("$ " + decimalFormat.format(loanInfoResponse.getData().getPagoMinimo()) + " " + Constants.MEXICAN_PESOS);
        mPayDate.setText(loanInfoResponse.getData().getFechaPago());
        mPayReference.setText(loanInfoResponse.getData().getReferenciaDePago());
        mLastAccess.setText(loanInfoResponse.getData().getUltimoAcceso());

        mLinearLayoutContent.removeAllViews();
        if (loanInfoResponse.getData().getDetails().size() > 0){

            TextView solicitudesTv = new TextView(getContext());
            solicitudesTv.setText("Solicitudes");
            LinearLayout.LayoutParams solicitudesParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
            solicitudesParams.setMargins(64, 32, 0, 16);
            solicitudesTv.setTypeface(null, Typeface.BOLD);
            mLinearLayoutContent.addView(solicitudesTv, solicitudesParams);

            LinearLayout divider = new LinearLayout(getContext());
            LinearLayout.LayoutParams dividerParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 2);
            dividerParams.setMargins(0, 32, 0, 32);
            divider.setBackgroundColor(getResources().getColor(R.color.divider));
            mLinearLayoutContent.addView(divider, dividerParams);

            for (LoanDetail detail : loanInfoResponse.getData().getDetails()){
                LinearLayout loanLayout = new LinearLayout(getContext());
                loanLayout.setOrientation(LinearLayout.HORIZONTAL);
                LinearLayout.LayoutParams llparams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                llparams.setMargins(64, 16, 64, 16);
                mLinearLayoutContent.addView(loanLayout, llparams);

                TextView detailTv = new TextView(getContext());
                LinearLayout.LayoutParams detailParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                detailTv.setText(detail.getDescription());
                loanLayout.addView(detailTv, detailParams);

                TextView valueTv = new TextView(getContext());
                LinearLayout.LayoutParams valueParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                valueParams.weight = 1;
                String value = decimalFormat.format(detail.getAmount());
                valueTv.setText("$ " + value + " " + Constants.MEXICAN_PESOS);
                valueTv.setTextAlignment(View.TEXT_ALIGNMENT_TEXT_END);
                loanLayout.addView(valueTv, valueParams);

                TextView dateTv = new TextView(getContext());
                LinearLayout.LayoutParams dateParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                dateParams.setMargins(64, 0, 64, 0);
                dateTv.setTextColor(getResources().getColor(R.color.secondaryText));
                dateTv.setText(detail.getDate());
                mLinearLayoutContent.addView(dateTv, dateParams);

                LinearLayout loanDivider = new LinearLayout(getContext());
                loanDivider.setBackgroundColor(getResources().getColor(R.color.divider));
                mLinearLayoutContent.addView(loanDivider, dividerParams);

            }
        }
    }

    @Override
    public void showGetLoanInfoError(String message) {
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

    @Override
    public void openActivityCreditSolicitation(LoanInfoResponse loanInfoResponse) {
        Intent intent = new Intent(getContext(), CreditSolicitationActivity.class);
        intent.putExtra(LOAN_INFO, loanInfoResponse);
        startActivity(intent);
    }
}
