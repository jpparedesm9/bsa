package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.requests.GetPersonsRequest;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.List;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class GetPersonsUseCase extends UseCase<GetPersonsRequest, List<Person>> {

    private PersonDataSource mPersonDataSource;

    public GetPersonsUseCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<List<Person>> createObservableUseCase(final GetPersonsRequest parameter) {
        return Observable.fromCallable(new Callable<List<Person>>() {
            @Override
            public List<Person> call() throws Exception {
                return mPersonDataSource.getAll(parameter);
            }
        });
    }
}
