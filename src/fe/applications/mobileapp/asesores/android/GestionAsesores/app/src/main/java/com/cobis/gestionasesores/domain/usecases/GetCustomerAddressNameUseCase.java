package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.source.PersonDataSource;
import com.cobis.gestionasesores.data.source.PostalCodeDataSource;

import io.reactivex.Observable;
import io.reactivex.ObservableEmitter;
import io.reactivex.ObservableOnSubscribe;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 8/4/2017.
 */

public class GetCustomerAddressNameUseCase extends UseCase<Member, String> {

    private PersonDataSource mPersonDataSource;
    private PostalCodeDataSource mPostalCodeDataSource;

    public GetCustomerAddressNameUseCase(PersonDataSource personDataSource, PostalCodeDataSource postalCodeDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
        mPostalCodeDataSource = postalCodeDataSource;
    }

    @Override
    protected Observable<String> createObservableUseCase(final Member parameter) {
        return Observable.create(new ObservableOnSubscribe<String>() {
            @Override
            public void subscribe(@NonNull final ObservableEmitter<String> emitter) throws Exception {
                Person person = mPersonDataSource.getPersonByServerId(parameter.getServerId());
                AddressData addressData = person.getLocation(parameter.getMeetingLocation());
                new GetAddressNameUseCase(mPostalCodeDataSource).execute(addressData, new DisposableObserver<String>() {
                    @Override
                    public void onNext(@NonNull String s) {
                        emitter.onNext(s);
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        emitter.onError(e);
                    }

                    @Override
                    public void onComplete() {
                        emitter.onComplete();
                    }
                });
            }
        });
    }
}
