package com.cobis.tuiiob2c.presentation.creditSolicitation;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;

import static com.cobis.tuiiob2c.presentation.mainActivity.home.HomeFragment.LOAN_INFO;

public class CreditSolicitationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_credit_solicitation);
        LoanInfoResponse loanInfo = (LoanInfoResponse) getIntent().getSerializableExtra(LOAN_INFO);
        CreditSolicitationFragment creditSolicitationFragment = (CreditSolicitationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (creditSolicitationFragment == null) {
            creditSolicitationFragment = CreditSolicitationFragment.newInstance(loanInfo);
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, creditSolicitationFragment).commit();
        }
    }
}
