package com.cobis.gestionasesores.presentation.synchronization;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.repositories.SyncRepository;
import com.cobis.gestionasesores.domain.usecases.InitializeAppUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by bqtdesa02 on 9/1/2017.
 */

public class SynchronizationActivity extends BaseActivity {

    private static final String EXTRA_IS_FORCED_OPEN = "com.cobis.gestionasesores.extras_extra_is_forced_open";

    private SynchronizationContract.Presenter mPresenter;

    public static Intent newIntent(Context context, boolean isForcedOpen){
        Intent intent = new Intent(context, SynchronizationActivity.class);
        intent.putExtra(EXTRA_IS_FORCED_OPEN, isForcedOpen);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_synchronization);

        SynchronizationFragment fragment = (SynchronizationFragment) getSupportFragmentManager().findFragmentById(R.id.content_list);
        if(fragment == null){
            fragment = SynchronizationFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }

        mPresenter = new SynchronizationPresenter(fragment,
                new InitializeAppUseCase(SyncRepository.getInstance()),
                getIntent().getBooleanExtra(EXTRA_IS_FORCED_OPEN, false));
    }

    @Override
    public void onBackPressed() {
        mPresenter.onTryToExit();
    }
}
