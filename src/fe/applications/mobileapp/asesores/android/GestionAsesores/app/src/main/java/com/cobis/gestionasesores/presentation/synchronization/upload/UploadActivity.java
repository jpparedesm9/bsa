package com.cobis.gestionasesores.presentation.synchronization.upload;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.domain.usecases.GetPendingSyncItemCountUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class UploadActivity extends BaseActivity {

    private UploadContract.Presenter mPresenter;

    public static Intent newIntent(Context context) {
        return new Intent(context, UploadActivity.class);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_upload);

        UploadFragment fragment = (UploadFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if (fragment == null) {
            fragment = UploadFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }

        mPresenter = new UploadPresenter(fragment,new GetPendingSyncItemCountUseCase());
    }

    @Override
    public void onBackPressed() {
        mPresenter.onTryToExit();
    }
}
