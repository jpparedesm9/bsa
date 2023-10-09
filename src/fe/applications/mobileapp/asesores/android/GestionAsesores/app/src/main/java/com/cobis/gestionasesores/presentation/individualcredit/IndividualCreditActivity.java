package com.cobis.gestionasesores.presentation.individualcredit;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.domain.usecases.SaveIndividualUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 05/07/2017.
 */

public class IndividualCreditActivity extends BaseActivity {
    private static final String EXTRA_INDIVIDUAL_CREDIT = "CREDIT";
    private IndividualCreditContract.Presenter mPresenter;
    public static Intent newIntent(Context context, IndividualCreditApp creditApp) {
        Intent intent = new Intent(context, IndividualCreditActivity.class);
        intent.putExtra(EXTRA_INDIVIDUAL_CREDIT,creditApp);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_individual_credit);

        IndividualCreditFragment fragment = (IndividualCreditFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if(fragment == null){
            fragment = IndividualCreditFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,fragment).commit();
        }
        mPresenter = new IndividualCreditPresenter(fragment,
                (IndividualCreditApp) getIntent().getSerializableExtra(EXTRA_INDIVIDUAL_CREDIT),
                new SaveIndividualUseCase());

    }

    @Override
    public void onBackPressed() {
        if (mPresenter != null) {
            mPresenter.onTryToExit();
        }
    }
}
