package com.cobis.gestionasesores.presentation.memberverification;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.repositories.TaskRepository;
import com.cobis.gestionasesores.domain.usecases.SaveMemberVerificationUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 8/16/2017.
 */

public class MemberVerificationActivity extends BaseActivity {

    private static final String EXTRA_MEMBER_VERIFICATION = "com.cobis.gestionasesores.extras.extra_member_verification";
    private static final String EXTRA_VERIFICATION_ID = "com.cobis.gestionasesores.extras.extra_verification_id";

    private MemberVerificationContract.Presenter mPresenter;

    public static Intent newIntent(Context context, int verificationId, MemberVerification memberVerification) {
        Intent intent = new Intent(context, MemberVerificationActivity.class);
        intent.putExtra(EXTRA_MEMBER_VERIFICATION, memberVerification);
        intent.putExtra(EXTRA_VERIFICATION_ID, verificationId);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_verification);

        MemberVerificationFragment fragment = (MemberVerificationFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);

        if (fragment == null) {
            fragment = MemberVerificationFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }

        mPresenter = new MemberVerificationPresenter(fragment, getIntent().getIntExtra(EXTRA_VERIFICATION_ID, -1), (MemberVerification) getIntent().getSerializableExtra(EXTRA_MEMBER_VERIFICATION), new SaveMemberVerificationUseCase(TaskRepository.getInstance()));
    }

    @Override
    public void onBackPressed() {
        mPresenter.onTryToExit();
    }
}
