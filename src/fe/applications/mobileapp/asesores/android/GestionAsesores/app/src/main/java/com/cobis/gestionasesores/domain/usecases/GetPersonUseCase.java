package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 7/24/2017.
 */

public class GetPersonUseCase extends UseCase<GetPersonUseCase.GetPersonRequest,Person> {

    private PersonDataSource mPersonDataSource;

    public GetPersonUseCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<Person> createObservableUseCase(final GetPersonRequest parameter) {
        return Observable.fromCallable(new Callable<Person>() {
            @Override
            public Person call() throws Exception {
                Person result;
                if(parameter.personId > 0) {
                    result = mPersonDataSource.getPerson(parameter.personId);
                    //refresh person sections
                    result = new Person.Builder().build(result);
                    mPersonDataSource.saveLocalPerson(result);
                }else{
                    result = new Person.Builder().setType(parameter.personType).build();
                }
                return result;
            }
        });
    }


    public static class GetPersonRequest{
        private int personId;
        private int personType;

        public GetPersonRequest(int personId,@PersonType int personType) {
            this.personId = personId;
            this.personType = personType;
        }
    }
}
