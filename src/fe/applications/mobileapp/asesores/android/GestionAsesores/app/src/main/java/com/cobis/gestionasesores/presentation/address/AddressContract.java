package com.cobis.gestionasesores.presentation.address;

import android.location.Location;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

/**
 * Created by mnaunay on 12/06/2017.
 */

public class AddressContract {
    public interface Presenter extends BasePresenter {
        void onStateSelected(PostalCode state);

        void onTownSelected(PostalCode town);

        void onClickFinish(AddressData addressData, Location gpsLocation, Location markLatlng);

        void onClickShowInMap(AddressData addressData);

        void onSearchAddress(String postalCode);

        void resetSearch();

        void onShowMapVisor(AddressData addressData);

        void tryCenterMapOnPosition();

        void centerMapByAddress(AddressData addressData);
    }

    public interface View extends BaseView<Presenter> {
        void showStates(List<PostalCode> states, int selectPosition);

        void showTowns(List<PostalCode> towns, int selectPosition);

        void showVillages(List<PostalCode> villages, int selectPosition);

        void setAddress(AddressData data);

        void clearError();

        void showNumberError();

        void showPostalCodeError();

        void showSateError();

        void showTownError();

        void showVillageError();

        void showStreetError();

        void showCityError();

        void showDistanceError();

        void sendResult(AddressData newAddressData);

        void showMap(String path);

        void setStaticState(PostalCode postalCode);

        void setStaticTown(PostalCode postalCode);

        void showMapVisor(String path);

        void showInvalidAddress();

        void hideProgress();

        void showSaveProgress();

        void centerMapOnLocationData(LocationData locationData);

    }
}
