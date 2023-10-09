package com.cobis.gestionasesores.presentation.address;

import android.location.Location;
import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.TerritorialOrganization;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetLocationUseCase;
import com.cobis.gestionasesores.utils.GoogleMapsUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by mnaunay on 12/06/2017.
 */

public class AddressPresenter implements AddressContract.Presenter {
    @NonNull
    private AddressContract.View mAddView;
    private AddressData mAddressData;
    private boolean isInitialization;
    private List<PostalCode> mStates;
    private CatalogItem mDefaultCountry;
    private GetLocationUseCase mGetLocationUseCase;

    public AddressPresenter(@NonNull AddressContract.View addView, AddressData addressData, GetLocationUseCase getLocationUseCase) {
        mAddView = addView;
        mAddView.setPresenter(this);
        mAddressData = addressData;
        isInitialization = true;
        mGetLocationUseCase = getLocationUseCase;
    }

    @Override
    public void start() {
        loadDefaultCountry();
        if (mAddressData == null) {
            mAddressData = new AddressData();
        }
        mAddView.setAddress(mAddressData);
        loadStates();
    }

    private void loadStates() {
        if (mStates == null) {
            PostalCodeRepository.getInstance().getStates()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<List<PostalCode>>() {
                        @Override
                        public void onNext(@io.reactivex.annotations.NonNull List<PostalCode> postalCodes) {
                            int selected = searchPostalCodeByCode(postalCodes, mAddressData.getStateCode());
                            mStates = new ArrayList<>(postalCodes);
                            mAddView.showStates(postalCodes, selected);
                        }

                        @Override
                        public void onError(@io.reactivex.annotations.NonNull Throwable e) {

                        }

                        @Override
                        public void onComplete() {

                        }
                    });
        } else {
            mAddView.showStates(new ArrayList<>(mStates), -1);
        }
    }

    @Override
    public void onStateSelected(PostalCode state) {
        PostalCodeRepository.getInstance().getTowns(state.getId())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<PostalCode>>() {
                    @Override
                    public void onNext(@io.reactivex.annotations.NonNull List<PostalCode> postalCodes) {
                        int selected = isInitialization ? searchPostalCodeByCode(postalCodes, mAddressData.getTownCode()) : -1;
                        mAddView.showTowns(postalCodes, selected);
                    }

                    @Override
                    public void onError(@io.reactivex.annotations.NonNull Throwable e) {

                    }

                    @Override
                    public void onComplete() {

                    }
                });
    }

    @Override
    public void onTownSelected(PostalCode town) {
        PostalCodeRepository.getInstance().getVillages(town.getId())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<PostalCode>>() {
                    @Override
                    public void onNext(@io.reactivex.annotations.NonNull List<PostalCode> postalCodes) {
                        int selected = -1;
                        if (isInitialization) {
                            isInitialization = false;
                            selected = searchPostalCodeByCode(postalCodes, mAddressData.getVillageCode());
                        }
                        mAddView.showVillages(postalCodes, selected);
                    }

                    @Override
                    public void onError(@io.reactivex.annotations.NonNull Throwable e) {
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    @Override
    public void onClickFinish(final AddressData newAddressData, final Location gpsLocation, final Location markLatlng) {
        mAddView.clearError();
        if (isAddressValid(newAddressData, gpsLocation, markLatlng)) {
            newAddressData.setServerId(mAddressData != null?mAddressData.getServerId():0);
            mAddView.showSaveProgress();
            mAddView.hideProgress();

            LocationData locationData = new LocationData(markLatlng.getLatitude(),markLatlng.getLongitude());
            if(mAddressData != null && mAddressData.getLocationData() != null){
                locationData.setServerId(mAddressData.getLocationData().getServerId());
            }
            newAddressData.setLocationData(locationData);

            mAddView.sendResult(newAddressData);


//            mGetLocationUseCase.execute(getFullAddress(newAddressData), new DisposableObserver<LocationData>() {
//                @Override
//                public void onNext(@io.reactivex.annotations.NonNull LocationData locationData) {
//                    mAddView.hideProgress();
//                    if(mAddressData != null && mAddressData.getLocationData() != null){
//                        locationData.setServerId(mAddressData.getLocationData().getServerId());
//                        locationData.setLongitude(markLatlng.getLongitude());
//                        locationData.setLatitude(markLatlng.getLatitude());
//                    }
//                    newAddressData.setLocationData(locationData);
//
////                    LocationData officalLocationData = new LocationData(gpsLocation.getLatitude(), gpsLocation.getLongitude());
////                    officalLocationData.setServerId(locationData.getServerId());
////                    newAddressData.setOficialLocationData(officalLocationData);
//                    mAddView.sendResult(newAddressData);
//                }
//                @Override
//                public void onError(@io.reactivex.annotations.NonNull Throwable e) {
//                    mAddView.hideProgress();
//                    mAddView.sendResult(newAddressData);
//                }
//                @Override
//                public void onComplete() {
//
//                }
//            });
        }
    }

    @Override
    public void onClickShowInMap(AddressData addressData) {
        String path = buildMapAddress(addressData);
        if (path != null) {
            mAddView.showMap(path);
        } else {
            mAddView.showInvalidAddress();
        }
    }

    @Override
    public void onShowMapVisor(AddressData addressData) {
        String path = buildMapAddress(addressData);
        if (path != null) {
            mAddView.showMapVisor(path);
        } else {
            mAddView.showInvalidAddress();
        }
    }

    @Override
    public void onSearchAddress(String postalCode) {
        PostalCodeRepository.getInstance()
                .search(postalCode)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<String, Object>>() {
                    @Override
                    public void onNext(@NonNull Map<String, Object> result) {
                        mAddView.setStaticState((PostalCode) result.get(TerritorialOrganization.STATE));
                        mAddView.setStaticTown((PostalCode) result.get(TerritorialOrganization.TOWN));
                        mAddView.showVillages((List<PostalCode>) result.get(TerritorialOrganization.VILLAGE), 0);
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("Error onSearchAddress! ", e);
                    }

                    @Override
                    public void onComplete() {

                    }
                });
    }

    @Override
    public void resetSearch() {
        loadStates();
    }


    private boolean isAddressValid(AddressData addressData, Location gpsLocation, Location markLatlng) {
        boolean isValid = true;

//        if (gpsLocation.distanceTo(markLatlng) > ALLOWEDDISTANCE){
//            mAddView.showDistanceError();
//            isValid = false;
//        }

        if (StringUtils.isEmpty(addressData.getStreet().trim())) {
            mAddView.showStreetError();
            isValid = false;
        }

        if (addressData.getNumber() == -1) {
            mAddView.showNumberError();
            isValid = false;
        }

        if (StringUtils.isEmpty(addressData.getPostalCode())) {
            mAddView.showPostalCodeError();
            isValid = false;
        }

        if (StringUtils.isEmpty(addressData.getStateCode())) {
            mAddView.showSateError();
            isValid = false;
        }

        if (StringUtils.isEmpty(addressData.getTownCode())) {
            mAddView.showTownError();
            isValid = false;
        }
        if (StringUtils.isEmpty(addressData.getVillageCode())) {
            mAddView.showVillageError();
            isValid = false;
        }

        if (StringUtils.isEmpty(addressData.getCity().trim())){
            mAddView.showCityError();
            isValid=false;
        }

        return isValid;
    }

    private static int searchPostalCodeByCode(final List<PostalCode> postalCodes, String code) {
        int index = -1;
        for (int i = 0; i < postalCodes.size(); i++) {
            if (postalCodes.get(i).getCode().equalsIgnoreCase(code)) {
                index = i;
                break;
            }
        }
        return index;
    }

    private String buildMapAddress(AddressData addressData) {
        String fullAddress = getFullAddress(addressData);
        if(fullAddress != null){
           return  GoogleMapsUtil.getInstance().buildStaticMap(fullAddress, BuildConfig.MAP_API_KEY);
        }else{
            return null;
        }
    }

    private String getFullAddress(AddressData addressData){
        if (StringUtils.isNotEmpty(addressData.getStreet()) && StringUtils.isNotEmpty(addressData.getStateName()) && StringUtils.isNotEmpty(addressData.getTownName()) && StringUtils.isNotEmpty(addressData.getVillageName())) {
            String address = addressData.getStreet();
            address += ("," + addressData.getVillageName());
            address += ("," + addressData.getTownName());
            address += ("," + addressData.getStateName());
            address += ("," + (mDefaultCountry != null ? mDefaultCountry.getValue() : ""));
            return address;
        }else{
            return null;
        }
    }


    private void loadDefaultCountry() {
        CatalogRepository.getInstance()
                .getCatalogItemByItemCode(Catalog.CAT_COUNTRY, BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_COUNTRY))
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<CatalogItem>() {
                    @Override
                    public void onNext(@NonNull CatalogItem catalogItem) {
                        mDefaultCountry = catalogItem;
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.d("Error loadDefaultCountry! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }


    public void tryCenterMapOnPosition(){
        if (mAddressData != null){
            if (mAddressData.getLocationData() != null){
                if (mAddressData.getLocationData().getLongitude() == 0 && mAddressData.getLocationData().getLatitude() == 0)
                    return;
                    mAddView.centerMapOnLocationData(mAddressData.getLocationData());
            }
        }
    }

    @Override
    public void centerMapByAddress(final AddressData addressData) {
        mGetLocationUseCase.execute(getFullAddress(addressData), new DisposableObserver<LocationData>() {
            @Override
            public void onNext(@io.reactivex.annotations.NonNull LocationData locationData) {
                mAddView.hideProgress();
                mAddView.centerMapOnLocationData(locationData);
            }
            @Override
            public void onError(@io.reactivex.annotations.NonNull Throwable e) {
                mAddView.hideProgress();
            }
            @Override
            public void onComplete() {

            }
        });
    }
}