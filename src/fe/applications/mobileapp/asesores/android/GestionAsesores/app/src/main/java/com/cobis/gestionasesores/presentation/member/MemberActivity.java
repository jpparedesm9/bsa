package com.cobis.gestionasesores.presentation.member;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.repositories.GroupRepository;
import com.cobis.gestionasesores.domain.usecases.DeleteMemberUseCase;
import com.cobis.gestionasesores.domain.usecases.GetMemberUseCase;
import com.cobis.gestionasesores.domain.usecases.RemoveRelationshipUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveMemberUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

import java.io.Serializable;
import java.util.List;

/**
 * Created by bqtdesa02 on 6/16/2017.
 */

public class MemberActivity extends BaseActivity {
    public static final String EXTRA_MEMBERS = "com.cobis.gestionasesores.extras.MEMBERS";
    public static final String EXTRA_MEMBER = "com.cobis.gestionasesores.extras.MEMBER";
    public static final String EXTRA_GROUP_ID = "com.cobis.gestionasesores.extras.GROUP_ID";
    public static final String EXTRA_RESULT = "com.cobis.gestionasesores.extras.RESULT";

    private MemberContract.MemberPresenter mPresenter;

    public static Intent newIntent(Context context,int groupÍd, Member member, List<Member> currentMembers) {
        Intent intent = new Intent(context, MemberActivity.class);
        intent.putExtra(EXTRA_MEMBER, member);
        intent.putExtra(EXTRA_MEMBERS, (Serializable) currentMembers);
        intent.putExtra(EXTRA_GROUP_ID, groupÍd);
        return intent;
    }

    public static Intent newIntentResult(int membersCount){
        Intent intent = new Intent();
        intent.putExtra(EXTRA_RESULT,membersCount);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_member);

        MemberFragment fragment = (MemberFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = MemberFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        mPresenter = new MemberPresenter(fragment,
                getIntent().getIntExtra(EXTRA_GROUP_ID,-1),
                (Member) getIntent().getSerializableExtra(EXTRA_MEMBER),
                (List<Member>) getIntent().getSerializableExtra(EXTRA_MEMBERS),
                new SaveMemberUseCase(),
                new RemoveRelationshipUseCase(),
                new DeleteMemberUseCase(),
                new GetMemberUseCase(GroupRepository.getInstance()));
    }

    @Override
    public void onBackPressed() {
        mPresenter.onTryToExit();
    }
}