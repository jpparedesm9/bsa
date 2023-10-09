package com.cobis.gestionasesores.presentation.member.moreinformation;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 9/29/2017.
 */

public class MemberInformationActivity extends BaseActivity {

    private static final String EXTRA_MEMBER = "com.cobis.gestionasesores.extras.extra_member";

    public static Intent newIntent(Context context, Member member){
        Intent intent = new Intent(context, MemberInformationActivity.class);
        intent.putExtra(EXTRA_MEMBER, member);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member_information);

        MemberInformationFragment fragment = (MemberInformationFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if(fragment == null){
            fragment = MemberInformationFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new MemberInformationPresenter(fragment, (Member) getIntent().getSerializableExtra(EXTRA_MEMBER));
    }
}
