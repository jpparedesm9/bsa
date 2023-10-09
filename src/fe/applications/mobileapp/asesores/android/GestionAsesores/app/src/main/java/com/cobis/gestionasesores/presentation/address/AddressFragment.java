package com.cobis.gestionasesores.presentation.address;

import android.Manifest;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.provider.Settings;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.InputFilter;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.widgets.CustomMapView;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.searchablespinner.SearchableSpinner;
import com.github.chrisbanes.photoview.PhotoView;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;

public class AddressFragment extends Fragment implements AddressContract.View, OnMapReadyCallback {
    @BindView(R.id.input_name)
    TextInputEditText mStreetEditText;
    @BindView(R.id.input_number)
    TextInputEditText mNumberEditText;
    @BindView(R.id.input_internal_number)
    TextInputEditText mInternalNumberEditText;
    @BindView(R.id.input_postal_code)
    TextInputEditText mPostalCodeEditText;
    @BindView(R.id.input_city_text)
    TextInputEditText mCityEditText;

    @BindView(R.id.input_layout_street)
    TextInputLayout mStreetInputLayout;
    @BindView(R.id.input_layout_number)
    TextInputLayout mNumberInputLayout;
    @BindView(R.id.input_layout_postal_code)
    TextInputLayout mPostalCodeInputLayout;
    @BindView(R.id.input_layout_city)
    TextInputLayout mCityInputLayout;

    @BindView(R.id.spinner_state)
    SearchableSpinner mStatesSpinner;
    @BindView(R.id.spinner_town)
    SearchableSpinner mTownsSpinner;
    @BindView(R.id.spinner_village)
    SearchableSpinner mVillagesSpinner;
    @BindView(R.id.center_map)
    Button mCenterMap;

    Marker marker;

    private GoogleMap mMap;
    private LocationManager locationManager;
    private Location locationUser;
    private CustomMapView mapView;
    private Location markLocation;

    private PostalCodeAdapter mStatesAdapter;
    private PostalCodeAdapter mTownsAdapter;
    private PostalCodeAdapter mVillagesAdapter;
    private AddressContract.Presenter mPresenter;
    protected ProgressDialog mProgressDialog;

    private final int REQUEST_ENABLE_GPS = 1;

    public static AddressFragment newInstance() {
        Bundle args = new Bundle();
        AddressFragment fragment = new AddressFragment();
        fragment.setArguments(args);
        return fragment;
    }

