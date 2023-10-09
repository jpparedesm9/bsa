package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.PersonDataSource;
import com.cobis.gestionasesores.domain.businesslogic.PersonOperation;
import com.cobis.gestionasesores.domain.businesslogic.PersonValidator;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class ConvertToCustomerUserCase extends UseCase<Integer, ResultData> {
    private PersonDataSource mPersonDataSource;

    public ConvertToCustomerUserCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Integer personId) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                ResultData data = new PersonOperation().aquireCustomerInfo(personId);
                if (data.getType() == ResultType.SUCCESS) {
                    Person person = (Person) data.getData();
                    Person customer = PersonValidator.convertToToCustomer(person);
                    mPersonDataSource.saveLocalPerson(customer);
                    mPersonDataSource.applyPartnerInfo(customer);
                    data.setData(customer);
                }
                return data;
            }
        });
    }
}
