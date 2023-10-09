package com.cobis.gestionasesores.presentation.membercredit;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.GetCompleteMemberCreditUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 26/06/2017.
 */

public class MemberCreditActivity extends BaseActivity {

    public static final String EXTRA_MEMBER_CREDIT = "MEMBER_CREDIT";

    public static Intent newIntent(Context context, MemberCreditApp member) {
        Intent intent = new Intent(context, MemberCreditActivity.class);
        intent.putExtra(EXTRA_MEMBER_CREDIT, member);
        return intent;
    }

    public static Intent newIntentResult(MemberCreditApp member) {
        Intent intent = new Intent();
        intent.putExtra(EXTRA_MEMBER_CREDIT, member);
        return intent;
    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_credit);

        MemberCreditAppFragment fragment = (MemberCreditAppFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = MemberCreditAppFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new MemberCreditAppPresenter(fragment,
                (MemberCreditApp) getIntent().getSerializableExtra(EXTRA_MEMBER_CREDIT),
                new GetCompleteMemberCreditUseCase(PersonRepository.getInstance()));
    }
}
