package com.cobis.gestionasesores.presentation.customers;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.GetPersonsUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 6/16/2017.
 */

public class SelectCustomerActivity extends BaseActivity {
    public static final String EXTRA_CUSTOMER = "com.cobis.gestionasesores.extras.CUSTOMER";
    public static final String EXTRA_SERVER_IDS = "com.cobis.gestionasesores.extras.EXTRA_SERVER_IDS";
    public static final String EXTRA_LOCAL_IDS = "com.cobis.gestionasesores.extras.EXTRA_LOCAL_IDS";
    public static final String EXTRA_MODE = "com.cobis.gestionasesores.extras.MODE";

    public static Intent newIntent(Context context, int[] serverIds, int[] localIds, @CustomersPresenter.Mode int mode) {
        Intent intent = new Intent(context, SelectCustomerActivity.class);
        intent.putExtra(EXTRA_SERVER_IDS, serverIds);
        intent.putExtra(EXTRA_LOCAL_IDS, localIds);
        intent.putExtra(EXTRA_MODE, mode);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select_customer);

        CustomersFragment fragment = (CustomersFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = CustomersFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }
        new CustomersPresenter(fragment,
                getIntent().getIntArrayExtra(EXTRA_SERVER_IDS),
                getIntent().getIntArrayExtra(EXTRA_LOCAL_IDS),
                getIntent().getIntExtra(EXTRA_MODE, -1),
                new GetPersonsUseCase(PersonRepository.getInstance()));
    }
}
