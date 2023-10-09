package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.TerritorialOrganization;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.source.PostalCodeDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by mnaunay on 26/07/2017.
 */

public class GetAddressNameUseCase extends UseCase<AddressData,String> {
    private PostalCodeDataSource mPostalCodeDataSource;

    public GetAddressNameUseCase(PostalCodeDataSource dataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPostalCodeDataSource = dataSource;
    }

    @Override
    protected Observable<String> createObservableUseCase(final AddressData parameter) {
        return Observable.fromCallable(new Callable<String>() {
            @Override
            public String call() throws Exception {
                PostalCode state = mPostalCodeDataSource.getTerritorial(TerritorialOrganization.STATE,parameter.getStateCode());
                PostalCode town = mPostalCodeDataSource.getTerritorial(TerritorialOrganization.TOWN,parameter.getTownCode());
                PostalCode village = mPostalCodeDataSource.getTerritorial(TerritorialOrganization.VILLAGE,parameter.getVillageCode());
                return parameter.getStreet() + ", "+ village.getName() + ", "+ town.getName()+ ", "+state.getName();
            }
        });
    }
}