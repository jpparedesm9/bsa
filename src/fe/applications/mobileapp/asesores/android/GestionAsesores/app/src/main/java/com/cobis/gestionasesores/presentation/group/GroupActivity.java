package com.cobis.gestionasesores.presentation.group;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.GroupRepository;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.DeleteGroupUseCase;
import com.cobis.gestionasesores.domain.usecases.GetCustomerAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetGroupUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveGroupUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class GroupActivity extends BaseActivity {
    private static final String EXTRA_GROUP_ID = "extra_group_id";


    public static Intent newIntent(Context context, int groupId) {
        Intent intent = new Intent(context, GroupActivity.class);
        intent.putExtra(EXTRA_GROUP_ID, groupId);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_group);

        GroupFragment fragment = (GroupFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (fragment == null) {
            fragment = GroupFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }
        new GroupPresenter(fragment,
                getIntent().getIntExtra(EXTRA_GROUP_ID, -1),
                new SaveGroupUseCase(GroupRepository.getInstance()),
                new GetCustomerAddressNameUseCase(PersonRepository.getInstance(), PostalCodeRepository.getInstance()),
                new GetGroupUseCase(GroupRepository.getInstance()),
                new DeleteGroupUseCase(GroupRepository.getInstance()));
    }

}