    public AddressFragment() {
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_address, container, false);
        ButterKnife.bind(this, view);

//        SupportMapFragment mapFragment = (SupportMapFragment) getChildFragmentManager().findFragmentById(R.id.map);
//        mapFragment.getMapAsync(this);
        mapView = view.findViewById(R.id.custom_map);
        mapView.onCreate(savedInstanceState);
        mapView.getMapAsync(this);
        return view;

    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        int cityMaxLength = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.CITY_MAX_LENGTH);
        mCityEditText.setFilters(new InputFilter[]{new InputFilter.LengthFilter(cityMaxLength), new RegexInputFilter(RegexInputFilter.REGEX_ONLY_LETTERS)});

        mStatesSpinner.setTitle(getString(R.string.address_dialog_state));
        mStatesSpinner.setPositiveButton(getString(R.string.action_cancel));
        mStatesSpinner.setOnItemSelectedListener(mItemSelectedListener);

        mTownsSpinner.setTitle(getString(R.string.address_dialog_town));
        mTownsSpinner.setPositiveButton(getString(R.string.action_cancel));
        mTownsSpinner.setOnItemSelectedListener(mItemSelectedListener);

        mStreetEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_LETTERS_AND_NUMBERS), new InputFilter.AllCaps()});
        mCityEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_LETTERS_AND_NUMBERS), new InputFilter.AllCaps()});

        mVillagesSpinner.setTitle(getString(R.string.address_dialog_village));
        mVillagesSpinner.setPositiveButton(getString(R.string.action_cancel));
        mVillagesSpinner.setOnItemSelectedListener(mItemSelectedListener);

        mPostalCodeEditText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                mPostalCodeEditText.removeTextChangedListener(this);
                String value = s.toString().trim();
                int postalCodeLength = getResources().getInteger(R.integer.postal_code_length);
                if (mPostalCodeEditText.getTag() == null && mPostalCodeEditText.hasFocus()) {
                    if (value.length() == postalCodeLength) {
                        mPresenter.onSearchAddress(value);
                    } else {
                        mStatesSpinner.setEnabled(true);
                        mTownsSpinner.setEnabled(true);
                        mPresenter.resetSearch();
                    }
                }
                mPostalCodeEditText.addTextChangedListener(this);
            }
        });

        mCenterMap.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mPresenter.centerMapByAddress(buildAddersData());
            }
        });
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_ENABLE_GPS && resultCode == Activity.RESULT_CANCELED) {
            runLocationManager();
        }
    }


    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_section, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_section:
                if (locationManager == null || markLocation == null)
                    return false;
                mPresenter.onClickFinish(buildAddersData(), locationUser, markLocation);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onResume() {
        mapView.onResume();
        super.onResume();
        mPresenter.start();
    }

    @Override
    public void onPause() {
        mapView.onPause();
        super.onPause();
    }

    @Override
    public void onDestroy() {
        mapView.onDestroy();
        super.onDestroy();
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        mapView.onLowMemory();
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        if (ActivityCompat.checkSelfPermission(Objects.requireNonNull(getContext()), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            Objects.requireNonNull(getActivity()).finish();
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


    @Override
    public void setPresenter(AddressContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showStates(final List<PostalCode> states, final int selectPosition) {
        mStatesAdapter = new PostalCodeAdapter(getContext(), states, R.string.address_hint_state);
        mStatesSpinner.setAdapter(mStatesAdapter);
        if (selectPosition != -1) {
            mStatesSpinner.setSelection(selectPosition + 1);
        }
    }

    @Override
    public void showTowns(List<PostalCode> towns, int selectPosition) {
        mTownsAdapter = new PostalCodeAdapter(getContext(), towns, R.string.address_hint_town);
        mTownsSpinner.setAdapter(mTownsAdapter);
        if (selectPosition != -1) {
            mTownsSpinner.setSelection(selectPosition + 1);
        }
    }

    @Override
    public void showVillages(List<PostalCode> villages, int selectPosition) {
        mVillagesAdapter = new PostalCodeAdapter(getContext(), villages, R.string.address_hint_village);
        mVillagesSpinner.setAdapter(mVillagesAdapter);
        if (selectPosition != -1) {
            mVillagesSpinner.setSelection(selectPosition + 1);
        }
    }

    @Override
    public void setAddress(AddressData data) {
        mStreetEditText.setText(data.getStreet());
        mStreetEditText.setSelection(mStreetEditText.getText().length());
        mCityEditText.setText(data.getCity());
        mPostalCodeEditText.setText(data.getPostalCode());
        mNumberEditText.setText(data.getNumber() > 0 ? String.valueOf(data.getNumber()) : null);
        mInternalNumberEditText.setText(data.getInternalNumber() > 0 ? String.valueOf(data.getInternalNumber()) : null);
        mStreetEditText.requestFocus();
    }

    @Override
    public void clearError() {
        mStreetInputLayout.setErrorEnabled(false);
        mNumberInputLayout.setErrorEnabled(false);
        mCityInputLayout.setErrorEnabled(false);
        mPostalCodeInputLayout.setErrorEnabled(false);
        mStatesAdapter.clearError();
        mTownsAdapter.clearError();
        mVillagesAdapter.clearError();
    }

    @Override
    public void showStreetError() {
        mStreetInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showCityError() {
        mCityInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showDistanceError() {
        Toast.makeText(getContext(), R.string.geo_reference_error_pin_to_far, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showNumberError() {
        mNumberInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showPostalCodeError() {
        mPostalCodeInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showSateError() {
        mStatesAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTownError() {
        mTownsAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showVillageError() {
        mVillagesAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void hideProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showSaveProgress() {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(R.string.progress_save_msg));
            mProgressDialog.setCancelable(false);
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.show();
        }
    }

    @Override
    public void centerMapOnLocationData(LocationData locationData) {
        mMap.moveCamera(CameraUpdateFactory.newLatLng(new LatLng(locationData.getLatitude(),locationData.getLongitude())));
        mMap.animateCamera(CameraUpdateFactory.zoomTo(18));
        LatLng latLng = new LatLng(locationData.getLatitude(), locationData.getLongitude());
        if (marker == null){
            if (mMap != null){
                addMarker(latLng);
            }else {
                Toast.makeText(getContext(), R.string.address_invalid_map, Toast.LENGTH_LONG).show();
//                mapView.setVisibility(View.GONE);
            }
        }else {
            marker.setPosition(latLng);
        }
    }

    public void addMarker(LatLng latLng){
        marker = mMap.addMarker(new MarkerOptions().position(latLng));
        mMap.moveCamera(CameraUpdateFactory.newLatLng(latLng));
        mMap.animateCamera(CameraUpdateFactory.zoomTo(18));
        mMap.setOnCameraMoveListener(new GoogleMap.OnCameraMoveListener() {
            @Override
            public void onCameraMove() {
                marker.setPosition(mMap.getCameraPosition().target);
                markLocation = new Location(LocationManager.GPS_PROVIDER);
                markLocation.setLatitude(mMap.getCameraPosition().target.latitude);
                markLocation.setLongitude(mMap.getCameraPosition().target.longitude);
            }
        });
    }

    @Override
    public void sendResult(AddressData addressData) {
        Intent intent = new Intent();
        intent.putExtra(AddressActivity.EXTRA_ADDRESS, addressData);
        getActivity().setResult(Activity.RESULT_OK, intent);
        getActivity().finish();
    }

    @Override
    public void showMap(String path) {

    }

    @Override
    public void setStaticState(PostalCode postalCode) {
        mStatesAdapter = new PostalCodeAdapter(getContext(), new ArrayList<PostalCode>(), R.string.address_hint_state, false);
        mStatesAdapter.setUniqueResult(postalCode);

        mStatesSpinner.setAdapter(mStatesAdapter);
        mStatesSpinner.setSelection(0);
        mStatesSpinner.setEnabled(false);
    }

    @Override
    public void setStaticTown(PostalCode postalCode) {
        mTownsAdapter = new PostalCodeAdapter(getContext(), new ArrayList<PostalCode>(), R.string.address_hint_town, false);
        mTownsAdapter.setUniqueResult(postalCode);

        mTownsSpinner.setAdapter(mTownsAdapter);
        mTownsSpinner.setSelection(0);
        mTownsSpinner.setEnabled(false);
    }

    @Override
    public void showMapVisor(final String path) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getContext());
        builder.setPositiveButton(R.string.action_accept, null);
        AlertDialog dialog = builder.create();
        View visorLayout = getActivity().getLayoutInflater().inflate(R.layout.dialog_image_visor, null);
        final PhotoView imageView = (PhotoView) visorLayout.findViewById(R.id.image);
        imageView.setScaleType(ImageView.ScaleType.FIT_XY);
        Picasso.with(getContext()).load(path).into(imageView);
        dialog.setView(visorLayout);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.show();
    }

    @Override
    public void showInvalidAddress() {
        Toast.makeText(getContext(), R.string.address_invalid_path, Toast.LENGTH_LONG).show();
    }


    private AdapterView.OnItemSelectedListener mItemSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
            switch (parent.getId()) {
                case R.id.spinner_state:
                    if (mStatesSpinner.isEnabled()) {
                        mPresenter.onStateSelected(mStatesAdapter.getItem(pos));
                    }
                    break;
                case R.id.spinner_town:
                    if (mTownsSpinner.isEnabled()) {
                        mPresenter.onTownSelected(mTownsAdapter.getItem(pos));
                    }
                    break;
                case R.id.spinner_village:
                    String postalCode = StringUtils.nullToString(mVillagesAdapter.getItem(pos).getPostalCode());
                    if (postalCode.length() > 0) {
                        //way to know if text was entered by app
                        mPostalCodeEditText.setTag("app");
                        mPostalCodeEditText.setText(postalCode);
                        mPostalCodeEditText.setSelection(mPostalCodeEditText.getText().length());
                        mPostalCodeEditText.setTag(null);
                    }
                    if (StringUtils.isNotEmpty(postalCode)) {
                        mPresenter.onClickShowInMap(buildAddersData());
                    } else {
                        //mMapImage.setImageResource(R.drawable.image_default_map);
                    }
                default:
                    break;
            }
        }

        @Override
        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    };

    private AddressData buildAddersData() {
        AddressData addressData = new AddressData();
        addressData.setStreet(mStreetEditText.getText().toString().trim());
        addressData.setCity(mCityEditText.getText().toString().trim());
        addressData.setPostalCode(mPostalCodeEditText.getText().toString().trim());
        addressData.setNumber(ConvertUtils.tryToInt(mNumberEditText.getText().toString().trim(), -1));
        addressData.setInternalNumber(ConvertUtils.tryToInt(mInternalNumberEditText.getText().toString().trim(), -1));

        if (mStatesSpinner.isEnabled() && mStatesSpinner.getSelectedItemPosition() > 0) {
            addressData.setStateName(mStatesAdapter.getItem(mStatesSpinner.getSelectedItemPosition()).getName());
            addressData.setStateCode(mStatesAdapter.getItem(mStatesSpinner.getSelectedItemPosition()).getCode());
        } else if (!mStatesSpinner.isEnabled() && mStatesSpinner.getSelectedItemPosition() == 0) {
            addressData.setStateName(mStatesAdapter.getItem(0).getName());
            addressData.setStateCode(mStatesAdapter.getItem(0).getCode());
        }

        if (mTownsSpinner.isEnabled() && mTownsSpinner.getSelectedItemPosition() > 0) {
            addressData.setTownName(mTownsAdapter.getItem(mTownsSpinner.getSelectedItemPosition()).getName());
            addressData.setTownCode(mTownsAdapter.getItem(mTownsSpinner.getSelectedItemPosition()).getCode());
        } else if (!mTownsSpinner.isEnabled() && mTownsSpinner.getSelectedItemPosition() == 0) {
            addressData.setTownName(mTownsAdapter.getItem(0).getName());
            addressData.setTownCode(mTownsAdapter.getItem(0).getCode());
        }

        if (mVillagesSpinner.getSelectedItemPosition() > 0) {
            addressData.setVillageName(mVillagesAdapter.getItem(mVillagesSpinner.getSelectedItemPosition()).getName());
            addressData.setVillageCode(mVillagesAdapter.getItem(mVillagesSpinner.getSelectedItemPosition()).getCode());
        }
        return addressData;
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
        AlertDialog.Builder alertDialog = new AlertDialog.Builder(Objects.requireNonNull(getContext()));
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
               Objects.requireNonNull(getActivity()).finish();
            } else {
                List<String> providers = Objects.requireNonNull(locationManager).getProviders(true);
                for (String provider : providers) {
                    locationUser = locationManager.getLastKnownLocation(provider);
                    if (locationUser != null) {
                        double latitude = locationUser.getLatitude();
                        double longitude = locationUser.getLongitude();

                        final LatLng latLng = new LatLng(latitude, longitude);
                        addMarker(latLng);
                        break;
                    }
                }
                mPresenter.tryCenterMapOnPosition();
            }
        }
    }
}
