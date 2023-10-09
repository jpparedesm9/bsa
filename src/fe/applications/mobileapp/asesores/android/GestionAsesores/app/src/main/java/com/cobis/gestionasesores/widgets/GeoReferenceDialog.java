package com.cobis.gestionasesores.widgets;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Intent;
import android.content.IntentSender;
import android.content.pm.PackageManager;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.R;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResult;
import com.google.android.gms.location.LocationSettingsStatusCodes;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GeoReferenceDialog extends DialogFragment implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener, LocationListener {

    private static final int REQUEST_CODE_GPS_SETTINGS = 1;
    private static final int REQUEST_LOCATION_PERMISSION = 2;
    private static final int SUCCESS_DELAY = 1000;

    @BindView(R.id.text_description)
    TextView mDescriptionText;
    @BindView(R.id.progress_bar)
    ProgressBar mProgressBar;
    @BindView(R.id.btn_cancel)
    Button mCancelBtn;
    @BindView(R.id.img_status)
    ImageView mStatusImg;

    private GoogleApiClient mGoogleApiClient;
    private LocationRequest mLocationRequest;

    private GeoReferenceListener mListener;

    final Handler mHandler = new Handler();

    public static GeoReferenceDialog newInstance() {
        Bundle args = new Bundle();
        GeoReferenceDialog fragment = new GeoReferenceDialog();
        fragment.setArguments(args);
        return fragment;
    }

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        View view = LayoutInflater.from(getContext()).inflate(R.layout.dialog_geo_reference, null, false);

        ButterKnife.bind(this, view);

        mCancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mListener != null) {
                    mListener.onCancel();
                }
                dismiss();
            }
        });

        mGoogleApiClient = new GoogleApiClient.Builder(getContext()).addConnectionCallbacks(this).addOnConnectionFailedListener(this).addApi(LocationServices.API).build();

        mLocationRequest = new LocationRequest();
        mLocationRequest.setNumUpdates(1);
        mLocationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);

        showLoading();

        return new AlertDialog.Builder(getContext())
                .setView(view)
                .setCancelable(false)
                .create();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mListener = null;
    }

    @Override
    public void onStart() {
        connectGoogleApiClient();
        super.onStart();
    }

    @Override
    public void onStop() {
        mGoogleApiClient.disconnect();
        super.onStop();
    }

    private void connectGoogleApiClient() {
        if (isPermissionGranted()) {
            if (!mGoogleApiClient.isConnected()) {
                mGoogleApiClient.connect();
            }
        } else {
            checkPermission();
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (REQUEST_LOCATION_PERMISSION == requestCode) {
            if (isPermissionGranted()) {
                connectGoogleApiClient();
            } else {
                showError(getString(R.string.error_no_permission));
            }
        }
    }

    @Override
    public void onConnected(@Nullable Bundle bundle) {
        checkLocationSettings();
    }

    @Override
    public void onConnectionSuspended(int i) {
        LocationServices.FusedLocationApi.removeLocationUpdates(mGoogleApiClient, this);
    }

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        showError(getString(R.string.geo_reference_error_google_play_services));
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE_GPS_SETTINGS) {
            if (resultCode != Activity.RESULT_OK) {
                showError(getString(R.string.geo_reference_error_gps));
            } else {
                startLocationUpdates();
            }
        }
    }

    @Override
    public void onLocationChanged(Location location) {
        locationFound(location.getLatitude(), location.getLongitude());
    }

    @SuppressWarnings({"MissingPermission"})
    private void startLocationUpdates() {
        showLoading();
        LocationServices.FusedLocationApi.requestLocationUpdates(mGoogleApiClient, mLocationRequest, this);
    }

    private void showError(String error) {
        mProgressBar.setVisibility(View.GONE);
        mStatusImg.setVisibility(View.VISIBLE);

        mStatusImg.setImageResource(R.drawable.ic_geo_error);
        mDescriptionText.setText(error);
    }

    private void showLoading() {
        mProgressBar.setVisibility(View.VISIBLE);
        mStatusImg.setVisibility(View.GONE);

        mDescriptionText.setText(R.string.geo_reference_loading);
    }

    private void showSuccess() {
        mProgressBar.setVisibility(View.GONE);
        mStatusImg.setVisibility(View.VISIBLE);

        mStatusImg.setImageResource(R.drawable.ic_geo_success);
        mDescriptionText.setText(R.string.geo_reference_success);
    }

    private void locationFound(final double lat, final double lng) {
        showSuccess();
        mHandler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (isAdded()) {
                    if (mListener != null) {
                        mListener.onLocationFound(lat, lng);
                    }
                    dismiss();
                }
            }
        }, SUCCESS_DELAY);
    }

    private void checkLocationSettings() {
        LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder().addLocationRequest(mLocationRequest).setAlwaysShow(true);

        PendingResult<LocationSettingsResult> result = LocationServices.SettingsApi.checkLocationSettings(mGoogleApiClient, builder.build());

        result.setResultCallback(new ResultCallback<LocationSettingsResult>() {
            @Override
            public void onResult(@NonNull LocationSettingsResult locationSettingsResult) {
                final Status status = locationSettingsResult.getStatus();
                switch (status.getStatusCode()) {
                    case LocationSettingsStatusCodes.SUCCESS:
                        startLocationUpdates();
                        break;
                    case LocationSettingsStatusCodes.RESOLUTION_REQUIRED:
                        try {
                            startIntentSenderForResult(status.getResolution().getIntentSender(), REQUEST_CODE_GPS_SETTINGS, null, 0, 0, 0, null);
                        } catch (IntentSender.SendIntentException e) {
                            Log.e("Error launching settings activity", e);
                            showError(getString(R.string.geo_reference_error_gps_settings));
                        }
                        break;
                    case LocationSettingsStatusCodes.SETTINGS_CHANGE_UNAVAILABLE:
                        showError(getString(R.string.geo_reference_error_gps_settings));
                        break;
                }
            }
        });
    }

    private void checkPermission() {
        requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, REQUEST_LOCATION_PERMISSION);
    }

    private boolean isPermissionGranted() {
        return ContextCompat.checkSelfPermission(getContext(), Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED;
    }

    public void setListener(GeoReferenceListener listener) {
        mListener = listener;
    }

    public interface GeoReferenceListener {
        void onLocationFound(double lat, double lng);

        void onCancel();
    }
}
