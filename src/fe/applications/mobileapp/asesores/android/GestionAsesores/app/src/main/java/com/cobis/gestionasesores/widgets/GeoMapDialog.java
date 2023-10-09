package com.cobis.gestionasesores.widgets;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.provider.Settings;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.Toast;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

import java.util.List;
import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GeoMapDialog extends DialogFragment implements OnMapReadyCallback {

    private final int REQUEST_ENABLE_GPS = 1;

    @BindView(R.id.progress_bar)
    ProgressBar mProgressBar;
    @BindView(R.id.btn_cancel)
    Button mCancelBtn;
    @BindView(R.id.btn_validate)
    Button mAceptBtn;
    MapView mapView;

    private GeoReferenceListener mListener;
    private GeoReference questionLocation;
    private GoogleMap mMap;
    private LocationManager locationManager;
    private Location locationUser;
    private Location markLocation;
    private Question question;

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        View view = LayoutInflater.from(getContext()).inflate(R.layout.dialog_geo_map_reference, null, false);
        mapView = view.findViewById(R.id.custom_map);
        mapView.onCreate(savedInstanceState);
        mapView.getMapAsync(this);
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

        mAceptBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (markLocation!= null){
                    if (markLocation.distanceTo(locationUser) <= BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.ALLOWEDDISTANCE)){
                        Location questionNewLocation = new Location("");
                        questionNewLocation.setLatitude(questionLocation.getLatitude());
                        questionNewLocation.setLongitude(questionLocation.getLongitude());
                        if (markLocation.distanceTo(questionNewLocation) <= BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.ALLOWEDDISTANCE)){
                            mListener.gpsIsClose(question, markLocation, locationUser);
                            dismiss();
                        }else {
                            mListener.gpsIsFar();
                            Toast.makeText(getContext(), R.string.geo_reference_error_pin_to_far, Toast.LENGTH_LONG).show();
                        }
                    }else {
                        mListener.gpsIsFar();
                        Toast.makeText(getContext(), R.string.geo_reference_error_pin_to_far, Toast.LENGTH_LONG).show();
                    }
                }
            }
        });


        showLoading();

        return new AlertDialog.Builder(getContext())
                .setView(view)
                .setCancelable(false)
                .create();
    }

    private void showLoading() {
        mProgressBar.setVisibility(View.VISIBLE);
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        if (ActivityCompat.checkSelfPermission(Objects.requireNonNull(getContext()), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            askForPermitions();
        } else {
            mMap.setMyLocationEnabled(true);
            mMap.setMapType(GoogleMap.MAP_TYPE_NORMAL);
            mMap.getUiSettings().setZoomControlsEnabled(true);
            mMap.getUiSettings().setCompassEnabled(true);
            mMap.getUiSettings().setAllGesturesEnabled(true);
            mMap.getUiSettings().setMapToolbarEnabled(true);

            checkGps();
        }
    }

    private void askForPermitions() {
        requestPermissions(new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, 1);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 1){
            checkGps();
        }
    }

    public void setListener(GeoReferenceListener listener) {
        mListener = listener;
    }

    public void centerMapOnLocationData(GeoReference location) {
        //mMap.animateCamera(CameraUpdateFactory.zoomTo(18));
        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom( new LatLng(location.getLatitude(),location.getLongitude()), 18));
        //mMap.moveCamera(CameraUpdateFactory.newLatLng(new LatLng(location.getLatitude(),location.getLongitude())));
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ENABLE_GPS && resultCode == Activity.RESULT_CANCELED) {
            runLocationManager();
        }
    }

    private void checkGps() {
        locationManager = (LocationManager) Objects.requireNonNull(getActivity()).getSystemService(Context.LOCATION_SERVICE);
        boolean isGPSEnabled = Objects.requireNonNull(locationManager).isProviderEnabled(LocationManager.GPS_PROVIDER);
        if (isGPSEnabled) {
            runLocationManager();
        } else {
            showSettingsAlert();
        }
    }

    private void showSettingsAlert() {
        android.support.v7.app.AlertDialog.Builder alertDialog = new android.support.v7.app.AlertDialog.Builder(Objects.requireNonNull(getContext()));
        alertDialog.setTitle(R.string.title_dialog_gps_off);
        alertDialog.setMessage(R.string.text_dialog_gps_off);
        alertDialog.setCancelable(false);
        alertDialog.setPositiveButton(R.string.text_button_configuration, new DialogInterface.OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {
                Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                startActivityForResult(intent, REQUEST_ENABLE_GPS);
            }
        });

        alertDialog.show();
    }

    private void runLocationManager() {
        if (locationManager != null) {
            if (ActivityCompat.checkSelfPermission(Objects.requireNonNull(getContext()), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                askForPermitions();
            } else {
                List<String> providers = Objects.requireNonNull(locationManager).getProviders(true);
                for (String provider : providers) {
                    locationUser = locationManager.getLastKnownLocation(provider);
//                    if (locationUser != null) {
//                        double latitude = locationUser.getLatitude();
//                        double longitude = locationUser.getLongitude();
//
//                        final LatLng latLng = new LatLng(latitude, longitude);
//                        final Marker marker = mMap.addMarker(new MarkerOptions().position(latLng));
//                        mMap.moveCamera(CameraUpdateFactory.newLatLng(latLng));
//                        mMap.animateCamera(CameraUpdateFactory.zoomTo(18));
//                        mMap.setOnCameraMoveListener(new GoogleMap.OnCameraMoveListener() {
//                            @Override
//                            public void onCameraMove() {
//                                marker.setPosition(mMap.getCameraPosition().target);
//                                markLocation = new Location(LocationManager.GPS_PROVIDER);
//                                markLocation.setLatitude(mMap.getCameraPosition().target.latitude);
//                                markLocation.setLongitude(mMap.getCameraPosition().target.longitude);
//                            }
//                        });
                    break;
                }
                if (locationUser == null){
                    Toast.makeText(getContext(), R.string.geo_reference_error_gps_location, Toast.LENGTH_LONG).show();
                    dismiss();
                }
                centerMapOnPosition();
            }
        }
    }

    public void centerMapOnPosition(){
        mProgressBar.setVisibility(View.GONE);
        if (questionLocation != null){
            LatLng latLng= new LatLng(questionLocation.getLatitude(), questionLocation.getLongitude());
            final Marker marker = mMap.addMarker(new MarkerOptions().position(latLng));
            mMap.setOnCameraMoveListener(new GoogleMap.OnCameraMoveListener() {
                @Override
                public void onCameraMove() {
                    marker.setPosition(mMap.getCameraPosition().target);
                    markLocation = new Location(LocationManager.GPS_PROVIDER);
                    markLocation.setLatitude(mMap.getCameraPosition().target.latitude);
                    markLocation.setLongitude(mMap.getCameraPosition().target.longitude);
                }
            });
            centerMapOnLocationData(questionLocation);
            markLocation = new Location(LocationManager.GPS_PROVIDER);
            markLocation.setLatitude(marker.getPosition().latitude);
            markLocation.setLongitude(marker.getPosition().longitude);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        mapView.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
        mapView.onPause();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mapView.onDestroy();
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        mapView.onLowMemory();
    }

    public GeoMapDialog setQuestionLocation(GeoReference questionLocation) {
        this.questionLocation = questionLocation;
        return this;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public interface GeoReferenceListener {
        void gpsIsClose(Question question, Location markLocation, Location officialLocation);
        void gpsIsFar();
        void onCancel();
    }
}
