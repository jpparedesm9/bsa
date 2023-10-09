package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.infrastructure.GeocoderService;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by mnaunay on 07/08/2017.
 */

public class GetLocationUseCase extends UseCase<String,LocationData> {
    public GetLocationUseCase() {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
    }

    @Override
    protected Observable<LocationData> createObservableUseCase(final String parameter) {
        return Observable.fromCallable(new Callable<LocationData>() {
            @Override
            public LocationData call() throws Exception {
                return new GeocoderService().fromAddress(parameter);
            }
        });
    }
}
