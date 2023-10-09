package com.cobis.gestionasesores.presentation.groupcredit;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;
import com.cobis.gestionasesores.domain.usecases.GetGroupCreditApp;
import com.cobis.gestionasesores.domain.usecases.SaveGroupCreditApp;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class GroupCreditActivity extends BaseActivity {
    private static final String EXTRA_GROUP_CREDIT_APP = "com.cobis.gestionasesores.extras.extra_group_credit_app";

    private GroupCreditContract.GroupCreditPresenter mPresenter;

    public static Intent newIntent(Context context, GroupCreditApp groupCreditApp) {
        Intent intent = new Intent(context, GroupCreditActivity.class);
        intent.putExtra(EXTRA_GROUP_CREDIT_APP, groupCreditApp);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_group_credit);

        GroupCreditFragment fragment = (GroupCreditFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = GroupCreditFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        mPresenter = new GroupCreditPresenter(fragment, (GroupCreditApp) getIntent().getSerializableExtra(EXTRA_GROUP_CREDIT_APP),
                new GetGroupCreditApp(CreditAppRepository.getInstance()),
                new SaveGroupCreditApp(CreditAppRepository.getInstance()));
    }

    @Override
    public void onBackPressed() {
        if (mPresenter != null) {
            mPresenter.onTryToExit();
        }
    }
}
