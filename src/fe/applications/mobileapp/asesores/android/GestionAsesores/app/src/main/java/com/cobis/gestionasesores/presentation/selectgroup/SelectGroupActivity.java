package com.cobis.gestionasesores.presentation.selectgroup;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.GroupRepository;
import com.cobis.gestionasesores.domain.usecases.GetGroupsForCredit;
import com.cobis.gestionasesores.domain.usecases.GetGroupsUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.groups.GroupsFragment;
import com.cobis.gestionasesores.presentation.groups.GroupsPresenter;

/**
 * Created by bqtdesa02 on 6/22/2017.
 */

public class SelectGroupActivity extends BaseActivity {

    public static final String EXTRA_GROUP = "com.cobis.gestionasesores.extras.extra_group";

    public static Intent newIntent(Context context){
        Intent intent = new Intent(context,SelectGroupActivity.class);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select_group);

        GroupsFragment fragment =
                (GroupsFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if(fragment == null){
            fragment = GroupsFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,fragment).commit();
        }

        new GroupsPresenter(fragment,
                GroupsPresenter.Mode.MODE_SELECT,
                new GetGroupsUseCase(GroupRepository.getInstance()),
                new GetGroupsForCredit(GroupRepository.getInstance()));
    }
}
