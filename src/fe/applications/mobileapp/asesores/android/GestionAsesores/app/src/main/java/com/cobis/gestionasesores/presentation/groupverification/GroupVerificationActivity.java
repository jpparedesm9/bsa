package com.cobis.gestionasesores.presentation.groupverification;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.domain.usecases.GetGroupVerificationUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class GroupVerificationActivity extends BaseActivity {

    private static final String EXTRA_VERIFICATION_ID = "com.cobis.gestionasesores.extras.extra_verification_id";
    private static final String EXTRA_VERIFICATION_TYPE = "com.cobis.gestionasesores.extras.extra_verification_type";

    public static Intent newIntent(Context context, int verificationId, String verificationType) {
        Intent intent = new Intent(context, GroupVerificationActivity.class);
        intent.putExtra(EXTRA_VERIFICATION_ID, verificationId);
        intent.putExtra(EXTRA_VERIFICATION_TYPE, verificationType);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_group_verification);

        GroupVerificationFragment fragment = (GroupVerificationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (fragment == null) {
            fragment = GroupVerificationFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }

        new GroupVerificationPresenter(fragment, getIntent().getIntExtra(EXTRA_VERIFICATION_ID, -1), new GetGroupVerificationUseCase(), getIntent().getStringExtra(EXTRA_VERIFICATION_TYPE));
    }
}
