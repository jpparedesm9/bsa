package com.cobis.gestionasesores.presentation.address;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.widget.Toast;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.domain.usecases.GetLocationUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

public class AddressActivity extends BaseActivity {
    public static final String EXTRA_ADDRESS= "ADDRESS_DATA";
    private final int PERMISSION_GPS = 1;

    public static Intent newIntent(Context context, AddressData addressData){
        Intent intent = new Intent(context,AddressActivity.class);
        intent.putExtra(EXTRA_ADDRESS, addressData);
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_address);

        checkPermissionGps();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode) {
            case PERMISSION_GPS:
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    loadFragment();
                } else {
                    Toast.makeText(this, getString(R.string.error_permission_gps), Toast.LENGTH_SHORT).show();
                    finish();
                }
                break;
            default:
                break;
        }
    }

    private void loadFragment() {
        AddressFragment fragment = (AddressFragment) getSupportFragmentManager().findFragmentById(R.id.content_fragment);
        if(fragment == null){
            fragment = AddressFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment,fragment).commit();
        }
        new AddressPresenter(fragment, (AddressData) getIntent().getSerializableExtra(EXTRA_ADDRESS), new GetLocationUseCase());
    }

    private void checkPermissionGps() {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            loadFragment();
        } else {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, PERMISSION_GPS);
        }
    }
}